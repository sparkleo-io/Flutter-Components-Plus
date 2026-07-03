import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location;
import 'package:shared_preferences/shared_preferences.dart';

/// BLE service for managing Bluetooth Low Energy operations
class FcpBleService {
  FcpBleService._();

  static final FcpBleService _instance = FcpBleService._();
  static FcpBleService get instance => _instance;

  // Scan state management
  BleScanState _scanState = const BleScanState(
    status: BleScanStatus.idle,
    devices: [],
  );
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  Timer? _scanTimeoutTimer;
  final List<BleScanResult> _scannedDevices = [];
  final StreamController<BleScanState> _scanStateController =
      StreamController<BleScanState>.broadcast();

  // Connection state management
  BleConnectionState? _connectionState;
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;
  Timer? _connectionTimeoutTimer;
  final StreamController<BleConnectionState> _connectionStateController =
      StreamController<BleConnectionState>.broadcast();

  /// Get current scan state
  BleScanState get scanState => _scanState;

  /// Stream of scan state changes
  Stream<BleScanState> get scanStateStream => _scanStateController.stream;

  /// Get current connection state
  BleConnectionState? get connectionState => _connectionState;

  /// Stream of connection state changes
  Stream<BleConnectionState> get connectionStateStream =>
      _connectionStateController.stream;

  /// Check if Bluetooth is turned on
  Future<bool> isBluetoothOn() async {
    try {
      final adapterState = await FlutterBluePlus.adapterState.first;
      return adapterState == BluetoothAdapterState.on;
    } catch (e) {
      return false;
    }
  }

  /// Check if location services are enabled
  Future<bool> isLocationOn() async {
    try {
      final locationService = location.Location();
      final serviceEnabled = await locationService.serviceEnabled();
      final permissionGranted = await locationService.hasPermission();
      return serviceEnabled &&
          permissionGranted == location.PermissionStatus.granted;
    } catch (e) {
      return false;
    }
  }

  /// Check if location services are enabled (service level)
  Future<bool> isLocationServiceEnabled() async {
    try {
      final locationService = location.Location();
      return await locationService.serviceEnabled();
    } catch (e) {
      return false;
    }
  }

  /// Check if location permission is granted
  Future<bool> isLocationPermissionGranted() async {
    try {
      final locationService = location.Location();
      final permissionGranted = await locationService.hasPermission();
      return permissionGranted == location.PermissionStatus.granted;
    } catch (e) {
      return false;
    }
  }

  /// Check all required permissions for BLE operations
  Future<BlePermissionStatus> checkPermissions() async {
    try {
      final bluetoothOn = await isBluetoothOn();
      final locationOn = await isLocationOn();
      final locationServiceEnabled = await isLocationServiceEnabled();
      final locationPermissionGranted = await isLocationPermissionGranted();

      return BlePermissionStatus(
        bluetoothOn: bluetoothOn,
        locationOn: locationOn,
        allGranted: bluetoothOn && locationOn,
        locationServiceEnabled: locationServiceEnabled,
        locationPermissionGranted: locationPermissionGranted,
      );
    } catch (e) {
      return BlePermissionStatus(
        bluetoothOn: false,
        locationOn: false,
        allGranted: false,
        locationServiceEnabled: false,
        locationPermissionGranted: false,
        error: e.toString(),
      );
    }
  }

  /// Turn on Bluetooth
  Future<bool> turnOnBluetooth() async {
    try {
      final adapterState = await FlutterBluePlus.adapterState.first;

      if (adapterState == BluetoothAdapterState.on) {
        return true; // Already on
      }

      if (adapterState == BluetoothAdapterState.off) {
        // Request to turn on Bluetooth
        await FlutterBluePlus.turnOn();

        // Wait for Bluetooth to turn on (with timeout)
        final completer = Completer<bool>();
        late StreamSubscription subscription;

        subscription = FlutterBluePlus.adapterState.listen((state) {
          if (state == BluetoothAdapterState.on) {
            subscription.cancel();
            completer.complete(true);
          }
        });

        // Timeout after 10 seconds
        Timer(const Duration(seconds: 10), () {
          if (!completer.isCompleted) {
            subscription.cancel();
            completer.complete(false);
          }
        });

        return await completer.future;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  /// Turn on location services
  Future<bool> turnOnLocation() async {
    try {
      final locationService = location.Location();

      // First check if location services are enabled
      bool serviceEnabled = await locationService.serviceEnabled();
      if (!serviceEnabled) {
        // Request the user to enable location services
        serviceEnabled = await locationService.requestService();
        if (!serviceEnabled) {
          return false; // User declined to enable location services
        }
      }

      // Check if the app has permission to access location
      location.PermissionStatus permissionGranted = await locationService
          .hasPermission();
      if (permissionGranted == location.PermissionStatus.denied) {
        // Request permission to access location
        permissionGranted = await locationService.requestPermission();
        if (permissionGranted != location.PermissionStatus.granted) {
          return false; // User declined permission
        }
      }

      return true; // Both service enabled and permission granted
    } catch (e) {
      return false;
    }
  }

  /// Turn on location services only (without requesting permission)
  Future<bool> turnOnLocationService() async {
    try {
      final locationService = location.Location();

      // Check if location services are enabled
      bool serviceEnabled = await locationService.serviceEnabled();
      if (!serviceEnabled) {
        // Request the user to enable location services
        serviceEnabled = await locationService.requestService();
        return serviceEnabled;
      }

      return true; // Already enabled
    } catch (e) {
      return false;
    }
  }

  /// Request location permission only (without turning on service)
  Future<bool> requestLocationPermission() async {
    try {
      final locationService = location.Location();

      // Check if the app has permission to access location
      location.PermissionStatus permissionGranted = await locationService
          .hasPermission();
      if (permissionGranted == location.PermissionStatus.denied) {
        // Request permission to access location
        permissionGranted = await locationService.requestPermission();
        return permissionGranted == location.PermissionStatus.granted;
      }

      return permissionGranted == location.PermissionStatus.granted;
    } catch (e) {
      return false;
    }
  }

  /// Turn on both Bluetooth and location services
  Future<BlePermissionStatus> turnOnAllServices() async {
    try {
      final bluetoothResult = await turnOnBluetooth();
      final locationResult = await turnOnLocation();

      return BlePermissionStatus(
        bluetoothOn: bluetoothResult,
        locationOn: locationResult,
        allGranted: bluetoothResult && locationResult,
      );
    } catch (e) {
      return BlePermissionStatus(
        bluetoothOn: false,
        locationOn: false,
        allGranted: false,
        error: e.toString(),
      );
    }
  }

  /// Request all necessary permissions for BLE operations
  Future<BlePermissionStatus> requestPermissions() async {
    try {
      // Request location permission first
      final locationStatus = await Permission.location.request();

      // Check Bluetooth state
      final bluetoothOn = await isBluetoothOn();

      return BlePermissionStatus(
        bluetoothOn: bluetoothOn,
        locationOn: locationStatus == PermissionStatus.granted,
        allGranted: bluetoothOn && locationStatus == PermissionStatus.granted,
      );
    } catch (e) {
      return BlePermissionStatus(
        bluetoothOn: false,
        locationOn: false,
        allGranted: false,
        error: e.toString(),
      );
    }
  }

  /// Start BLE scanning with configuration
  Future<BleScanState> startScan({BleScanConfig? config}) async {
    try {
      final scanConfig = config ?? const BleScanConfig();

      // Check permissions before scan if requested
      if (scanConfig.checkPermissionsBeforeScan) {
        final permissionStatus = await checkPermissions();
        if (!permissionStatus.allGranted) {
          final errorState = BleScanState(
            status: BleScanStatus.error,
            devices: _scannedDevices,
            error:
                'Permissions not granted: ${permissionStatus.error ?? "Bluetooth or location not enabled"}',
          );
          _updateScanState(errorState);
          return errorState;
        }
      }

      // Stop any existing scan
      await stopScan();

      // Clear previous results
      _scannedDevices.clear();

      // Update scan state to scanning
      final scanningState = BleScanState(
        status: BleScanStatus.scanning,
        devices: _scannedDevices,
      );
      _updateScanState(scanningState);

      if (scanConfig.debugMode) {
        print('🔍 Starting BLE scan with config: $scanConfig');
      }

      // Start scanning
      await FlutterBluePlus.startScan(
        timeout: scanConfig.scanTimeout,
        withServices: [],
        androidUsesFineLocation: scanConfig.useFineLocation,
      );

      // Set up scan timeout timer
      _scanTimeoutTimer = Timer(scanConfig.scanTimeout, () {
        if (_scanState.status == BleScanStatus.scanning) {
          stopScan();
        }
      });

      // Listen to scan results
      _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        _handleScanResults(results, scanConfig);
      });

      return scanningState;
    } catch (e) {
      final errorState = BleScanState(
        status: BleScanStatus.error,
        devices: _scannedDevices,
        error: 'Failed to start scan: $e',
      );
      _updateScanState(errorState);
      return errorState;
    }
  }

  /// Stop BLE scanning
  Future<BleScanState> stopScan() async {
    try {
      // Cancel timeout timer
      _scanTimeoutTimer?.cancel();
      _scanTimeoutTimer = null;

      // Cancel scan subscription
      await _scanSubscription?.cancel();
      _scanSubscription = null;

      // Stop scanning
      await FlutterBluePlus.stopScan();

      // Update scan state to stopped
      final stoppedState = BleScanState(
        status: BleScanStatus.stopped,
        devices: _scannedDevices,
      );
      _updateScanState(stoppedState);

      return stoppedState;
    } catch (e) {
      final errorState = BleScanState(
        status: BleScanStatus.error,
        devices: _scannedDevices,
        error: 'Failed to stop scan: $e',
      );
      _updateScanState(errorState);
      return errorState;
    }
  }

  /// Handle scan results with filtering and debugging
  void _handleScanResults(List<ScanResult> results, BleScanConfig config) {
    for (final result in results) {
      final deviceName = result.device.platformName;

      // Filter unknown devices if requested
      if (config.filterUnknownDevices && deviceName.isEmpty) {
        continue;
      }

      // Apply name filters if specified
      if (config.filters.isNotEmpty) {
        bool matchesFilter = false;
        for (final filter in config.filters) {
          if (deviceName.toLowerCase().contains(filter.toLowerCase())) {
            matchesFilter = true;
            break;
          }
        }
        if (!matchesFilter) {
          continue;
        }
      }

      // Create scan result
      final bleScanResult = BleScanResult(
        device: result.device,
        rssi: result.rssi,
        advertisementData: result.advertisementData,
        timestamp: DateTime.now(),
      );

      // Check if device already exists and update or add
      final existingIndex = _scannedDevices.indexWhere(
        (device) => device.deviceId == bleScanResult.deviceId,
      );

      if (existingIndex >= 0) {
        _scannedDevices[existingIndex] = bleScanResult;
      } else {
        _scannedDevices.add(bleScanResult);
      }

      // Debug output
      if (config.debugMode) {
        print(
          '📱 Found BLE device: ${bleScanResult.deviceName} (${bleScanResult.deviceId}) - RSSI: ${bleScanResult.rssi}',
        );
      }
    }

    // Update scan state with new devices
    final updatedState = BleScanState(
      status: _scanState.status,
      devices: List.from(_scannedDevices),
    );
    _updateScanState(updatedState);
  }

  /// Update scan state and notify listeners
  void _updateScanState(BleScanState newState) {
    _scanState = newState;
    _scanStateController.add(newState);
  }

  /// Get filtered devices based on criteria
  List<BleScanResult> getFilteredDevices({
    int? minRssi,
    int? maxRssi,
    List<String>? nameFilters,
    bool excludeUnknown = true,
  }) {
    return _scannedDevices.where((device) {
      // RSSI filtering
      if (minRssi != null && device.rssi < minRssi) return false;
      if (maxRssi != null && device.rssi > maxRssi) return false;

      // Name filtering
      if (nameFilters != null && nameFilters.isNotEmpty) {
        bool matchesFilter = false;
        for (final filter in nameFilters) {
          if (device.deviceName.toLowerCase().contains(filter.toLowerCase())) {
            matchesFilter = true;
            break;
          }
        }
        if (!matchesFilter) return false;
      }

      // Unknown device filtering
      if (excludeUnknown && device.deviceName == 'Unknown Device') return false;

      return true;
    }).toList();
  }

  /// Clear scan results
  void clearScanResults() {
    _scannedDevices.clear();
    final clearedState = BleScanState(status: _scanState.status, devices: []);
    _updateScanState(clearedState);
  }

  /// Connect to a BLE device
  Future<BleConnectionState> connectToDevice(
    BluetoothDevice device, {
    BleConnectionConfig? config,
    String? storageKey,
  }) async {
    try {
      final connectionConfig = config ?? const BleConnectionConfig();

      // Update connection state to connecting
      final connectingState = BleConnectionState(
        status: BleConnectionStatus.connecting,
        device: device,
      );
      _updateConnectionState(connectingState);

      // Set up connection timeout
      _connectionTimeoutTimer = Timer(connectionConfig.timeout, () {
        if (_connectionState?.status == BleConnectionStatus.connecting) {
          disconnectFromDevice(device);
        }
      });

      // Listen to connection state changes
      _connectionSubscription = device.connectionState.listen((state) {
        _handleConnectionStateChange(
          device,
          state,
          connectionConfig,
          storageKey,
        );
      });

      // Connect to device
      await device.connect(
        license: License.nonprofit,
        timeout: connectionConfig.timeout,
        autoConnect: connectionConfig.autoConnect,
        mtu: connectionConfig.mtu,
      );

      return connectingState;
    } catch (e) {
      final errorState = BleConnectionState(
        status: BleConnectionStatus.error,
        device: device,
        error: 'Failed to connect: $e',
      );
      _updateConnectionState(errorState);
      return errorState;
    }
  }

  /// Disconnect from a BLE device
  Future<BleConnectionState> disconnectFromDevice(
    BluetoothDevice device,
  ) async {
    try {
      // Update connection state to disconnecting
      final disconnectingState = BleConnectionState(
        status: BleConnectionStatus.disconnecting,
        device: device,
      );
      _updateConnectionState(disconnectingState);

      // Cancel connection timeout
      _connectionTimeoutTimer?.cancel();
      _connectionTimeoutTimer = null;

      // Cancel connection subscription
      await _connectionSubscription?.cancel();
      _connectionSubscription = null;

      // Disconnect from device
      await device.disconnect();

      // Update connection state to disconnected
      final disconnectedState = BleConnectionState(
        status: BleConnectionStatus.disconnected,
        device: device,
      );
      _updateConnectionState(disconnectedState);

      return disconnectedState;
    } catch (e) {
      final errorState = BleConnectionState(
        status: BleConnectionStatus.error,
        device: device,
        error: 'Failed to disconnect: $e',
      );
      _updateConnectionState(errorState);
      return errorState;
    }
  }

  /// Handle connection state changes
  void _handleConnectionStateChange(
    BluetoothDevice device,
    BluetoothConnectionState state,
    BleConnectionConfig config,
    String? storageKey,
  ) {
    BleConnectionStatus status;
    String? error;
    int? mtu;

    switch (state) {
      case BluetoothConnectionState.connected:
        status = BleConnectionStatus.connected;
        mtu = config.mtu;
        // Save connected device if storage key is provided and saveDeviceOnConnect is true
        if (storageKey != null && config.saveDeviceOnConnect) {
          _saveConnectedDevice(storageKey, device, mtu);
        }
        break;
      case BluetoothConnectionState.disconnected:
        status = BleConnectionStatus.disconnected;
        // Remove device from storage if removeDeviceOnDisconnect is true
        if (storageKey != null && config.removeDeviceOnDisconnect) {
          removeConnectedDevice(storageKey);
        }
        break;
    }

    final connectionState = BleConnectionState(
      status: status,
      device: device,
      error: error,
      mtu: mtu,
    );
    _updateConnectionState(connectionState);
  }

  /// Update connection state and notify listeners
  void _updateConnectionState(BleConnectionState newState) {
    _connectionState = newState;
    _connectionStateController.add(newState);
  }

  /// Save connected device information to storage
  Future<void> _saveConnectedDevice(
    String storageKey,
    BluetoothDevice device,
    int? mtu,
  ) async {
    try {
      final deviceInfo = ConnectedDeviceInfo(
        deviceId: device.remoteId.toString(),
        deviceName: device.platformName.isNotEmpty
            ? device.platformName
            : 'Unknown Device',
        connectedAt: DateTime.now(),
        mtu: mtu,
      );

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final jsonString = deviceInfo
          .toJson()
          .entries
          .map((e) => '${e.key}=${e.value}')
          .join('&');
      await prefs.setString(storageKey, jsonString);
    } catch (e) {
      print('Failed to save connected device: $e');
    }
  }

  /// Save connected device information with custom key
  Future<bool> saveConnectedDevice(
    String storageKey,
    BluetoothDevice device, {
    int? mtu,
  }) async {
    try {
      await _saveConnectedDevice(storageKey, device, mtu);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get connected device information from storage
  Future<ConnectedDeviceInfo?> getConnectedDevice(String storageKey) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final deviceJsonString = prefs.getString(storageKey);

      if (deviceJsonString == null) {
        return null;
      }

      // Parse the JSON string
      final deviceJson = Map<String, dynamic>.from(
        Uri.splitQueryString(deviceJsonString),
      );

      return ConnectedDeviceInfo.fromJson(deviceJson);
    } catch (e) {
      print('Failed to get connected device: $e');
      return null;
    }
  }

  /// Remove connected device from storage
  Future<bool> removeConnectedDevice(String storageKey) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(storageKey);
    } catch (e) {
      return false;
    }
  }

  /// Get all connected device keys
  Future<List<String>> getAllConnectedDeviceKeys() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      return keys.where((key) => key.startsWith('ble_connected_')).toList();
    } catch (e) {
      return [];
    }
  }

  /// Get all stored connected devices
  Future<List<ConnectedDeviceInfo>> getAllStoredDevices() async {
    try {
      final keys = await getAllConnectedDeviceKeys();
      final devices = <ConnectedDeviceInfo>[];

      for (final key in keys) {
        final device = await getConnectedDevice(key);
        if (device != null) {
          devices.add(device);
        }
      }

      return devices;
    } catch (e) {
      return [];
    }
  }

  /// Discover all services and characteristics of a connected device
  Future<BleDiscoveryResult> discoverServices(BluetoothDevice device) async {
    try {
      // Check if device is connected
      final connectionState = await device.connectionState.first;
      if (connectionState != BluetoothConnectionState.connected) {
        return BleDiscoveryResult(
          device: device,
          services: [],
          error: 'Device is not connected',
        );
      }

      // Discover services
      final services = await device.discoverServices();
      final serviceInfos = <BleServiceInfo>[];

      for (final service in services) {
        final characteristics = <BleCharacteristicInfo>[];

        // Discover characteristics for each service
        for (final characteristic in service.characteristics) {
          final descriptors = <BluetoothDescriptor>[];

          // Get descriptors for each characteristic
          try {
            descriptors.addAll(characteristic.descriptors);
          } catch (e) {
            // Some characteristics may not have descriptors
            print('Failed to get descriptors for ${characteristic.uuid}: $e');
          }

          final characteristicInfo = BleCharacteristicInfo(
            characteristic: characteristic,
            uuid: characteristic.uuid.toString(),
            properties: characteristic.properties,
            descriptors: descriptors,
          );

          characteristics.add(characteristicInfo);
        }

        final serviceInfo = BleServiceInfo(
          service: service,
          uuid: service.uuid.toString(),
          isPrimary: service.isPrimary,
          characteristics: characteristics,
        );

        serviceInfos.add(serviceInfo);
      }

      return BleDiscoveryResult(device: device, services: serviceInfos);
    } catch (e) {
      return BleDiscoveryResult(
        device: device,
        services: [],
        error: 'Failed to discover services: $e',
      );
    }
  }

  /// Find a specific service by UUID
  Future<BleServiceInfo?> findService(
    BluetoothDevice device,
    String serviceUuid,
  ) async {
    try {
      final discoveryResult = await discoverServices(device);

      if (discoveryResult.error != null) {
        return null;
      }

      // Find service by UUID (case insensitive)
      final targetUuid = serviceUuid.toLowerCase();
      for (final service in discoveryResult.services) {
        if (service.uuid.toLowerCase() == targetUuid) {
          return service;
        }
      }

      return null;
    } catch (e) {
      print('Failed to find service $serviceUuid: $e');
      return null;
    }
  }

  /// Find a specific characteristic by UUID within a service
  Future<BleCharacteristicInfo?> findCharacteristic(
    BluetoothDevice device,
    String serviceUuid,
    String characteristicUuid,
  ) async {
    try {
      final service = await findService(device, serviceUuid);

      if (service == null) {
        return null;
      }

      // Find characteristic by UUID (case insensitive)
      final targetUuid = characteristicUuid.toLowerCase();
      for (final characteristic in service.characteristics) {
        if (characteristic.uuid.toLowerCase() == targetUuid) {
          return characteristic;
        }
      }

      return null;
    } catch (e) {
      print(
        'Failed to find characteristic $characteristicUuid in service $serviceUuid: $e',
      );
      return null;
    }
  }

  /// Find a specific characteristic by UUID across all services
  Future<BleCharacteristicInfo?> findCharacteristicInAllServices(
    BluetoothDevice device,
    String characteristicUuid,
  ) async {
    try {
      final discoveryResult = await discoverServices(device);

      if (discoveryResult.error != null) {
        return null;
      }

      // Search across all services
      final targetUuid = characteristicUuid.toLowerCase();
      for (final service in discoveryResult.services) {
        for (final characteristic in service.characteristics) {
          if (characteristic.uuid.toLowerCase() == targetUuid) {
            return characteristic;
          }
        }
      }

      return null;
    } catch (e) {
      print(
        'Failed to find characteristic $characteristicUuid in all services: $e',
      );
      return null;
    }
  }

  /// Get all characteristics for a specific service
  Future<List<BleCharacteristicInfo>> getServiceCharacteristics(
    BluetoothDevice device,
    String serviceUuid,
  ) async {
    try {
      final service = await findService(device, serviceUuid);
      return service?.characteristics ?? [];
    } catch (e) {
      print('Failed to get characteristics for service $serviceUuid: $e');
      return [];
    }
  }

  /// Get all services with a specific characteristic
  Future<List<BleServiceInfo>> getServicesWithCharacteristic(
    BluetoothDevice device,
    String characteristicUuid,
  ) async {
    try {
      final discoveryResult = await discoverServices(device);

      if (discoveryResult.error != null) {
        return [];
      }

      final servicesWithCharacteristic = <BleServiceInfo>[];
      final targetUuid = characteristicUuid.toLowerCase();

      for (final service in discoveryResult.services) {
        for (final characteristic in service.characteristics) {
          if (characteristic.uuid.toLowerCase() == targetUuid) {
            servicesWithCharacteristic.add(service);
            break; // Found the characteristic in this service, move to next service
          }
        }
      }

      return servicesWithCharacteristic;
    } catch (e) {
      print(
        'Failed to get services with characteristic $characteristicUuid: $e',
      );
      return [];
    }
  }

  /// Dispose resources
  void dispose() {
    _scanSubscription?.cancel();
    _scanTimeoutTimer?.cancel();
    _scanStateController.close();
    _connectionSubscription?.cancel();
    _connectionTimeoutTimer?.cancel();
    _connectionStateController.close();
  }
}

/// Status of BLE permissions
class BlePermissionStatus {
  const BlePermissionStatus({
    required this.bluetoothOn,
    required this.locationOn,
    required this.allGranted,
    this.locationServiceEnabled,
    this.locationPermissionGranted,
    this.error,
  });

  final bool bluetoothOn;
  final bool locationOn;
  final bool allGranted;
  final bool? locationServiceEnabled;
  final bool? locationPermissionGranted;
  final String? error;

  @override
  String toString() {
    return 'BlePermissionStatus(bluetoothOn: $bluetoothOn, locationOn: $locationOn, locationServiceEnabled: $locationServiceEnabled, locationPermissionGranted: $locationPermissionGranted, allGranted: $allGranted, error: $error)';
  }
}

/// Configuration for BLE scanning
class BleScanConfig {
  const BleScanConfig({
    this.scanTimeout = const Duration(seconds: 10),
    this.alwaysScan = false,
    this.useFineLocation = true,
    this.checkPermissionsBeforeScan = true,
    this.filters = const [],
    this.debugMode = false,
    this.filterUnknownDevices = true,
  });

  final Duration scanTimeout;
  final bool alwaysScan;
  final bool useFineLocation;
  final bool checkPermissionsBeforeScan;
  final List<String> filters; // Device name filters
  final bool debugMode;
  final bool filterUnknownDevices;

  @override
  String toString() {
    return 'BleScanConfig(scanTimeout: $scanTimeout, alwaysScan: $alwaysScan, useFineLocation: $useFineLocation, checkPermissionsBeforeScan: $checkPermissionsBeforeScan, filters: $filters, debugMode: $debugMode, filterUnknownDevices: $filterUnknownDevices)';
  }
}

/// BLE scan result
class BleScanResult {
  const BleScanResult({
    required this.device,
    required this.rssi,
    required this.advertisementData,
    required this.timestamp,
  });

  final BluetoothDevice device;
  final int rssi;
  final AdvertisementData advertisementData;
  final DateTime timestamp;

  String get deviceName =>
      device.platformName.isNotEmpty ? device.platformName : 'Unknown Device';
  String get deviceId => device.remoteId.toString();

  @override
  String toString() {
    return 'BleScanResult(deviceName: $deviceName, deviceId: $deviceId, rssi: $rssi, timestamp: $timestamp)';
  }
}

/// BLE scan status
enum BleScanStatus { idle, scanning, stopped, error }

/// BLE scan state
class BleScanState {
  const BleScanState({required this.status, required this.devices, this.error});

  final BleScanStatus status;
  final List<BleScanResult> devices;
  final String? error;

  @override
  String toString() {
    return 'BleScanState(status: $status, devicesCount: ${devices.length}, error: $error)';
  }
}

/// Configuration for BLE connection
class BleConnectionConfig {
  const BleConnectionConfig({
    this.timeout = const Duration(seconds: 35),
    this.mtu = 512,
    this.autoConnect = false,
    this.saveDeviceOnConnect = true,
    this.removeDeviceOnDisconnect = true,
  });

  final Duration timeout;
  final int? mtu;
  final bool autoConnect;
  final bool saveDeviceOnConnect;
  final bool removeDeviceOnDisconnect;

  @override
  String toString() {
    return 'BleConnectionConfig(timeout: $timeout, mtu: $mtu, autoConnect: $autoConnect, saveDeviceOnConnect: $saveDeviceOnConnect, removeDeviceOnDisconnect: $removeDeviceOnDisconnect)';
  }
}

/// BLE connection status
enum BleConnectionStatus {
  disconnected,
  connecting,
  connected,
  disconnecting,
  error,
}

/// BLE connection state
class BleConnectionState {
  const BleConnectionState({
    required this.status,
    required this.device,
    this.error,
    this.mtu,
  });

  final BleConnectionStatus status;
  final BluetoothDevice device;
  final String? error;
  final int? mtu;

  @override
  String toString() {
    return 'BleConnectionState(status: $status, device: ${device.platformName}, mtu: $mtu, error: $error)';
  }
}

/// Connected device information for storage
class ConnectedDeviceInfo {
  const ConnectedDeviceInfo({
    required this.deviceId,
    required this.deviceName,
    required this.connectedAt,
    this.mtu,
  });

  final String deviceId;
  final String deviceName;
  final DateTime connectedAt;
  final int? mtu;

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'deviceName': deviceName,
      'connectedAt': connectedAt.toIso8601String(),
      'mtu': mtu,
    };
  }

  factory ConnectedDeviceInfo.fromJson(Map<String, dynamic> json) {
    return ConnectedDeviceInfo(
      deviceId: json['deviceId'] as String,
      deviceName: json['deviceName'] as String,
      connectedAt: DateTime.parse(json['connectedAt'] as String),
      mtu: json['mtu'] as int?,
    );
  }

  @override
  String toString() {
    return 'ConnectedDeviceInfo(deviceId: $deviceId, deviceName: $deviceName, connectedAt: $connectedAt, mtu: $mtu)';
  }
}

/// BLE service information
class BleServiceInfo {
  const BleServiceInfo({
    required this.service,
    required this.uuid,
    required this.isPrimary,
    this.characteristics = const [],
  });

  final BluetoothService service;
  final String uuid;
  final bool isPrimary;
  final List<BleCharacteristicInfo> characteristics;

  @override
  String toString() {
    return 'BleServiceInfo(uuid: $uuid, isPrimary: $isPrimary, characteristicsCount: ${characteristics.length})';
  }
}

/// BLE characteristic information
class BleCharacteristicInfo {
  const BleCharacteristicInfo({
    required this.characteristic,
    required this.uuid,
    required this.properties,
    this.descriptors = const [],
  });

  final BluetoothCharacteristic characteristic;
  final String uuid;
  final CharacteristicProperties properties;
  final List<BluetoothDescriptor> descriptors;

  bool get canRead => properties.read;
  bool get canWrite => properties.write;
  bool get canWriteWithoutResponse => properties.writeWithoutResponse;
  bool get canNotify => properties.notify;
  bool get canIndicate => properties.indicate;

  @override
  String toString() {
    final propertyNames = <String>[];
    if (properties.read) propertyNames.add('read');
    if (properties.write) propertyNames.add('write');
    if (properties.writeWithoutResponse)
      propertyNames.add('writeWithoutResponse');
    if (properties.notify) propertyNames.add('notify');
    if (properties.indicate) propertyNames.add('indicate');
    return 'BleCharacteristicInfo(uuid: $uuid, properties: ${propertyNames.join(', ')})';
  }
}

/// Discovery result for services and characteristics
class BleDiscoveryResult {
  const BleDiscoveryResult({
    required this.device,
    required this.services,
    this.error,
  });

  final BluetoothDevice device;
  final List<BleServiceInfo> services;
  final String? error;

  @override
  String toString() {
    return 'BleDiscoveryResult(device: ${device.platformName}, servicesCount: ${services.length}, error: $error)';
  }
}
