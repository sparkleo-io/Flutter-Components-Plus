import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'models/ble_device_model.dart';
import 'storage_manager.dart';

/// Enum representing BLE connection states
enum BLEConnectionState {
  disconnected,
  connecting,
  connected,
  disconnecting,
  error,
}

/// Enum representing BLE scan states
enum BLEScanState { idle, scanning, stopped, error }

/// Callback types for BLE events
typedef BLEDeviceFoundCallback = void Function(BLEDeviceModel device);
typedef BLEConnectionStateCallback = void Function(BLEConnectionState state);
typedef BLEScanStateCallback = void Function(BLEScanState state);
typedef BLEErrorCallback = void Function(String error);
typedef BLEServicesDiscoveredCallback =
    void Function(List<BLEServiceModel> services);

/// Manager class for BLE operations
class BLEManager {
  // Singleton instance
  static final BLEManager _instance = BLEManager._internal();
  factory BLEManager() => _instance;
  BLEManager._internal();

  // Stream controllers for events
  final StreamController<BLEDeviceModel> _deviceFoundController =
      StreamController<BLEDeviceModel>.broadcast();
  final StreamController<BLEConnectionState> _connectionStateController =
      StreamController<BLEConnectionState>.broadcast();
  final StreamController<BLEScanState> _scanStateController =
      StreamController<BLEScanState>.broadcast();
  final StreamController<String> _errorController =
      StreamController<String>.broadcast();
  final StreamController<List<BLEServiceModel>> _servicesDiscoveredController =
      StreamController<List<BLEServiceModel>>.broadcast();

  // Streams
  Stream<BLEDeviceModel> get deviceFoundStream => _deviceFoundController.stream;
  Stream<BLEConnectionState> get connectionStateStream =>
      _connectionStateController.stream;
  Stream<BLEScanState> get scanStateStream => _scanStateController.stream;
  Stream<String> get errorStream => _errorController.stream;
  Stream<List<BLEServiceModel>> get servicesDiscoveredStream =>
      _servicesDiscoveredController.stream;

  // Current state
  BLEConnectionState _connectionState = BLEConnectionState.disconnected;
  BLEScanState _scanState = BLEScanState.idle;
  BluetoothDevice? _connectedDevice;
  List<BLEDeviceModel> _discoveredDevices = [];
  List<BLEServiceModel> _discoveredServices = [];

  // Configuration
  Duration _scanDuration = const Duration(seconds: 10);
  bool _autoConnect = false;
  List<String> _deviceFilters = [];
  bool _usePrefs = false;
  bool _debugMode = false;
  bool _showAllDevices = false;
  bool _alwaysScan = false;
  bool _androidUsesFineLocation = true;
  bool _saveScanDevices = false;

  // Getters
  BLEConnectionState get connectionState => _connectionState;
  BLEScanState get scanState => _scanState;
  BluetoothDevice? get connectedDevice => _connectedDevice;
  List<BLEDeviceModel> get discoveredDevices =>
      List.unmodifiable(_discoveredDevices);
  List<BLEServiceModel> get discoveredServices =>
      List.unmodifiable(_discoveredServices);
  bool get isConnected => _connectionState == BLEConnectionState.connected;
  bool get isScanning => _scanState == BLEScanState.scanning;

  /// Initialize the BLE manager
  Future<void> initialize({
    Duration scanDuration = const Duration(seconds: 10),
    bool autoConnect = false,
    List<String> deviceFilters = const [],
    bool usePrefs = false,
    bool debugMode = false,
    bool showAllDevices = false,
    bool alwaysScan = false,
    bool androidUsesFineLocation = true,
    bool saveScanDevices = false,
  }) async {
    _scanDuration = scanDuration;
    _autoConnect = autoConnect;
    _deviceFilters = deviceFilters;
    _usePrefs = usePrefs;
    _debugMode = debugMode;
    _showAllDevices = showAllDevices;
    _alwaysScan = alwaysScan;
    _androidUsesFineLocation = androidUsesFineLocation;
    _saveScanDevices = saveScanDevices;

    // Initialize storage if using preferences
    if (_usePrefs) {
      await BLEStorageManager.initialize();
    }

    // Set up Bluetooth state listener
    FlutterBluePlus.adapterState.listen((state) {
      if (state == BluetoothAdapterState.off) {
        _emitError('Bluetooth is turned off');
        _updateScanState(BLEScanState.error);
        _updateConnectionState(BLEConnectionState.error);
      } else if (state == BluetoothAdapterState.on) {
        _updateScanState(BLEScanState.idle);
        _updateConnectionState(BLEConnectionState.disconnected);
      }
    });
  }

  /// Start scanning for BLE devices
  Future<void> startScan() async {
    try {
      if (_scanState == BLEScanState.scanning) {
        return;
      }

      _updateScanState(BLEScanState.scanning);

      // Only clear devices if not saving scan devices
      if (!_saveScanDevices) {
        _discoveredDevices.clear();
      }

      // Start scanning
      await FlutterBluePlus.startScan(
        timeout: _alwaysScan ? null : _scanDuration,
        androidUsesFineLocation: _androidUsesFineLocation,
      );

      // Listen for scan results
      FlutterBluePlus.scanResults.listen((results) {
        for (final result in results) {
          _handleScanResult(result);
        }
      });

      // Stop scanning after timeout (only if not always scanning)
      if (!_alwaysScan) {
        Timer(_scanDuration, () {
          if (_scanState == BLEScanState.scanning) {
            stopScan();
          }
        });
      }
    } catch (e) {
      _emitError('Failed to start scan: $e');
      _updateScanState(BLEScanState.error);
    }
  }

  /// Stop scanning for BLE devices
  Future<void> stopScan() async {
    try {
      if (_scanState != BLEScanState.scanning) {
        return;
      }

      await FlutterBluePlus.stopScan();
      _updateScanState(BLEScanState.stopped);

      // Save discovered devices if using preferences
      if (_usePrefs && _discoveredDevices.isNotEmpty) {
        await BLEStorageManager.saveScanHistory(_discoveredDevices);
      }
    } catch (e) {
      _emitError('Failed to stop scan: $e');
      _updateScanState(BLEScanState.error);
    }
  }

  /// Connect to a BLE device
  Future<void> connectToDevice(BLEDeviceModel device) async {
    try {
      if (_connectionState == BLEConnectionState.connected ||
          _connectionState == BLEConnectionState.connecting) {
        return;
      }

      _updateConnectionState(BLEConnectionState.connecting);

      // Find the BluetoothDevice
      final bluetoothDevice = BluetoothDevice.fromId(device.macAddress);

      // Connect to device
      await bluetoothDevice.connect();
      _connectedDevice = bluetoothDevice;

      // Listen for connection state changes
      bluetoothDevice.connectionState.listen((state) {
        switch (state) {
          case BluetoothConnectionState.connected:
            _updateConnectionState(BLEConnectionState.connected);
            _discoverServices(bluetoothDevice);
            break;
          case BluetoothConnectionState.disconnected:
            _updateConnectionState(BLEConnectionState.disconnected);
            _connectedDevice = null;
            _discoveredServices.clear();
            break;
          case BluetoothConnectionState.connecting:
            _updateConnectionState(BLEConnectionState.connecting);
            break;
          case BluetoothConnectionState.disconnecting:
            _updateConnectionState(BLEConnectionState.disconnecting);
            break;
        }
      });

      // Save connected device if using preferences
      if (_usePrefs) {
        await BLEStorageManager.saveConnectedDevice(device);
      }
    } catch (e) {
      _emitError('Failed to connect to device: $e');
      _updateConnectionState(BLEConnectionState.error);
    }
  }

  /// Disconnect from the current device
  Future<void> disconnectDevice() async {
    try {
      if (_connectedDevice == null) {
        return;
      }

      _updateConnectionState(BLEConnectionState.disconnecting);
      await _connectedDevice!.disconnect();
      _connectedDevice = null;
      _discoveredServices.clear();

      // Clear connected device from storage if using preferences
      if (_usePrefs) {
        await BLEStorageManager.clearConnectedDevice();
      }
    } catch (e) {
      _emitError('Failed to disconnect device: $e');
      _updateConnectionState(BLEConnectionState.error);
    }
  }

  /// Read characteristic value
  Future<List<int>?> readCharacteristic(
    String serviceUuid,
    String characteristicUuid,
  ) async {
    try {
      if (_connectedDevice == null) {
        throw Exception('No device connected');
      }

      final services = await _connectedDevice!.discoverServices();
      final service = services.firstWhere(
        (s) => s.uuid.toString() == serviceUuid,
        orElse: () => throw Exception('Service not found'),
      );

      final characteristic = service.characteristics.firstWhere(
        (c) => c.uuid.toString() == characteristicUuid,
        orElse: () => throw Exception('Characteristic not found'),
      );

      if (!characteristic.properties.read) {
        throw Exception('Characteristic does not support read');
      }

      return await characteristic.read();
    } catch (e) {
      _emitError('Failed to read characteristic: $e');
      return null;
    }
  }

  /// Write characteristic value
  Future<bool> writeCharacteristic(
    String serviceUuid,
    String characteristicUuid,
    List<int> value, {
    bool withoutResponse = false,
  }) async {
    try {
      if (_connectedDevice == null) {
        throw Exception('No device connected');
      }

      final services = await _connectedDevice!.discoverServices();
      final service = services.firstWhere(
        (s) => s.uuid.toString() == serviceUuid,
        orElse: () => throw Exception('Service not found'),
      );

      final characteristic = service.characteristics.firstWhere(
        (c) => c.uuid.toString() == characteristicUuid,
        orElse: () => throw Exception('Characteristic not found'),
      );

      if (withoutResponse) {
        if (!characteristic.properties.writeWithoutResponse) {
          throw Exception(
            'Characteristic does not support write without response',
          );
        }
        await characteristic.write(value, withoutResponse: true);
      } else {
        if (!characteristic.properties.write) {
          throw Exception('Characteristic does not support write');
        }
        await characteristic.write(value);
      }

      return true;
    } catch (e) {
      _emitError('Failed to write characteristic: $e');
      return false;
    }
  }

  /// Get saved devices
  Future<List<BLEDeviceModel>> getSavedDevices() async {
    if (_usePrefs) {
      return await BLEStorageManager.getDevices();
    } else {
      return _discoveredDevices;
    }
  }

  /// Get connected device
  Future<BLEDeviceModel?> getConnectedDevice() async {
    if (_usePrefs) {
      return await BLEStorageManager.getConnectedDevice();
    } else if (_connectedDevice != null) {
      return _discoveredDevices.firstWhere(
        (d) => d.macAddress == _connectedDevice!.remoteId.toString(),
        orElse: () => throw StateError(
          'Connected device not found in discovered devices',
        ),
      );
    }
    return null;
  }

  /// Handle scan result
  void _handleScanResult(ScanResult result) async {
    try {
      final device = BLEDeviceModel.fromBluetoothDevice(
        result.device,
        rssi: result.rssi,
        advertisementData: result.advertisementData.manufacturerData.map(
          (key, value) => MapEntry(key.toString(), value),
        ),
      );

      // Apply device filters if any (unless showAllDevices is enabled)
      if (_deviceFilters.isNotEmpty && !_showAllDevices) {
        final deviceName = device.name.toLowerCase();
        final deviceId = device.id.toLowerCase();
        final hasMatch = _deviceFilters.any(
          (filter) =>
              deviceName.contains(filter.toLowerCase()) ||
              deviceId.contains(filter.toLowerCase()),
        );

        // Debug logging
        if (_debugMode) {
          print('BLE Filter Debug:');
          print('  Device Name: "${device.name}"');
          print('  Device ID: "${device.id}"');
          print('  Filters: $_deviceFilters');
          print('  Has Match: $hasMatch');
        }

        if (!hasMatch) {
          if (_debugMode) {
            print('  ❌ Device filtered out (no match)');
          }
          return;
        } else {
          if (_debugMode) {
            print('  ✅ Device passed filter');
          }
        }
      }

      // Check if device already exists
      final existingIndex = _discoveredDevices.indexWhere(
        (d) => d.id == device.id,
      );
      if (existingIndex != -1) {
        // Update existing device
        _discoveredDevices[existingIndex] = device;
        if (_debugMode) {
          print('  🔄 Updated existing device: ${device.name} (${device.id})');
        }
      } else {
        // Add new device
        _discoveredDevices.add(device);
        // Only emit to stream when it's a new device
        _deviceFoundController.add(device);
        if (_debugMode) {
          print('  ➕ Added new device: ${device.name} (${device.id})');
        }
      }

      // Save device if enabled
      if (_saveScanDevices && _usePrefs) {
        await BLEStorageManager.saveDevice(device);
      }

      // Auto-connect if enabled and device matches criteria
      if (_autoConnect && _deviceFilters.isNotEmpty) {
        final deviceName = device.name.toLowerCase();
        final deviceId = device.id.toLowerCase();
        final hasMatch = _deviceFilters.any(
          (filter) =>
              deviceName.contains(filter.toLowerCase()) ||
              deviceId.contains(filter.toLowerCase()),
        );

        if (hasMatch && _connectionState == BLEConnectionState.disconnected) {
          connectToDevice(device);
        }
      }
    } catch (e) {
      _emitError('Error handling scan result: $e');
    }
  }

  /// Discover services for connected device
  Future<void> _discoverServices(BluetoothDevice device) async {
    try {
      final services = await device.discoverServices();
      _discoveredServices = services
          .map((service) => BLEServiceModel.fromBluetoothService(service))
          .toList();

      _servicesDiscoveredController.add(_discoveredServices);

      // Save device with services if using preferences
      if (_usePrefs) {
        final deviceModel = _discoveredDevices.firstWhere(
          (d) => d.macAddress == device.remoteId.toString(),
          orElse: () => BLEDeviceModel.fromBluetoothDevice(device),
        );

        final updatedDevice = deviceModel.copyWith(
          services: _discoveredServices,
          isConnected: true,
        );

        await BLEStorageManager.saveDevice(updatedDevice);
      }
    } catch (e) {
      _emitError('Failed to discover services: $e');
    }
  }

  /// Update connection state
  void _updateConnectionState(BLEConnectionState state) {
    _connectionState = state;
    _connectionStateController.add(state);
  }

  /// Update scan state
  void _updateScanState(BLEScanState state) {
    _scanState = state;
    _scanStateController.add(state);
  }

  /// Emit error
  void _emitError(String error) {
    _errorController.add(error);
    if (kDebugMode) {
      print('BLE Error: $error');
    }
  }

  /// Dispose resources
  void dispose() {
    _deviceFoundController.close();
    _connectionStateController.close();
    _scanStateController.close();
    _errorController.close();
    _servicesDiscoveredController.close();
  }

  /// Check if Bluetooth is available
  Future<bool> isBluetoothAvailable() async {
    try {
      final state = await FlutterBluePlus.adapterState.first;
      return state == BluetoothAdapterState.on;
    } catch (e) {
      return false;
    }
  }

  /// Turn on Bluetooth (Android only)
  Future<bool> turnOnBluetooth() async {
    try {
      if (Platform.isAndroid) {
        await FlutterBluePlus.turnOn();
        return true;
      }
      return false;
    } catch (e) {
      _emitError('Failed to turn on Bluetooth: $e');
      return false;
    }
  }

  /// Get Bluetooth adapter state
  Future<BluetoothAdapterState> getBluetoothState() async {
    try {
      return await FlutterBluePlus.adapterState.first;
    } catch (e) {
      _emitError('Failed to get Bluetooth state: $e');
      return BluetoothAdapterState.unknown;
    }
  }
}
