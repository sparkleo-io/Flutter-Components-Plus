import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import 'package:get/get.dart';

class BleLeoExampleController extends GetxController {
  final BLEService _bleService = BLEService();
  // State variables
  RxBool isInitialized = false.obs;
  RxBool isScanning = false.obs;
  RxBool isConnected = false.obs;
  RxList<BLEDeviceModel> devices = <BLEDeviceModel>[].obs;
  RxList<BLEServiceModel> services = <BLEServiceModel>[].obs;
  RxString error = "".obs;
  RxString connectionStatus = "".obs;

  // Stream subscriptions
  StreamSubscription<BLEDeviceModel>? deviceSubscription;
  StreamSubscription<BLEConnectionState>? connectionSubscription;
  StreamSubscription<BLEScanState>? scanSubscription;
  StreamSubscription<List<BLEServiceModel>>? servicesSubscription;
  StreamSubscription<String>? errorSubscription;

  /// Initialize BLE service with enhanced configuration
  Future<void> initializeBLE() async {
    try {
      // Cancel existing subscriptions first
      await _cancelSubscriptions();

      // Reset state
      isInitialized.value = false;
      isScanning.value = false;
      isConnected.value = false;
      devices.clear();
      services.clear();
      error.value = "";
      connectionStatus.value = "";

      // Only dispose if already initialized
      if (_bleService.isInitialized) {
        await _bleService.dispose();
      }
      final success = await _bleService.initializeWithContext(
        Get.context!,

        // scanDuration: const Duration(seconds: 15), // Longer scan duration
        autoConnect: false,
        deviceFilters: ["Leo"], // Filter for devices containing "Leo"
        usePrefs: false, // Enable SharedPreferences for device storage
        debugMode: true, // Enable debug logging
        alwaysScan: false, // Set to true for continuous scanning
        androidUsesFineLocation: false, // Use fine location for better accuracy
        saveScanDevices: false, // Automatically save discovered devices
        requestedMtu: 512, // MTU size for data transfer
        filterUnknownDevices: true, // Filter out unknown devices
        title: 'BLE Service Setup',
        message:
            'This example demonstrates BLE service with device filtering, automatic saving, and enhanced scanning options.',
        confirmText: 'Enable BLE',
        cancelText: 'Cancel',
      );

      if (success) {
        isInitialized.value = true;
        setupStreamSubscriptions();
        showSnackBar('BLE Service initialized successfully', Colors.green);
      }
    } catch (e) {
      error.value = 'Failed to initialize BLE: $e';
      showSnackBar('Failed to initialize BLE: $e', Colors.red);
    }
  }

  /// Start scanning
  Future<void> startScan() async {
    try {
      devices.clear();
      await _bleService.startScan();
      showSnackBar('Scanning started', Colors.blue);
    } catch (e) {
      showSnackBar('Failed to start scan: $e', Colors.red);
    }
  }

  /// Stop scanning
  Future<void> stopScan() async {
    try {
      await _bleService.stopScan();
      showSnackBar('Scanning stopped', Colors.orange);
    } catch (e) {
      showSnackBar('Failed to stop scan: $e', Colors.red);
    }
  }

  /// Clear all devices
  void clearDevices() {
    devices.clear();
    showSnackBar('Device list cleared', Colors.grey);
  }

  /// Connect to device
  Future<void> connectToDevice(BLEDeviceModel device) async {
    try {
      await _bleService.connectToDevice(device, reconnect: true);
      showSnackBar(
        'Connecting to ${device.name} with reconnect enabled',
        Colors.blue,
      );
    } catch (e) {
      showSnackBar('Failed to connect: $e', Colors.red);
    }
  }

  /// Disconnect from device
  Future<void> disconnectDevice() async {
    try {
      await _bleService.disconnectDevice();
      showSnackBar('Disconnected', Colors.orange);
    } catch (e) {
      showSnackBar('Failed to disconnect: $e', Colors.red);
    }
  }

  /// Stop reconnect attempts
  void stopReconnect() {
    try {
      _bleService.stopReconnect();
      showSnackBar('Reconnect attempts stopped', Colors.orange);
    } catch (e) {
      showSnackBar('Failed to stop reconnect: $e', Colors.red);
    }
  }

  /// Request MTU size
  Future<void> requestMtu(int mtuSize) async {
    try {
      final success = await _bleService.requestMtu(mtuSize);
      if (success) {
        showSnackBar('MTU successfully set to $mtuSize', Colors.green);
      } else {
        showSnackBar('Failed to set MTU to $mtuSize', Colors.red);
      }
    } catch (e) {
      showSnackBar('Failed to request MTU: $e', Colors.red);
    }
  }

  /// Get connection state text
  String getConnectionStateText(BLEConnectionState state) {
    switch (state) {
      case BLEConnectionState.disconnected:
        return 'Disconnected';
      case BLEConnectionState.connecting:
        return 'Connecting';
      case BLEConnectionState.connected:
        return 'Connected';
      case BLEConnectionState.disconnecting:
        return 'Disconnecting';
      case BLEConnectionState.error:
        return 'Error';
    }
  }

  /// Show snackbar
  void showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Cancel all stream subscriptions
  Future<void> _cancelSubscriptions() async {
    await deviceSubscription?.cancel();
    await connectionSubscription?.cancel();
    await scanSubscription?.cancel();
    await servicesSubscription?.cancel();
    await errorSubscription?.cancel();

    deviceSubscription = null;
    connectionSubscription = null;
    scanSubscription = null;
    servicesSubscription = null;
    errorSubscription = null;
  }

  /// Set up stream subscriptions
  void setupStreamSubscriptions() {
    deviceSubscription = _bleService.deviceFoundStream.listen((device) {
      devices.add(device);
      showSnackBar('Device found: ${device.name}', Colors.blue);
    });

    connectionSubscription = _bleService.connectionStateStream.listen((state) {
      isConnected.value = state == BLEConnectionState.connected;
      connectionStatus.value = getConnectionStateText(state);
      showSnackBar('Connection state: $connectionStatus', Colors.orange);
    });

    scanSubscription = _bleService.scanStateStream.listen((state) {
      isScanning.value = state == BLEScanState.scanning;
    });

    servicesSubscription = _bleService.servicesDiscoveredStream.listen((
      discoveredServices,
    ) {
      services.value = discoveredServices;
      showSnackBar(
        'Services discovered: ${discoveredServices.length}',
        Colors.purple,
      );
    });

    errorSubscription = _bleService.errorStream.listen((errorMessage) {
      error.value = errorMessage;
      showSnackBar('Error: $errorMessage', Colors.red);
    });
  }

  @override
  void onClose() {
    _cancelSubscriptions();
    _bleService.dispose();
    super.onClose();
  }
}
