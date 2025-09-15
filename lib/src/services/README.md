# Services

This directory contains various services provided by the Flutter Components Plus package.

## Available Services

### FcpBleService

A service for managing Bluetooth Low Energy (BLE) operations, including permission checking and device control.

#### Features

- **Permission Checking**: Check if Bluetooth and location services are enabled
- **Device Control**: Turn on Bluetooth and location services directly from the app
- **Comprehensive Status**: Get detailed status of all BLE-related permissions
- **Location Service Control**: Turn on location services and request permissions separately

#### Usage

```dart
import 'package:flutter_components_plus/flutter_components_plus.dart';

// Get the service instance
final bleService = FcpBleService.instance;

// Check current permissions
final status = await bleService.checkPermissions();
print('Bluetooth: ${status.bluetoothOn}');
print('Location: ${status.locationOn}');
print('All Granted: ${status.allGranted}');

// Turn on Bluetooth
final bluetoothSuccess = await bleService.turnOnBluetooth();

// Turn on location services and request permission
final locationSuccess = await bleService.turnOnLocation();

// Turn on location services only (without requesting permission)
final locationServiceSuccess = await bleService.turnOnLocationService();

// Request location permission only (without turning on service)
final locationPermissionSuccess = await bleService.requestLocationPermission();

// Turn on all services at once
final allStatus = await bleService.turnOnAllServices();

// Request all permissions
final permissionStatus = await bleService.requestPermissions();
```

#### Methods

- `isBluetoothOn()`: Check if Bluetooth is turned on
- `isLocationOn()`: Check if location services are enabled (both service and permission)
- `isLocationServiceEnabled()`: Check if location services are enabled (service level only)
- `isLocationPermissionGranted()`: Check if location permission is granted
- `checkPermissions()`: Get comprehensive permission status
- `turnOnBluetooth()`: Attempt to turn on Bluetooth
- `turnOnLocation()`: Turn on location services AND request permission
- `turnOnLocationService()`: Turn on location services only (without requesting permission)
- `requestLocationPermission()`: Request location permission only (without turning on service)
- `turnOnAllServices()`: Enable both Bluetooth and location
- `requestPermissions()`: Request all necessary permissions

#### BlePermissionStatus

The service returns a `BlePermissionStatus` object with the following properties:

- `bluetoothOn`: Whether Bluetooth is enabled
- `locationOn`: Whether location services are enabled (both service and permission)
- `locationServiceEnabled`: Whether location services are enabled (service level only)
- `locationPermissionGranted`: Whether location permission is granted
- `allGranted`: Whether all required permissions are granted
- `error`: Any error message if an operation failed

### Other Services

- **FcpHttpService**: HTTP client for API requests
- **FcpStorageService**: Local data persistence using SharedPreferences
- **FcpLoggingService**: Comprehensive logging system

## Dependencies

The BLE service requires the following dependencies (already included in the package):

- `flutter_blue_plus`: For Bluetooth Low Energy operations
- `permission_handler`: For permission management
- `location`: For location service control and permission management

## Platform Requirements

### Android

The following permissions are required in `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-feature android:name="android.hardware.bluetooth_le" android:required="true" />
```

### iOS

The following permissions are required in `ios/Runner/Info.plist`:

```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>This app uses Bluetooth to connect to BLE devices.</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>This app uses Bluetooth to connect to BLE devices.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access for Bluetooth Low Energy scanning.</string>
```

## Example

See `flutter_component_plus_example/lib/ble_service_examples.dart` for a complete working example.
