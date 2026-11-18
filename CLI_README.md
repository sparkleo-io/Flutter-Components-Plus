# Flutter Components Plus CLI

A command-line tool for managing Flutter Components Plus package features, permissions, and components in your Flutter applications.

## Installation

### Global Installation (After Publishing)

```bash
# Install the package globally (after it's published to pub.dev)
dart pub global activate flutter_components_plus

# Verify installation
fcp --version
```

### Local Development Testing

```bash
# Install globally from local path (for development)
dart pub global activate --source path /path/to/flutter_components_plus

# Verify installation
fcp --version
```

### Local Installation

```bash
# Add to your project's pubspec.yaml
dependencies:
  flutter_components_plus: ^1.0.0

# Install dependencies
flutter pub get

# Run CLI commands
dart run flutter_components_plus:fcp <command>
```

### Development Testing (Before Publishing)

```bash
# Navigate to your package directory
cd /path/to/flutter_components_plus

# Run CLI commands directly
dart run bin/fcp.dart help
dart run bin/fcp.dart list components
dart run bin/fcp.dart add component button

# Or test in a Flutter project
cd /path/to/your/flutter/project
dart run /path/to/flutter_components_plus/bin/fcp.dart add component chart
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

#### Add All Permissions

```bash
# Add all necessary permissions
fcp add permissions
```

This command will add:
- Camera permissions
- Microphone permissions
- Storage permissions
- Internet permissions

#### Add Components

```bash
# Add specific components
fcp add component chart
fcp add component quadrant_chart
fcp add component live_graph
fcp add component table
fcp add component button
fcp add component card
fcp add component dropdown
fcp add component inline_dropdown
fcp add component multi_select
fcp add component input_field
fcp add component pdf_viewer
fcp add component switch
fcp add component navigation
```

### Removing Features

#### Remove All Permissions

```bash
# Remove all permissions
fcp remove permissions
```

#### Remove Components

```bash
# Remove specific components
fcp remove component chart
# ... etc
```

## Available Components

| Component | Description | Dependencies | Permissions |
|-----------|-------------|--------------|-------------|
| `chart` | Interactive charts and graphs | `fl_chart` | None |
| `quadrant_chart` | Configurable quadrant chart with thresholds and markers | None | None |
| `live_graph` | Real-time live data visualization | `fl_chart` | None |
| `table` | Data tables with sorting/filtering | `syncfusion_flutter_datagrid` | None |
| `button` | Customizable buttons | None | None |
| `card` | Unified card component with multiple variants | None | None |
| `dropdown` | Professional dropdown with search | None | None |
| `inline_dropdown` | Inline dropdown that opens below button | None | None |
| `multi_select` | Multi-selection dropdown with search | None | None |
| `input_field` | Customizable input fields with validation | None | None |
| `pdf_viewer` | PDF document viewer | `syncfusion_flutter_pdfviewer` | Storage |
| `switch` | Customizable toggle switches | None | None |
| `navigation` | Bottom navigation bar | None | None |
| `themes` | Complete theme system with light/dark variants | None | None |

## Available Permissions

| Permission | Description | Platforms | Required For |
|------------|-------------|-----------|--------------|
| `camera` | Camera access | Android, iOS | Camera features |
| `microphone` | Microphone access | Android, iOS | Audio features |
| `storage` | File system access | Android, iOS | PDF viewer, File operations |
| `internet` | Internet access | Android, iOS | HTTP requests |

## Examples

### Full Feature Setup

```bash
# 1. Add all permissions
fcp add permissions

# 2. Add multiple components
fcp add component chart
fcp add component quadrant_chart
fcp add component live_graph
fcp add component table
fcp add component card
fcp add component themes
fcp add component pdf_viewer

# 3. Install dependencies
flutter pub get
```

### Cleanup

```bash
# Remove unused components
fcp remove component chart
fcp remove component live_graph
fcp remove component table
fcp remove component card
fcp remove component themes
```

## File Modifications

The CLI tool automatically modifies the following files:

### Android (`android/app/src/main/AndroidManifest.xml`)

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS (`ios/Runner/Info.plist`)

```xml
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
  permission_handler: ^12.0.3
  fl_chart: ^1.2.0
  syncfusion_flutter_datagrid: ^33.2.15
  syncfusion_flutter_pdfviewer: ^33.2.15
  # ... other dependencies
```

## Example Files

When you add components, the CLI creates example files in the `examples/` directory:

- `chart_example.dart` - Chart component usage
- `quadrant_chart_example.dart` - Quadrant chart component usage
- `live_graph_example.dart` - Live graph component usage
- `table_example.dart` - Table component usage
- `button_example.dart` - Button component usage
- `card_example.dart` - Card component usage
- `dropdown_example.dart` - Dropdown component usage
- `inline_dropdown_example.dart` - Inline dropdown component usage
- `multi_select_example.dart` - Multi-select component usage
- `input_field_example.dart` - Input field component usage
- `pdf_viewer_example.dart` - PDF viewer component usage
- `switch_example.dart` - Switch component usage
- `navigation_example.dart` - Navigation component usage
- `themes/` - Complete theme system with organized theme files

## Troubleshooting

### Permission Issues

If you encounter permission issues:

1. **Android**: Make sure you're testing on a physical device when required
2. **iOS**: Check that the permissions are properly added to Info.plist

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
- name: Add permissions
  run: fcp add permissions

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
