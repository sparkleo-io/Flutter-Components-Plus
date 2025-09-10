# BLE Service - Programmatic Usage

The `BLEService` provides a clean, programmatic API for Bluetooth Low Energy operations without any UI dependencies. It's designed to be used in your own custom UI implementations.

## Features

- ✅ **Singleton Pattern** - Single instance across your app
- ✅ **Stream-based** - Real-time updates via Dart streams
- ✅ **Permission Handling** - Automatic Bluetooth and Location permission management
- ✅ **Device Filtering** - Filter devices by name (substring matching)
- ✅ **Auto-connect** - Automatically connect to filtered devices
- ✅ **Data Persistence** - Save/load devices using SharedPreferences
- ✅ **Debug Mode** - Detailed logging for troubleshooting
- ✅ **Error Handling** - Comprehensive error management

## Quick Start

### 1. Import the Service

```dart
import 'package:flutter_components_plus/flutter_components_plus.dart';
```

### 2. Initialize the Service

```dart
final bleService = BLEService();

await bleService.initialize(
  scanDuration: Duration(seconds: 10),
  deviceFilters: ["Leo"], // Only show devices with "Leo" in name
  autoConnect: false,
  usePrefs: true,
  debugMode: true,
);
```

### 3. Set Up Stream Listeners

```dart
// Listen for discovered devices
bleService.deviceFoundStream.listen((device) {
  print('Found device: ${device.name}');
  // Update your UI here
});

// Listen for connection state changes
bleService.connectionStateStream.listen((state) {
  print('Connection state: $state');
  // Update connection status in UI
});

// Listen for errors
bleService.errorStream.listen((error) {
  print('BLE Error: $error');
  // Show error to user
});
```

### 4. Control BLE Operations

```dart
// Start scanning
await bleService.startScan();

// Stop scanning
await bleService.stopScan();

// Connect to a device
await bleService.connectToDevice(device);

// Disconnect
await bleService.disconnectDevice();
```

## API Reference

### Initialization

```dart
Future<bool> initialize({
  Duration scanDuration = Duration(seconds: 10),
  bool autoConnect = false,
  List<String> deviceFilters = const [],
  bool usePrefs = false,
  bool debugMode = false,
})
```

**Parameters:**
- `scanDuration`: How long to scan for devices
- `autoConnect`: Automatically connect to filtered devices
- `deviceFilters`: List of strings to filter device names (substring matching)
- `usePrefs`: Save/load devices using SharedPreferences
- `debugMode`: Enable detailed console logging

### Device Operations

```dart
// Start scanning for devices
Future<void> startScan()

// Stop scanning
Future<void> stopScan()

// Connect to a specific device
Future<void> connectToDevice(BLEDeviceModel device)

// Disconnect from current device
Future<void> disconnectDevice()
```

### Data Operations

```dart
// Read characteristic value
Future<List<int>?> readCharacteristic(String serviceUuid, String characteristicUuid)

// Write characteristic value
Future<void> writeCharacteristic(String serviceUuid, String characteristicUuid, List<int> value)

// Get saved devices
Future<List<BLEDeviceModel>> getSavedDevices()
```

### Streams

```dart
// Discovered devices
Stream<BLEDeviceModel> deviceFoundStream

// Connection state changes
Stream<BLEConnectionState> connectionStateStream

// Scan state changes
Stream<BLEScanState> scanStateStream

// Discovered services
Stream<List<BLEServiceModel>> servicesDiscoveredStream

// Error events
Stream<String> errorStream
```

### Getters

```dart
// Current state
BLEConnectionState connectionState
BLEScanState scanState
bool isConnected
bool isScanning
bool isInitialized
bool permissionsGranted

// Connected device
BluetoothDevice? connectedDevice

// Discovered data
List<BLEDeviceModel> discoveredDevices
List<BLEServiceModel> discoveredServices
```

## Device Filtering

The `deviceFilters` parameter uses substring matching to show only devices containing the specified text:

```dart
// Only show devices with "Leo" in their name
deviceFilters: ["Leo"]

// Show devices with "Arduino" OR "ESP32" in their name
deviceFilters: ["Arduino", "ESP32"]

// Show devices with "Sensor" in their name
deviceFilters: ["Sensor"]
```

**Examples:**
- Filter: `["Leo"]` → Shows: "Leo USB EVNC106P6", "My Leo Device"
- Filter: `["Arduino"]` → Shows: "Arduino Uno", "Arduino Nano"
- Filter: `["Sensor"]` → Shows: "Temperature Sensor", "Humidity Sensor"

## Error Handling

The service provides comprehensive error handling:

```dart
bleService.errorStream.listen((error) {
  // Handle different types of errors
  if (error.contains('permission')) {
    // Show permission request dialog
  } else if (error.contains('connection')) {
    // Show connection error
  } else {
    // Show generic error
  }
});
```

## Debug Mode

Enable debug mode to see detailed logging:

```dart
await bleService.initialize(debugMode: true);
```

**Debug Output:**
```
BLE Filter Debug:
  Device Name: "iPhone"
  Device ID: "AA:BB:CC:DD:EE:FF"
  Filters: ["Leo"]
  Has Match: false
  ❌ Device filtered out (no match)

BLE Filter Debug:
  Device Name: "Leo USB EVNC106P6"
  Device ID: "11:22:33:44:55:66"
  Filters: ["Leo"]
  Has Match: true
  ✅ Device passed filter
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class MyBLEApp extends StatefulWidget {
  @override
  _MyBLEAppState createState() => _MyBLEAppState();
}

class _MyBLEAppState extends State<MyBLEApp> {
  final BLEService _bleService = BLEService();
  List<BLEDeviceModel> _devices = [];
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _initializeBLE();
  }

  Future<void> _initializeBLE() async {
    try {
      await _bleService.initialize(
        deviceFilters: ["Leo"],
        debugMode: true,
      );

      // Set up listeners
      _bleService.deviceFoundStream.listen((device) {
        setState(() {
          _devices.add(device);
        });
      });

      _bleService.connectionStateStream.listen((state) {
        setState(() {
          _isConnected = state == BLEConnectionState.connected;
        });
      });
    } catch (e) {
      print('BLE initialization failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My BLE App')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _bleService.startScan(),
            child: Text('Start Scan'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices[index];
                return ListTile(
                  title: Text(device.name),
                  subtitle: Text('RSSI: ${device.rssi} dBm'),
                  trailing: ElevatedButton(
                    onPressed: () => _bleService.connectToDevice(device),
                    child: Text('Connect'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bleService.dispose();
    super.dispose();
  }
}
```

## Permissions

The service automatically handles the following permissions:

**Android:**
- `BLUETOOTH`
- `BLUETOOTH_ADMIN`
- `BLUETOOTH_SCAN`
- `BLUETOOTH_CONNECT`
- `ACCESS_FINE_LOCATION`
- `ACCESS_COARSE_LOCATION`

**iOS:**
- `NSBluetoothAlwaysUsageDescription`
- `NSBluetoothPeripheralUsageDescription`
- `NSLocationWhenInUseUsageDescription`

Use the CLI tool to add these permissions:
```bash
fcp add ble_permissions
```

## Troubleshooting

1. **No devices found**: Check if `deviceFilters` is too restrictive
2. **Permission errors**: Ensure permissions are added to platform files
3. **Connection failures**: Check if device is in range and discoverable
4. **Debug mode**: Enable `debugMode: true` to see detailed logs

## Best Practices

1. **Initialize once**: Use the singleton pattern, initialize once per app
2. **Handle errors**: Always listen to the error stream
3. **Dispose properly**: Call `dispose()` when done
4. **Use filters**: Filter devices to improve performance
5. **Enable debug**: Use debug mode during development
