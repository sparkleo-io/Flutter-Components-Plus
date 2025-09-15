import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location;

/// BLE service for managing Bluetooth Low Energy operations
class FcpBleService {
  FcpBleService._();

  static final FcpBleService _instance = FcpBleService._();
  static FcpBleService get instance => _instance;

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
