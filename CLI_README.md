# Flutter Components Plus CLI

A command-line tool for managing Flutter Components Plus package features, permissions, and components in your Flutter applications.

## Installation

### Global Installation

```bash
# Install the package globally
dart pub global activate flutter_components_plus

# Verify installation
fcp --version
```

### Local Installation

```bash
# Add to your project's pubspec.yaml
dependencies:
  flutter_components_plus: ^0.0.3

# Install dependencies
flutter pub get

# Run CLI commands
dart run flutter_components_plus:fcp <command>
```

## Usage

### Basic Commands

```bash
# Show help
fcp help

# Show version
fcp --version

# List available components
fcp list components

# List available permissions
fcp list permissions
```

### Adding Features

#### Add BLE Permissions

```bash
# Add BLE (Bluetooth Low Energy) permissions
fcp add ble_permissions
```

This command will:
- Add Bluetooth permissions to `android/app/src/main/AndroidManifest.xml`
- Add Bluetooth and Location permissions to `ios/Runner/Info.plist`
- Add required dependencies to `pubspec.yaml`
- Provide next steps for testing

#### Add All Permissions

```bash
# Add all necessary permissions
fcp add permissions
```

This command will add:
- Bluetooth permissions
- Location permissions
- Camera permissions
- Microphone permissions
- Storage permissions
- Internet permissions

#### Add Components

```bash
# Add specific components
fcp add component chart
fcp add component table
fcp add component button
fcp add component dropdown
fcp add component ble
fcp add component pdf_viewer
fcp add component switch
fcp add component navigation
```

### Removing Features

#### Remove BLE Permissions

```bash
# Remove BLE permissions
fcp remove ble_permissions
```

#### Remove All Permissions

```bash
# Remove all permissions
fcp remove permissions
```

#### Remove Components

```bash
# Remove specific components
fcp remove component chart
fcp remove component ble
# ... etc
```

## Available Components

| Component | Description | Dependencies | Permissions |
|-----------|-------------|--------------|-------------|
| `chart` | Interactive charts and graphs | `fl_chart` | None |
| `table` | Data tables with sorting/filtering | `syncfusion_flutter_datagrid` | None |
| `button` | Customizable buttons | None | None |
| `dropdown` | Advanced dropdown components | None | None |
| `ble` | Bluetooth Low Energy management | `flutter_blue_plus`, `permission_handler` | Bluetooth, Location |
| `pdf_viewer` | PDF document viewer | `syncfusion_flutter_pdfviewer` | Storage |
| `switch` | Customizable toggle switches | None | None |
| `navigation` | Bottom navigation bar | None | None |

## Available Permissions

| Permission | Description | Platforms | Required For |
|------------|-------------|-----------|--------------|
| `bluetooth` | Bluetooth access | Android, iOS | BLE component |
| `bluetooth_scan` | Bluetooth scanning (Android 12+) | Android | BLE component |
| `bluetooth_connect` | Bluetooth connection (Android 12+) | Android | BLE component |
| `location` | Location access | Android, iOS | BLE component |
| `camera` | Camera access | Android, iOS | Camera features |
| `microphone` | Microphone access | Android, iOS | Audio features |
| `storage` | File system access | Android, iOS | PDF viewer, File operations |
| `internet` | Internet access | Android, iOS | HTTP requests |

## Examples

### Complete BLE Setup

```bash
# 1. Add BLE permissions
fcp add ble_permissions

# 2. Add BLE component
fcp add component ble

# 3. Install dependencies
flutter pub get

# 4. Use in your app
```

### Full Feature Setup

```bash
# 1. Add all permissions
fcp add permissions

# 2. Add multiple components
fcp add component chart
fcp add component table
fcp add component ble

# 3. Install dependencies
flutter pub get
```

### Cleanup

```bash
# Remove unused components
fcp remove component chart
fcp remove component table

# Remove unused permissions
fcp remove ble_permissions
```

## File Modifications

The CLI tool automatically modifies the following files:

### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<!-- BLE Permissions -->
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-feature android:name="android.hardware.bluetooth_le" android:required="true" />

<!-- Other Permissions -->
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS (`ios/Runner/Info.plist`)

```xml
<!-- BLE Permissions -->
<key>NSBluetoothAlwaysUsageDescription</key>
<string>This app uses Bluetooth to connect to BLE devices.</string>
<key>NSBluetoothPeripheralUsageDescription</key>
<string>This app uses Bluetooth to connect to BLE devices.</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app uses location to scan for nearby BLE devices.</string>

<!-- Other Permissions -->
<key>NSCameraUsageDescription</key>
<string>This app uses the camera to take photos.</string>
<key>NSMicrophoneUsageDescription</key>
<string>This app uses the microphone to record audio.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>This app accesses the photo library to save and load images.</string>
```

### Dependencies (`pubspec.yaml`)

```yaml
dependencies:
  flutter_blue_plus: ^1.32.10
  permission_handler: ^11.3.1
  fl_chart: ^0.69.0
  syncfusion_flutter_datagrid: ^30.2.7
  syncfusion_flutter_pdfviewer: ^30.2.7
  # ... other dependencies
```

## Example Files

When you add components, the CLI creates example files in the `examples/` directory:

- `chart_example.dart` - Chart component usage
- `table_example.dart` - Table component usage
- `button_example.dart` - Button component usage
- `dropdown_example.dart` - Dropdown component usage
- `ble_example.dart` - BLE component usage
- `pdf_viewer_example.dart` - PDF viewer component usage
- `switch_example.dart` - Switch component usage
- `navigation_example.dart` - Navigation component usage

## Troubleshooting

### Permission Issues

If you encounter permission issues:

1. **Android**: Make sure you're testing on a physical device
2. **iOS**: Check that the permissions are properly added to Info.plist
3. **Location**: Ensure location services are enabled on the device

### Dependency Issues

If you encounter dependency conflicts:

1. Run `flutter pub get` after adding components
2. Check for version conflicts in `pubspec.yaml`
3. Use `flutter pub deps` to analyze dependencies

### File Modification Issues

If the CLI can't modify files:

1. Ensure you have write permissions
2. Check that the files exist in the expected locations
3. Verify you're running the command from the project root

## Advanced Usage

### Custom Configuration

You can customize the CLI behavior by modifying the generated files:

1. **Permissions**: Edit the permission descriptions in platform-specific files
2. **Dependencies**: Modify versions in `pubspec.yaml`
3. **Examples**: Customize the generated example files

### Integration with CI/CD

The CLI can be integrated into CI/CD pipelines:

```yaml
# GitHub Actions example
- name: Add BLE permissions
  run: fcp add ble_permissions

- name: Install dependencies
  run: flutter pub get
```

## Contributing

To contribute to the CLI tool:

1. Fork the repository
2. Create a feature branch
3. Add your changes
4. Test thoroughly
5. Submit a pull request

## Support

For support and questions:

- Check the [documentation](https://github.com/your-username/flutter_components_plus)
- Open an [issue](https://github.com/your-username/flutter_components_plus/issues)
- Join our [community](https://github.com/your-username/flutter_components_plus/discussions)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
