# BLE Component Example

This example demonstrates how to use the Flutter Components Plus BLE component for Bluetooth Low Energy operations.

## 🚀 Quick Start

### 1. Prerequisites

- **Physical Device**: BLE functionality requires a physical device (Android/iOS). It won't work on simulators/emulators.
- **BLE Hardware**: The device must have Bluetooth Low Energy capabilities.
- **Permissions**: The app automatically requests necessary permissions.

### 2. Running the Example

```bash
# Navigate to the example directory
cd flutter_component_plus_example

# Install dependencies
flutter pub get

# Run on a physical device
flutter run
```

### 3. Using the BLE Examples

1. Open the app and navigate to the "Components" tab
2. Scroll to the "BLE" tab
3. The BLE examples will be displayed with different configurations

## 📱 What You'll See

The BLE example includes four different demonstrations:

### 1. Basic BLE Component
- Simple configuration with default settings
- Automatic permission handling
- Clean UI for device discovery and connection

### 2. Advanced BLE Component
- Device filtering (looks for devices with specific names)
- Auto-connect functionality
- Custom colors and styling
- Event callbacks for device selection, connection state changes, and service discovery

### 3. Custom UI Example
- Demonstrates custom UI builders
- Complete control over the interface design
- Custom connection status, scan button, and device list

### 4. Programmatic Usage
- Shows how to use BLEManager directly
- Manual control over scanning and connection
- Useful for custom implementations

## 🔧 Configuration Options

### BLEComponentConfig Parameters

```dart
BLEComponentConfig(
  scanDuration: Duration(seconds: 10),        // How long to scan
  autoConnect: false,                         // Auto-connect to filtered devices
  deviceFilters: ['MyDevice', 'Sensor'],      // Device name filters
  usePrefs: true,                            // Save devices to SharedPreferences
  showPermissionDialog: true,                 // Show permission request dialog
  autoStartScan: false,                      // Start scanning automatically
  primaryColor: Colors.blue,                 // Primary color theme
  successColor: Colors.green,                // Success state color
  errorColor: Colors.red,                    // Error state color
)
```

### Event Callbacks

```dart
FCPBLEComponent(
  onDeviceSelected: (device) {
    print('Device selected: ${device.name}');
  },
  onConnectionStateChanged: (state) {
    print('Connection state: $state');
  },
  onServicesDiscovered: (services) {
    print('Discovered ${services.length} services');
  },
  onError: (error) {
    print('Error: $error');
  },
  onDevicesFound: (devices) {
    print('Found ${devices.length} devices');
  },
)
```

## 🔐 Permissions

The example app includes all necessary permissions:

### Android (`android/app/src/main/AndroidManifest.xml`)
```xml
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-feature android:name="android.hardware.bluetooth_le" android:required="true" />
```

### iOS (`ios/Runner/Info.plist`)
```xml
<key>NSBluetoothAlwaysUsageDescription</key>
<string>This app uses Bluetooth to connect to BLE devices for demonstration purposes.</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>This app uses Bluetooth to connect to BLE devices for demonstration purposes.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app uses location to scan for nearby BLE devices for demonstration purposes.</string>
```

## 🧪 Testing

### Test Devices

To test the BLE functionality, you can use:

1. **Arduino with BLE module** (HM-10, nRF52, etc.)
2. **ESP32 with BLE** (programmed with BLE examples)
3. **Raspberry Pi with BLE** (using BlueZ)
4. **Other smartphones** with BLE apps
5. **BLE beacons** (iBeacon, Eddystone)

### Test Scenarios

1. **Device Discovery**: Start scanning and verify devices appear in the list
2. **Connection**: Try connecting to a BLE device
3. **Service Discovery**: Check if services and characteristics are discovered
4. **Data Transfer**: Test reading/writing characteristics (if supported by your test device)
5. **Permission Handling**: Test permission requests and denials

## 🐛 Troubleshooting

### Common Issues

1. **No devices found**
   - Ensure Bluetooth is enabled on the device
   - Make sure you're testing on a physical device
   - Check if the BLE device is in advertising mode
   - Verify the device is within range

2. **Permission denied**
   - Check if permissions are properly added to manifest files
   - Test on a physical device (permissions don't work on simulators)
   - Try uninstalling and reinstalling the app

3. **Connection failed**
   - Ensure the BLE device is not already connected to another device
   - Check if the device supports the required services
   - Verify the device is still in range

4. **Build errors**
   - Run `flutter clean` and `flutter pub get`
   - Ensure all dependencies are properly installed
   - Check for version conflicts

### Debug Tips

1. **Enable Bluetooth logs**:
   ```bash
   flutter run --verbose
   ```

2. **Check device logs**:
   - Android: `adb logcat | grep -i bluetooth`
   - iOS: Use Xcode console

3. **Test with known working BLE apps**:
   - nRF Connect (Android/iOS)
   - LightBlue (iOS)
   - BLE Scanner (Android)

## 📚 Additional Resources

- [Flutter Blue Plus Documentation](https://pub.dev/packages/flutter_blue_plus)
- [Permission Handler Documentation](https://pub.dev/packages/permission_handler)
- [BLE Specification](https://www.bluetooth.com/specifications/specs/)
- [Android BLE Guide](https://developer.android.com/guide/topics/connectivity/bluetooth/ble-overview)
- [iOS BLE Guide](https://developer.apple.com/documentation/corebluetooth)

## 🤝 Contributing

If you find issues or want to improve the BLE examples:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly on physical devices
5. Submit a pull request

## 📄 License

This example is part of the Flutter Components Plus package and follows the same license terms.
