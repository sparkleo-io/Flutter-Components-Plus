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
- **BLE Connection**: Connect to BLE devices with customizable timeout, MTU, and auto-connect
- **Device Persistence**: Save and retrieve connected device information
- **Connection Management**: Real-time connection state monitoring
- **Service Discovery**: Discover all services and characteristics of connected devices
- **Characteristic Discovery**: Find specific services and characteristics by UUID
- **Comprehensive Information**: Get detailed service and characteristic properties

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

// BLE Connection
final connectionConfig = BleConnectionConfig(
  timeout: Duration(seconds: 35),
  mtu: 512,
  autoConnect: false,
  saveDeviceOnConnect: true,
  removeDeviceOnDisconnect: true,
);

// Connect to a device
final connectionState = await bleService.connectToDevice(
  device,
  config: connectionConfig,
  storageKey: 'my_device_key',
);

// Listen to connection state changes
bleService.connectionStateStream.listen((state) {
  print('Connection status: ${state.status}');
  print('Connected to: ${state.device.platformName}');
  print('MTU: ${state.mtu}');
});

// Disconnect from device
await bleService.disconnectFromDevice(device);

// Save connected device manually
await bleService.saveConnectedDevice('my_device_key', device, mtu: 512);

// Get saved device information
final savedDevice = await bleService.getConnectedDevice('my_device_key');
if (savedDevice != null) {
  print('Saved device: ${savedDevice.deviceName}');
  print('Connected at: ${savedDevice.connectedAt}');
}

// Remove saved device
await bleService.removeConnectedDevice('my_device_key');

// Get all stored devices
final allStoredDevices = await bleService.getAllStoredDevices();
print('Total stored devices: ${allStoredDevices.length}');

// Get all device storage keys
final deviceKeys = await bleService.getAllConnectedDeviceKeys();
print('Device keys: $deviceKeys');

// Service and Characteristic Discovery
// Discover all services and characteristics
final discoveryResult = await bleService.discoverServices(device);
if (discoveryResult.error == null) {
  print('Found ${discoveryResult.services.length} services');
  for (final service in discoveryResult.services) {
    print('Service: ${service.uuid} (Primary: ${service.isPrimary})');
    print('  Characteristics: ${service.characteristics.length}');
  }
}

// Find specific service by UUID
final service = await bleService.findService(device, '0000180F-0000-1000-8000-00805F9B34FB');
if (service != null) {
  print('Found service: ${service.uuid}');
  print('Characteristics: ${service.characteristics.length}');
}

// Find specific characteristic by UUID
final characteristic = await bleService.findCharacteristic(
  device,
  '0000180F-0000-1000-8000-00805F9B34FB', // Service UUID
  '00002A19-0000-1000-8000-00805F9B34FB', // Characteristic UUID
);
if (characteristic != null) {
  print('Found characteristic: ${characteristic.uuid}');
  print('Can read: ${characteristic.canRead}');
  print('Can write: ${characteristic.canWrite}');
  print('Can notify: ${characteristic.canNotify}');
}

// Find characteristic across all services
final characteristicInAll = await bleService.findCharacteristicInAllServices(
  device,
  '00002A19-0000-1000-8000-00805F9B34FB',
);

// Get all characteristics for a service
final characteristics = await bleService.getServiceCharacteristics(
  device,
  '0000180F-0000-1000-8000-00805F9B34FB',
);

// Get all services with a specific characteristic
final servicesWithChar = await bleService.getServicesWithCharacteristic(
  device,
  '00002A19-0000-1000-8000-00805F9B34FB',
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
- `connectToDevice(device, config, storageKey)`: Connect to a BLE device
- `disconnectFromDevice(device)`: Disconnect from a BLE device
- `saveConnectedDevice(storageKey, device, mtu)`: Save connected device information
- `getConnectedDevice(storageKey)`: Get saved device information
- `removeConnectedDevice(storageKey)`: Remove saved device information
- `getAllStoredDevices()`: Get all stored connected devices
- `getAllConnectedDeviceKeys()`: Get all device storage keys
- `connectionStateStream`: Stream of connection state changes
- `discoverServices(device)`: Discover all services and characteristics of a connected device
- `findService(device, serviceUuid)`: Find a specific service by UUID
- `findCharacteristic(device, serviceUuid, characteristicUuid)`: Find a specific characteristic by UUID
- `findCharacteristicInAllServices(device, characteristicUuid)`: Find characteristic across all services
- `getServiceCharacteristics(device, serviceUuid)`: Get all characteristics for a specific service
- `getServicesWithCharacteristic(device, characteristicUuid)`: Get all services with a specific characteristic

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

#### BleConnectionConfig

Configuration for BLE connection with the following properties:

- `timeout`: Connection timeout duration (default: 35 seconds)
- `mtu`: Maximum Transmission Unit (default: 512)
- `autoConnect`: Whether to auto-connect on device availability (default: false)
- `saveDeviceOnConnect`: Whether to save device info on successful connection (default: true)
- `removeDeviceOnDisconnect`: Whether to remove device info on disconnection (default: true)

#### BleConnectionState

Current state of BLE connection with the following properties:

- `status`: Current connection status (disconnected, connecting, connected, disconnecting, error)
- `device`: Connected BluetoothDevice object
- `mtu`: Maximum Transmission Unit if connected
- `error`: Error message if connection failed

#### ConnectedDeviceInfo

Information about a saved connected device with the following properties:

- `deviceId`: Unique device identifier
- `deviceName`: Human-readable device name
- `connectedAt`: When the device was connected
- `mtu`: Maximum Transmission Unit used

#### BleServiceInfo

Information about a BLE service with the following properties:

- `service`: The BluetoothService object
- `uuid`: Service UUID string
- `isPrimary`: Whether the service is primary
- `characteristics`: List of characteristics in this service

#### BleCharacteristicInfo

Information about a BLE characteristic with the following properties:

- `characteristic`: The BluetoothCharacteristic object
- `uuid`: Characteristic UUID string
- `properties`: List of characteristic properties
- `descriptors`: List of descriptors for this characteristic
- `canRead`: Whether the characteristic supports read operations
- `canWrite`: Whether the characteristic supports write operations
- `canWriteWithoutResponse`: Whether the characteristic supports write without response
- `canNotify`: Whether the characteristic supports notifications
- `canIndicate`: Whether the characteristic supports indications

#### BleDiscoveryResult

Result of service discovery with the following properties:

- `device`: The BluetoothDevice that was discovered
- `services`: List of discovered services
- `error`: Error message if discovery failed

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
