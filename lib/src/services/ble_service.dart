import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location;

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

  /// Get current scan state
  BleScanState get scanState => _scanState;

  /// Stream of scan state changes
  Stream<BleScanState> get scanStateStream => _scanStateController.stream;

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

  /// Dispose resources
  void dispose() {
    _scanSubscription?.cancel();
    _scanTimeoutTimer?.cancel();
    _scanStateController.close();
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
