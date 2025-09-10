# BLE Component

A comprehensive Flutter component for Bluetooth Low Energy (BLE) operations using the `flutter_blue_plus` package.

## Features

- **Device Scanning**: Scan for nearby BLE devices with configurable duration and filters
- **Connection Management**: Connect and disconnect from BLE devices
- **Permission Handling**: Automatic handling of Bluetooth and Location permissions
- **Service Discovery**: Automatically discover services and characteristics
- **Data Persistence**: Optional storage of device data using SharedPreferences
- **Customizable UI**: Fully customizable UI components
- **Error Handling**: Comprehensive error handling and user feedback

## Components

### FCPBLEComponent

The main widget that provides a complete BLE interface.

```dart
FCPBLEComponent(
  config: BLEComponentConfig(
    scanDuration: Duration(seconds: 10),
    autoConnect: false,
    deviceFilters: ['MyDevice'],
    usePrefs: true,
    showPermissionDialog: true,
  ),
  onDeviceSelected: (device) {
    print('Device selected: ${device.name}');
  },
  onConnectionStateChanged: (state) {
    print('Connection state: $state');
  },
)
```

### BLEManager

Core BLE operations manager.

```dart
final bleManager = BLEManager();
await bleManager.initialize(
  scanDuration: Duration(seconds: 10),
  autoConnect: false,
  deviceFilters: ['MyDevice'],
  usePrefs: true,
);

// Start scanning
await bleManager.startScan();

// Connect to device
await bleManager.connectToDevice(device);

// Read characteristic
final value = await bleManager.readCharacteristic(
  'service-uuid',
  'characteristic-uuid',
);
```

### BLEPermissionHandler

Handles Bluetooth and Location permissions.

```dart
// Check if permissions are granted
final granted = await BLEPermissionHandler.areAllPermissionsGranted();

// Request permissions with dialog
final granted = await BLEPermissionHandler.requestPermissionsWithDialog(context);

// Request specific permissions
final results = await BLEPermissionHandler.requestBluetoothPermissions();
```

### BLEStorageManager

Manages device data persistence.

```dart
// Save device
await BLEStorageManager.saveDevice(device);

// Get saved devices
final devices = await BLEStorageManager.getDevices();

// Save connected device
await BLEStorageManager.saveConnectedDevice(device);
```

## Configuration

### BLEComponentConfig

Configure the BLE component behavior:

- `scanDuration`: Duration for device scanning
- `autoConnect`: Automatically connect to filtered devices
- `deviceFilters`: List of device name/ID filters
- `usePrefs`: Enable SharedPreferences storage
- `showPermissionDialog`: Show permission request dialog
- `autoStartScan`: Automatically start scanning on init
- `showDeviceList`: Show device list UI
- `showConnectionStatus`: Show connection status UI
- `showScanButton`: Show scan button
- `showDisconnectButton`: Show disconnect button
- Color customization options

## Models

### BLEDeviceModel

Represents a BLE device with all its properties:

```dart
class BLEDeviceModel {
  final String id;
  final String name;
  final String macAddress;
  final int rssi;
  final List<BLEServiceModel> services;
  final DateTime lastSeen;
  final bool isConnected;
  final Map<String, dynamic> advertisementData;
}
```

### BLEServiceModel

Represents a BLE service:

```dart
class BLEServiceModel {
  final String uuid;
  final String name;
  final List<BLECharacteristicModel> characteristics;
  final bool isPrimary;
}
```

### BLECharacteristicModel

Represents a BLE characteristic:

```dart
class BLECharacteristicModel {
  final String uuid;
  final String name;
  final List<String> properties;
  final List<int>? value;
  final String? descriptor;
}
```

## Usage Examples

### Basic Usage

```dart
FCPBLEComponent(
  config: BLEComponentConfig(
    scanDuration: Duration(seconds: 10),
    usePrefs: true,
  ),
)
```

### Advanced Usage with Custom UI

```dart
FCPBLEComponent(
  config: BLEComponentConfig(
    scanDuration: Duration(seconds: 15),
    autoConnect: true,
    deviceFilters: ['MyDevice', 'Sensor'],
    usePrefs: true,
    primaryColor: Colors.blue,
    successColor: Colors.green,
    errorColor: Colors.red,
  ),
  customDeviceListBuilder: (context) {
    return MyCustomDeviceList();
  },
  onDeviceSelected: (device) {
    // Handle device selection
  },
  onConnectionStateChanged: (state) {
    // Handle connection state changes
  },
  onServicesDiscovered: (services) {
    // Handle discovered services
  },
)
```

### Programmatic Usage

```dart
class MyBLEController {
  final BLEManager _bleManager = BLEManager();
  
  Future<void> initialize() async {
    await _bleManager.initialize(
      scanDuration: Duration(seconds: 10),
      usePrefs: true,
    );
    
    // Listen to events
    _bleManager.deviceFoundStream.listen((device) {
      print('Found device: ${device.name}');
    });
    
    _bleManager.connectionStateStream.listen((state) {
      print('Connection state: $state');
    });
  }
  
  Future<void> scanAndConnect() async {
    await _bleManager.startScan();
    
    // Wait for device and connect
    await _bleManager.deviceFoundStream.first.then((device) {
      return _bleManager.connectToDevice(device);
    });
  }
}
```

## Permissions

The component automatically handles the following permissions:

- **Bluetooth**: Required for BLE operations
- **Bluetooth Scan**: Required for device scanning (Android 12+)
- **Bluetooth Connect**: Required for device connection (Android 12+)
- **Location**: Required for BLE scanning on Android

## Error Handling

The component provides comprehensive error handling:

- Permission denied errors
- Bluetooth unavailable errors
- Connection errors
- Scan errors
- Characteristic read/write errors

All errors are exposed through the `onError` callback and error streams.

## Storage

When `usePrefs` is enabled, the component stores:

- Discovered devices
- Connected device
- Scan history
- BLE settings

Data can be exported/imported using the storage manager methods.

## Dependencies

- `flutter_blue_plus`: BLE operations
- `permission_handler`: Permission management
- `shared_preferences`: Data persistence

## Platform Support

- **Android**: Full support with all features
- **iOS**: Full support with all features
- **Web**: Limited support (depends on flutter_blue_plus web support)

## Best Practices

1. Always check permissions before starting BLE operations
2. Handle connection state changes appropriately
3. Use device filters to reduce scan results
4. Implement proper error handling
5. Use SharedPreferences for device persistence
6. Clean up resources when disposing the component
