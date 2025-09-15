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
- **BLE Scanning**: Scan for nearby BLE devices with configurable parameters
- **Device Filtering**: Filter scan results by name, RSSI, and other criteria
- **Real-time Updates**: Stream-based scan results with live device discovery

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

// BLE Scanning
final scanConfig = BleScanConfig(
  scanTimeout: Duration(seconds: 15),
  alwaysScan: false,
  useFineLocation: true,
  checkPermissionsBeforeScan: true,
  filters: ['MyDevice', 'Sensor'], // Device name filters
  debugMode: true, // Enable debug prints
  filterUnknownDevices: false, // Show unknown devices
);

// Start scanning
final scanState = await bleService.startScan(config: scanConfig);

// Listen to scan results
bleService.scanStateStream.listen((state) {
  print('Scan status: ${state.status}');
  print('Found ${state.devices.length} devices');
  for (final device in state.devices) {
    print('Device: ${device.deviceName} - RSSI: ${device.rssi}');
  }
});

// Stop scanning
await bleService.stopScan();

// Get filtered devices
final filteredDevices = bleService.getFilteredDevices(
  minRssi: -80,
  nameFilters: ['MyDevice'],
  excludeUnknown: true,
);
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
- `startScan(config)`: Start BLE scanning with configuration
- `stopScan()`: Stop BLE scanning
- `getFilteredDevices()`: Get filtered scan results
- `clearScanResults()`: Clear scan results
- `scanStateStream`: Stream of scan state changes

#### BlePermissionStatus

The service returns a `BlePermissionStatus` object with the following properties:

- `bluetoothOn`: Whether Bluetooth is enabled
- `locationOn`: Whether location services are enabled (both service and permission)
- `locationServiceEnabled`: Whether location services are enabled (service level only)
- `locationPermissionGranted`: Whether location permission is granted
- `allGranted`: Whether all required permissions are granted
- `error`: Any error message if an operation failed

#### BleScanConfig

Configuration for BLE scanning with the following properties:

- `scanTimeout`: Duration for scan timeout (default: 10 seconds)
- `alwaysScan`: Whether to continuously scan (default: false)
- `useFineLocation`: Use fine location for Android (default: true)
- `checkPermissionsBeforeScan`: Check permissions before starting scan (default: true)
- `filters`: List of device name filters (default: empty)
- `debugMode`: Enable debug prints (default: false)
- `filterUnknownDevices`: Filter out devices with unknown names (default: true)

#### BleScanResult

Represents a scanned BLE device with the following properties:

- `device`: BluetoothDevice object
- `rssi`: Signal strength
- `advertisementData`: Advertisement data from the device
- `timestamp`: When the device was discovered
- `deviceName`: Human-readable device name
- `deviceId`: Unique device identifier

#### BleScanState

Current state of BLE scanning with the following properties:

- `status`: Current scan status (idle, scanning, stopped, error)
- `devices`: List of discovered devices
- `error`: Error message if scan failed

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
