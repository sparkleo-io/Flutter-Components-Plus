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
- **FCPMultiSelectDropdown** - Multi-selection dropdown with search functionality

### 🎨 Design System & Utilities
- **Complete Theme System** - Light and dark themes with comprehensive color schemes
- **Utility Extensions** - Widget, String, and Date extensions for enhanced productivity
- **Services** - HTTP, Storage, and Logging services with full configuration
- **CLI Tools** - Component and permission management via command line

## 📦 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_components_plus: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## 🛠️ CLI Tools

Install and manage components with our powerful CLI:

```bash
# Install globally
dart pub global activate flutter_components_plus

# Verify installation
fcp --version
```

### Usage

```bash
# Add components to your project
fcp add component button
fcp add component chart
fcp add component themes

# Add permissions
fcp add ble_permissions

# List available components
fcp list components

# Remove components
fcp remove component button
```

### Available Components

- `button` - Customizable buttons with various styles
- `card` - Unified card component with multiple variants
- `chart` - Interactive charts and graphs
- `live_graph` - Real-time live data visualization
- `table` - Data tables with sorting and filtering
- `dropdown` - Professional dropdown with search
- `input_field` - Customizable input fields
- `ble` - Bluetooth Low Energy management
- `pdf_viewer` - PDF document viewer
- `themes` - Complete theme system with light/dark variants

## 🚀 Quick Start

### 1. Import the package

```dart
import 'package:flutter_components_plus/flutter_components_plus.dart';
```

// Fluent API buttons
FCPButton.medium.primary(
  text: 'Click Me',
  onPressed: () => print('Button pressed!'),
)

// Apply themes
MaterialApp(
  theme: FCPAppTheme.lightTheme,
  darkTheme: FCPAppTheme.darkTheme,
  // ... rest of your app
)

// Use extensions
Text('Hello World').padAll(16).center().shadow()
```

## 🧩 Key Components

### FCPButton - Fluent API Buttons
```dart
// Primary, outlined, and icon buttons
FCPButton.medium.primary(text: 'Click Me')
FCPButton.large.outlined(text: 'Download', icon: Icons.download)
FCPButton.small.iconButton(icon: Icons.add)
```

### FCPCard - Unified Cards
```dart
// Various card types
FCPCard(child: Text('Simple card'))
FCPCard.shaded(shadowType: ShadowType.medium, child: Text('Shaded card'))
FCPCard.gradient(gradientType: GradientType.sunset, child: Text('Gradient card'))
FCPCard.info(icon: Icons.info, title: 'Information', content: 'Main content')
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
Text('Hello').padAll(16).center().shadow()
Text('Hello').width(200).height(50).borderRadius(8)
Text('Hello').onTap(() {})
```

### String Extensions
```dart
'hello world'.capitalize        // 'Hello world'
'user@example.com'.isEmail     // true
'hello world'.truncate(5)      // 'hello...'
```

### Date Extensions
```dart
yesterday.relativeTime          // '1 day ago'
now.isToday                    // true
now.addDays(7)                 // Add 7 days
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
final logger = FCPLoggingService.instance;

// Log messages
logger.debug('Debug message');
logger.info('Info message');
logger.warning('Warning message');
logger.error('Error message', error: Exception('Something went wrong'));
```


## 🎨 Design System

### Colors & Text Styles
```dart
// Colors
FCPColorScheme.primary
FCPColorScheme.secondary

// Semantic colors
FCPColorScheme.success
FCPColorScheme.warning
FCPColorScheme.error

// Text styles
FCPTextStyles.headlineLarge
FCPTextStyles.bodyMedium

// Constants
FCPConstants.spacingMd  // 16.0
FCPConstants.radiusMd  // 8.0
FCPConstants.durationNormal // 300ms
```

## 🚀 Latest Updates

### FcpBleService - Complete BLE Solution
- **Permission Management** - Bluetooth and location services control
- **Device Discovery** - Configurable scanning with filtering and debug options
- **Device Connection** - Customizable timeout, MTU, and auto-connect
- **Device Persistence** - Save and retrieve device information
- **Service Discovery** - Complete service and characteristic discovery

**25 methods across 5 categories providing a complete BLE solution!**

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