# Flutter Components Plus

[![pub package](https://img.shields.io/pub/v/flutter_components_plus.svg)](https://pub.dev/packages/flutter_components_plus)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive Flutter package providing highly customizable widgets, themes, and utilities for modern app development. Built with Material Design 3 principles and optimized for performance.

## 🚀 Features

### 🧩 UI Components
- **FCPButton** - Fluent API button component with multiple variants, sizes, and states
- **FCPCard** - Unified card component with flat, shaded, gradient, info, and action variants
- **FCPDropdownBottomSheet** - Professional dropdown with search functionality and custom styling
- **FCPPdfViewer** - Comprehensive PDF viewer with zoom, navigation, and search features
- **FCPChart** - Interactive charts (Area, Bar, Line, Histogram) with fluent API
- **FCPLiveGraph** - Real-time live data visualization with smooth animations
- **FCPBLEComponent** - Bluetooth Low Energy device management with scanning and connection
- **FCPSwitch** - Customizable toggle switches with single/multi-select and toggle variants
- **FCPBottomNavigationBar** - Modern bottom navigation with asset-based icons
- **FCPDataTable** - Advanced data tables with sorting, filtering, and pagination
- **FCPInputField** - Customizable input fields with validation and styling
- **FCPMultiSelectDropdown** - Multi-selection dropdown with search and custom styling

### 🎨 Design System
- **Themes** - Complete light and dark theme support
- **Color Schemes** - Comprehensive color palette with semantic colors
- **Text Styles** - Typography system with predefined text styles
- **Spacing & Layout** - Consistent spacing and layout constants

### 🛠️ Utility Extensions
- **Widget Extensions** - `.padAll()`, `.center()`, `.shadow()`, etc.
- **String Extensions** - `.capitalize`, `.isEmail`, `.truncate()`, etc.
- **Date Extensions** - `.isToday`, `.relativeTime`, `.addDays()`, etc.

### 🌐 Services
- **HTTP Service** - Complete HTTP client with interceptors and error handling
- **Storage Service** - Local storage management with JSON support
- **Logging Service** - Comprehensive logging with multiple output options

### 🛠️ CLI Tools
- **Component Manager** - Add/remove components and dependencies
- **Permission Manager** - Manage platform permissions automatically
- **File Utils** - Project file management utilities

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_components_plus: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## 🚀 Quick Start

### 1. Import the package

```dart
import 'package:flutter_components_plus/flutter_components_plus.dart';
```

### 2. Use the fluent API button

```dart
// Fluent API - more intuitive and type-safe
FCPButton.medium.primary(
  text: 'Click Me',
  onPressed: () {
    print('Button pressed!');
  },
)

// With icon
FCPButton.large.outlined(
  text: 'Download',
  icon: Icons.download,
  iconPosition: IconPosition.start,
  onPressed: () => downloadFile(),
)

// Icon button
FCPButton.small.iconButton(
  icon: Icons.add,
  onPressed: () => addItem(),
)
```

### 3. Apply themes

```dart
MaterialApp(
  theme: FCPAppTheme.lightTheme,
  darkTheme: FCPAppTheme.darkTheme,
  // ... rest of your app
)
```

### 4. Use extensions

```dart
Text('Hello World')
  .padAll(16)
  .center()
  .shadow()
```

## 🧩 UI Components

### FCPButton - Fluent API Button Component

```dart
// Primary buttons
FCPButton.small.primary(text: 'Small Primary')
FCPButton.medium.primary(text: 'Medium Primary')
FCPButton.large.primary(text: 'Large Primary')

// Outlined buttons
FCPButton.medium.outlined(
  text: 'Download',
  icon: Icons.download,
  iconPosition: IconPosition.start,
)

// Icon buttons
FCPButton.small.iconButton(icon: Icons.add)
FCPButton.medium.iconButton(icon: Icons.edit)

// Floating buttons
FCPButton.medium.floating(
  text: 'Add Item',
  icon: Icons.add,
)

// With loading state
FCPButton.medium.primary(
  text: 'Processing...',
  isLoading: true,
  onPressed: () => processData(),
)
```

### FCPCard - Unified Card Component

```dart
// Basic card
FCPCard(child: Text('Simple card'))

// Flat card (no shadows)
FCPCard.flat(
  backgroundColor: Colors.green.shade50,
  borderColor: Colors.green.shade300,
  child: Text('Flat card'),
)

// Shaded card with different shadow types
FCPCard.shaded(
  shadowType: ShadowType.medium,
  child: Text('Shaded card'),
)

// Gradient card
FCPCard.gradient(
  gradientType: GradientType.sunset,
  child: Text('Gradient card'),
)

// Info card with structured content
FCPCard.info(
  icon: Icons.info,
  title: 'Information',
  subtitle: 'This is a subtitle',
  content: 'Main content here',
)

// Action card with buttons
FCPCard.action(
  icon: Icons.settings,
  title: 'Settings',
  content: 'Configure your settings.',
  actions: [
    TextButton(onPressed: () {}, child: Text('Cancel')),
    ElevatedButton(onPressed: () {}, child: Text('Save')),
  ],
)
```

### FCPDropdownBottomSheet - Professional Dropdown

```dart
// Basic dropdown
FCPDropdownBottomSheet(
  title: 'Select Country',
  items: ['USA', 'Canada', 'UK', 'Germany', 'France'],
  onItemSelected: (value) => print('Selected: $value'),
)

// With search enabled
FCPDropdownBottomSheet(
  title: 'Select Country',
  items: countries,
  onItemSelected: (value) => handleSelection(value),
  isSearchEnabled: true,
  searchHintText: 'Search countries...',
)

// Using extension method
context.showFCPDropdownBottomSheet(
  title: 'Select Item',
  items: items,
  onItemSelected: (value) => handleSelection(value),
  isSearchEnabled: true,
)
```

### FCPChart - Interactive Charts

```dart
// Area chart
FCPChart.area.withData(
  data: [
    FCPChartData(x: 0, y: 10),
    FCPChartData(x: 1, y: 25),
    FCPChartData(x: 2, y: 15),
    FCPChartData(x: 3, y: 40),
  ],
  title: 'Sales Performance',
)

// Bar chart
FCPChart.bar.withData(
  data: [
    FCPChartData(x: 0, y: 20, label: 'Jan'),
    FCPChartData(x: 1, y: 35, label: 'Feb'),
    FCPChartData(x: 2, y: 15, label: 'Mar'),
  ],
  title: 'Monthly Revenue',
)

// Line chart
FCPChart.line.withData(
  data: lineData,
  title: 'Stock Price Trend',
  customConfig: FCPLineChartConfig(
    showDots: true,
    isCurved: true,
    lineWidth: 3,
  ),
)
```

### FCPLiveGraph - Real-time Data Visualization

```dart
FCPLiveGraph(
  data: liveDataStream,
  title: 'Live Temperature',
  yAxisLabel: 'Temperature (°C)',
  xAxisLabel: 'Time',
  maxDataPoints: 100,
  animationDuration: Duration(milliseconds: 300),
  showGrid: true,
  showDots: true,
  lineColor: Colors.blue,
  fillColor: Colors.blue.withOpacity(0.1),
)
```

### FCPBLEComponent - Bluetooth Low Energy

```dart
FCPBLEComponent(
  config: BLEComponentConfig(
    scanDuration: Duration(seconds: 10),
    autoConnect: false,
    deviceFilters: ['MyDevice'],
    usePrefs: true,
    showPermissionDialog: true,
  ),
  onDeviceSelected: (device) => print('Device selected: ${device.name}'),
  onConnectionStateChanged: (state) => print('Connection state: $state'),
)
```

### FCPSwitch - Customizable Switches

```dart
// Basic toggle switch
FCPSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
  label: 'Enable Feature',
  config: SwitchConfigs.iosStyle,
)

// Single Toggle switch
FCPToggleSwitch<String>(
  title: 'Theme Selection',
  states: const [
    ToggleState<String>(
      value: 'light',
      label: 'Light',
      icon: Icons.light_mode,
    ),
    ToggleState<String>(
      value: 'dark',
      label: 'Dark',
      icon: Icons.dark_mode,
    ),
  ],
  activeValue: _themeValue,
  onChanged: (value) => setState(() => _themeValue = value),
  height: 80,
  showLabels: false,
)
```

### FCPDataTable - Advanced Data Tables

```dart
FCPDataTable(
  columns: [
    DataColumn(label: Text('Name')),
    DataColumn(label: Text('Age')),
    DataColumn(label: Text('Email')),
  ],
  rows: data.map((item) => DataRow(
    cells: [
      DataCell(Text(item.name)),
      DataCell(Text(item.age.toString())),
      DataCell(Text(item.email)),
    ],
  )).toList(),
  sortColumnIndex: 0,
  sortAscending: true,
  onSelectAll: (value) => handleSelectAll(value),
  onRowsPerPageChanged: (value) => setRowsPerPage(value),
)
```

## 🛠️ Utility Extensions

### Widget Extensions

```dart
// Padding
Text('Hello').padAll(16)
Text('Hello').padHorizontal(16)
Text('Hello').padVertical(16)

// Layout
Text('Hello').center()
Text('Hello').width(200)
Text('Hello').height(50)

// Styling
Text('Hello').borderRadius(8)
Text('Hello').shadow()
Text('Hello').backgroundColor(Colors.blue)

// Interactions
Text('Hello').onTap(() {})
Text('Hello').inkWell(onTap: () {})
```

### String Extensions

```dart
// Case conversion
'hello world'.capitalize        // 'Hello world'
'hello world'.titleCase        // 'Hello World'
'hello world'.camelCase        // 'helloWorld'

// Validation
'user@example.com'.isEmail     // true
'https://example.com'.isUrl    // true
'+1234567890'.isPhoneNumber    // true

// Manipulation
'hello world'.truncate(5)      // 'hello...'
'hello world'.removeWhitespace // 'helloworld'
```

### Date Extensions

```dart
final now = DateTime.now();
final yesterday = DateTime.now().subtract(Duration(days: 1));

// Relative time
yesterday.relativeTime          // '1 day ago'
yesterday.shortRelativeTime     // '1d ago'

// Date checks
now.isToday                    // true
yesterday.isYesterday          // true

// Date manipulation
now.addDays(7)                 // Add 7 days
now.subtractDays(7)            // Subtract 7 days
```

## 🌐 Services

### HTTP Service

```dart
// Initialize
final httpService = FCPHttpService.instance;

// Set base URL
httpService.setBaseUrl('https://api.example.com');

// Make requests
final response = await httpService.get('/users');
final users = response.jsonBody;

// POST request
final createResponse = await httpService.post(
  '/users',
  body: {'name': 'John', 'email': 'john@example.com'},
);
```

### Storage Service

```dart
// Initialize
final storage = FCPStorageService.instance;
await storage.initialize();

// Store data
await storage.setString('user_name', 'John');
await storage.setInt('user_age', 25);
await storage.setJson('user_profile', {'name': 'John', 'age': 25});

// Retrieve data
final name = storage.getString('user_name');
final age = storage.getInt('user_age');
```

### Logging Service

```dart
// Initialize
final logger = FCPLoggingService.instance;

// Log messages
logger.debug('Debug message');
logger.info('Info message');
logger.warning('Warning message');
logger.error('Error message', error: Exception('Something went wrong'));
```

## 🛠️ CLI Tools

The package includes powerful command-line tools for managing components and permissions.

### Installation

```bash
# Install globally
dart pub global activate flutter_components_plus

# Or use locally
dart run flutter_components_plus:fcp <command>
```

### Available Commands

```bash
# Show help
fcp help

# List available components
fcp list components

# Add BLE permissions and complete BLE service
fcp add ble_permissions

# Add specific components
fcp add component chart
fcp add component table
fcp add component ble
fcp add component pdf_viewer

# Remove components or permissions
fcp remove ble_permissions
fcp remove component chart
```

## 🎨 Design System

### Colors

```dart
// Primary colors
FCPColorScheme.primary
FCPColorScheme.secondary

// Semantic colors
FCPColorScheme.success
FCPColorScheme.warning
FCPColorScheme.error

// Neutral colors
FCPColorScheme.neutral50
FCPColorScheme.neutral100
// ... up to neutral900
```

### Text Styles

```dart
// Display styles
FCPTextStyles.displayLarge
FCPTextStyles.displayMedium
FCPTextStyles.displaySmall

// Headline styles
FCPTextStyles.headlineLarge
FCPTextStyles.headlineMedium
FCPTextStyles.headlineSmall

// Body styles
FCPTextStyles.bodyLarge
FCPTextStyles.bodyMedium
FCPTextStyles.bodySmall
```

### Constants

```dart
// Spacing
FCPConstants.spacingXs  // 4.0
FCPConstants.spacingSm  // 8.0
FCPConstants.spacingMd  // 16.0
FCPConstants.spacingLg  // 24.0

// Border radius
FCPConstants.radiusXs   // 2.0
FCPConstants.radiusSm   // 4.0
FCPConstants.radiusMd   // 8.0
FCPConstants.radiusLg   // 12.0

// Animation durations
FCPConstants.durationFast   // 150ms
FCPConstants.durationNormal // 300ms
FCPConstants.durationSlow   // 500ms
```

## 🚀 Latest Updates

### FcpBleService - Complete BLE Solution

We've recently completed a comprehensive Bluetooth Low Energy service that provides everything you need for BLE development:

#### 🔐 **Permission Management**
- Check and control Bluetooth and location services
- Granular permission control with separate service and permission management
- Real-time permission status monitoring

#### 🔍 **Device Discovery**
- Configurable BLE scanning with timeout, filtering, and debug options
- Real-time device discovery with RSSI and timestamp information
- Smart filtering by device name and unknown device exclusion

#### 🔗 **Device Connection**
- Connect to BLE devices with customizable timeout (35s), MTU (512), and auto-connect
- Real-time connection state monitoring with automatic cleanup
- Storage control with configurable save/remove behavior

#### 💾 **Device Persistence**
- Save and retrieve connected device information with custom storage keys
- View all stored devices with comprehensive device management
- Individual device removal and storage cleanup

#### 🔬 **Service Discovery**
- Discover all services and characteristics of connected devices
- Find specific services and characteristics by UUID
- Cross-service characteristic search and relationship mapping
- Comprehensive property and capability information

**Total: 25 methods across 5 categories providing a complete BLE solution!**

## 📱 Example App

Check out the comprehensive example app in the `flutter_component_plus_example` directory to see all components in action.

## 🤝 Contributing

We welcome contributions! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

Copyright (c) Sparkleo Technologies https://www.sparkleo.io/

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for design inspiration
- All contributors and users of this package

---

Made with ❤️ for the Flutter community