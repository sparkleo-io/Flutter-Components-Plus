import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'models/ble_device_model.dart';
import 'ble_manager.dart';
import 'permission_handler.dart';

/// BLE Service for programmatic usage without UI
class BLEService {
  static final BLEService _instance = BLEService._internal();
  factory BLEService() => _instance;
  BLEService._internal();

  final BLEManager _bleManager = BLEManager();

  bool _isInitialized = false;
  bool _permissionsGranted = false;

  // Streams
  Stream<BLEDeviceModel> get deviceFoundStream => _bleManager.deviceFoundStream;
  Stream<BLEConnectionState> get connectionStateStream =>
      _bleManager.connectionStateStream;
  Stream<BLEScanState> get scanStateStream => _bleManager.scanStateStream;
  Stream<List<BLEServiceModel>> get servicesDiscoveredStream =>
      _bleManager.servicesDiscoveredStream;
  Stream<String> get errorStream => _bleManager.errorStream;

  // Getters
  BLEConnectionState get connectionState => _bleManager.connectionState;
  BLEScanState get scanState => _bleManager.scanState;
  BluetoothDevice? get connectedDevice => _bleManager.connectedDevice;
  List<BLEDeviceModel> get discoveredDevices => _bleManager.discoveredDevices;
  List<BLEServiceModel> get discoveredServices =>
      _bleManager.discoveredServices;
  bool get isConnected => _bleManager.isConnected;
  bool get isScanning => _bleManager.isScanning;
  bool get isInitialized => _isInitialized;
  bool get permissionsGranted => _permissionsGranted;
  bool get isReconnectEnabled => _bleManager.isReconnectEnabled;
  int get reconnectAttempts => _bleManager.reconnectAttempts;
  int get maxReconnectAttempts => _bleManager.maxReconnectAttempts;
  int get requestedMtu => _bleManager.requestedMtu;
  int get currentMtu => _bleManager.currentMtu;

  /// Initialize the BLE service
  Future<bool> initialize({
    Duration scanDuration = const Duration(seconds: 10),
    bool autoConnect = false,
    List<String> deviceFilters = const [],
    bool usePrefs = false,
    bool debugMode = false,
    bool alwaysScan = false,
    bool androidUsesFineLocation = true,
    bool saveScanDevices = false,
    int requestedMtu = 23,
  }) async {
    try {
      // Check and request permissions (without context for programmatic usage)
      _permissionsGranted =
          await BLEPermissionHandler.areAllPermissionsGranted();
      if (!_permissionsGranted) {
        throw Exception(
          'Required permissions not granted. Please ensure Bluetooth and Location are enabled and permissions are granted.',
        );
      }

      // Initialize BLE manager
      await _bleManager.initialize(
        scanDuration: scanDuration,
        autoConnect: autoConnect,
        deviceFilters: deviceFilters,
        usePrefs: usePrefs,
        debugMode: debugMode,
        alwaysScan: alwaysScan,
        androidUsesFineLocation: androidUsesFineLocation,
        saveScanDevices: saveScanDevices,
        requestedMtu: requestedMtu,
      );

      _isInitialized = true;
      return true;
    } catch (e) {
      _isInitialized = false;
      rethrow;
    }
  }

  /// Initialize the BLE service with context for dialogs
  Future<bool> initializeWithContext(
    BuildContext context, {
    Duration scanDuration = const Duration(seconds: 10),
    bool autoConnect = false,
    List<String> deviceFilters = const [],
    bool usePrefs = false,
    bool debugMode = false,
    bool alwaysScan = false,
    bool androidUsesFineLocation = true,
    bool saveScanDevices = false,
    int requestedMtu = 23,
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
  }) async {
    try {
      // Check and request permissions with dialogs
      _permissionsGranted = await BLEPermissionHandler.ensureBLERequirements(
        context,
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
      );

      if (!_permissionsGranted) {
        throw Exception('Required permissions not granted');
      }

      // Initialize BLE manager
      await _bleManager.initialize(
        scanDuration: scanDuration,
        autoConnect: autoConnect,
        deviceFilters: deviceFilters,
        usePrefs: usePrefs,
        debugMode: debugMode,
        alwaysScan: alwaysScan,
        androidUsesFineLocation: androidUsesFineLocation,
        saveScanDevices: saveScanDevices,
        requestedMtu: requestedMtu,
      );

      _isInitialized = true;
      return true;
    } catch (e) {
      _isInitialized = false;
      rethrow;
    }
  }

  /// Start scanning for devices
  Future<void> startScan() async {
    if (!_isInitialized || !_permissionsGranted) {
      throw Exception('BLE service not initialized or permissions not granted');
    }
    await _bleManager.startScan();
  }

  /// Stop scanning for devices
  Future<void> stopScan() async {
    if (!_isInitialized) {
      throw Exception('BLE service not initialized');
    }
    await _bleManager.stopScan();
  }

  /// Connect to a device
  Future<void> connectToDevice(
    BLEDeviceModel device, {
    bool reconnect = false,
  }) async {
    if (!_isInitialized) {
      throw Exception('BLE service not initialized');
    }
    await _bleManager.connectToDevice(device, reconnect: reconnect);
  }

  /// Disconnect from current device
  Future<void> disconnectDevice() async {
    if (!_isInitialized) {
      throw Exception('BLE service not initialized');
    }
    await _bleManager.disconnectDevice();
  }

  /// Read characteristic value
  Future<List<int>?> readCharacteristic(
    String serviceUuid,
    String characteristicUuid,
  ) async {
    if (!_isInitialized || !isConnected) {
      throw Exception('BLE service not initialized or not connected');
    }
    return await _bleManager.readCharacteristic(
      serviceUuid,
      characteristicUuid,
    );
  }

  /// Write characteristic value
  Future<void> writeCharacteristic(
    String serviceUuid,
    String characteristicUuid,
    List<int> value,
  ) async {
    if (!_isInitialized || !isConnected) {
      throw Exception('BLE service not initialized or not connected');
    }
    await _bleManager.writeCharacteristic(
      serviceUuid,
      characteristicUuid,
      value,
    );
  }

  /// Get saved devices from preferences
  Future<List<BLEDeviceModel>> getSavedDevices() async {
    if (!_isInitialized) {
      throw Exception('BLE service not initialized');
    }
    return await _bleManager.getSavedDevices();
  }

  /// Stop reconnect attempts
  void stopReconnect() {
    if (!_isInitialized) {
      throw Exception('BLE service not initialized');
    }
    _bleManager.stopReconnect();
  }

  /// Request MTU size for connected device
  Future<bool> requestMtu(int mtuSize) async {
    if (!_isInitialized) {
      throw Exception('BLE service not initialized');
    }
    return await _bleManager.requestMtu(mtuSize);
  }

  /// Dispose resources
  Future<void> dispose() async {
    _bleManager.dispose();
    _isInitialized = false;
    _permissionsGranted = false;
  }
}
