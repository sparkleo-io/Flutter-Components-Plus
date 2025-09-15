# Flutter Components Plus

A comprehensive Flutter package providing highly customizable widgets, themes, and utilities for modern app development.

## 🚀 Features

### 🧩 UI Components
- **FCPButton** - Fluent API button component with multiple variants, sizes, and states
- **FCPCard** - Unified card component with flat, shaded, gradient, info, and action variants
- **FCPDropdownBottomSheet** - Professional dropdown with search functionality and custom styling
- **FCPPdfViewer** - Comprehensive PDF viewer with zoom, navigation, and search features
- **FCPChart** - Interactive charts (Area, Bar, Line, Histogram) with fluent API
- **FCPBLEComponent** - Bluetooth Low Energy device management with scanning and connection
- **FCPSwitch** - Customizable toggle switches with single/multi-select and toggle variants
- **FCPBottomNavigationBar** - Modern bottom navigation with asset-based icons
- **FCPDataTable** - Advanced data tables with sorting, filtering, and pagination
- **Input Fields** - Text, password, search, and other input types 
- **Dialogs & Sheets** - Bottom sheets, snackbars, and modal dialogs (coming soon)
- **Loaders** - Progress indicators, shimmer effects, pull-to-refresh (coming soon)
- **Pickers** - Date and time pickers (coming soon)

### 🎨 Design System
- **Themes** - Complete light and dark theme support
- **Color Schemes** - Comprehensive color palette with semantic colors
- **Text Styles** - Typography system with predefined text styles
- **Spacing & Layout** - Consistent spacing and layout constants
- **Animations** - Predefined animation durations and curves 

### 🛠️ Utility Extensions
- **Widget Extensions** - `.padAll()`, `.center()`, `.shadow()`, etc.
- **String Extensions** - `.capitalize`, `.isEmail`, `.truncate()`, etc.
- **Date Extensions** - `.isToday`, `.relativeTime`, `.addDays()`, etc.

### 🌐 Services
- **HTTP Service** - Complete HTTP client with interceptors and error handling
- **Storage Service** - Local storage management with JSON support
- **Logging Service** - Comprehensive logging with multiple output options

### ⚙️ Infrastructure
- **Environment Config** - Multi-environment configuration management
- **Platform Utils** - Device and platform detection utilities

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

// Label styles
FCPTextStyles.labelLarge
FCPTextStyles.labelMedium
FCPTextStyles.labelSmall
```

### Constants

```dart
// Spacing
FCPConstants.spacingXs  // 4.0
FCPConstants.spacingSm  // 8.0
FCPConstants.spacingMd  // 16.0
FCPConstants.spacingLg  // 24.0
FCPConstants.spacingXl  // 32.0
FCPConstants.spacingXxl // 48.0

// Border radius
FCPConstants.radiusXs   // 2.0
FCPConstants.radiusSm   // 4.0
FCPConstants.radiusMd   // 8.0
FCPConstants.radiusLg   // 12.0
FCPConstants.radiusXl   // 16.0
FCPConstants.radiusXxl  // 24.0

// Font sizes
FCPConstants.fontSizeXs    // 10.0
FCPConstants.fontSizeSm    // 12.0
FCPConstants.fontSizeMd    // 14.0
FCPConstants.fontSizeLg    // 16.0
FCPConstants.fontSizeXl    // 18.0
FCPConstants.fontSizeXxl   // 20.0
FCPConstants.fontSizeXxxl  // 24.0

// Animation durations
FCPConstants.durationFast   // 150ms
FCPConstants.durationNormal // 300ms
FCPConstants.durationSlow   // 500ms
```

## 🧩 UI Components

### FCPButton - Fluent API Button Component

A highly customizable button widget with an intuitive fluent API that allows you to chain button types, sizes, and variants.

#### Features
- **Fluent API**: Chain methods like `FCPButton.small.primary()` or `FCPButton.large.outlined()`
- **Multiple Variants**: Primary, Secondary, Outlined, Ghost, Danger, Floating
- **Multiple Sizes**: Small, Medium, Large, Extra Large
- **Loading States**: Built-in loading indicators
- **Customizable**: Full control over colors, borders, padding, elevation, etc.

#### Basic Usage

```dart
// Primary buttons
FCPButton.small.primary(text: 'Small Primary')
FCPButton.medium.primary(text: 'Medium Primary')
FCPButton.large.primary(text: 'Large Primary')

// Outlined buttons
FCPButton.medium.outlined(text: 'Outlined Button')
FCPButton.large.outlined(
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

// Custom styling
FCPButton.large.primary(
  text: 'Custom Button',
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
  borderRadius: 25,
  elevation: 8,
  onPressed: () => customAction(),
)
```

### FCPCard - Unified Card Component

A comprehensive, unified card component with multiple factory constructors for different card types.

#### Features
- **Multiple Variants**: Basic, Flat, Shaded, Gradient, Info, Action cards
- **Shadow Types**: Small, Medium, Large, Soft, Hard shadows
- **Gradient Support**: Predefined and custom gradients
- **Interactive**: Tap, long press, and hover callbacks
- **Customizable**: Full control over styling and layout

#### Usage

```dart
// Basic card
FCPCard(
  child: Text('Simple card'),
)

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

A professional dropdown component that displays a bottom sheet with selectable items.

#### Features
- **Search Functionality**: Built-in search with debouncing
- **Customizable Styling**: Extensive customization options
- **Accessibility**: Full accessibility support
- **Custom Item Builder**: Support for custom item layouts
- **Extension Method**: Direct context.showFCPDropdownBottomSheet()

#### Usage

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

// With custom styling
FCPDropdownBottomSheet(
  title: 'Select Option',
  items: options,
  onItemSelected: (value) => handleSelection(value),
  prefixIcon: Icons.location_on,
  enableBorder: true,
  selectedIndex: 1,
  titleStyle: TextStyle(fontWeight: FontWeight.bold),
)
```

### FCPPdfViewer - Comprehensive PDF Viewer

A comprehensive PDF viewer component with enhanced features for displaying PDF documents.

#### Features
- **Multiple Sources**: Local files, network URLs, or app assets
- **Enhanced Controls**: Zoom controls, page navigation, search
- **Customizable UI**: Custom loading and error states
- **Interactive**: Text selection, document links, hyperlink navigation
- **Event Callbacks**: Comprehensive event handling

#### Usage

```dart
// Network PDF
FCPPdfViewer(
  pdfType: FCPPdfType.network,
  pdfUrl: 'https://example.com/sample.pdf',
  showZoomControls: true,
  showPageNavigationControls: true,
  showSearch: true,
  onDocumentLoaded: () => print('PDF loaded'),
  onPageChanged: (pageNumber) => setState(() => currentPage = pageNumber),
)

// Local PDF
FCPPdfViewer(
  pdfType: FCPPdfType.local,
  pdfPath: '/path/to/local/document.pdf',
  showZoomControls: true,
  enableTextSelection: true,
)

// Asset PDF
FCPPdfViewer(
  pdfType: FCPPdfType.assets,
  pdfPath: 'assets/documents/sample.pdf',
  showPageNavigationControls: true,
  backgroundColor: Colors.grey[100],
)
```

### FCPChart - Interactive Charts

A highly customizable chart component with fluent API for creating beautiful charts.

#### Features
- **Multiple Chart Types**: Area, Bar, Line, and Histogram charts
- **Fluent API**: Easy-to-use builder pattern
- **Fully Customizable**: Extensive configuration options
- **Interactive**: Built-in tooltips and touch interactions
- **Themes**: Predefined themes for quick styling

#### Usage

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

// Histogram
FCPChart.histogram.withData(
  data: histogramData,
  title: 'Age Distribution',
)
```

### FCPBLEComponent - Bluetooth Low Energy

A comprehensive BLE component for Bluetooth Low Energy operations.

#### Features
- **Device Scanning**: Scan for nearby BLE devices
- **Connection Management**: Connect and disconnect from devices
- **Permission Handling**: Automatic permission management
- **Service Discovery**: Automatically discover services and characteristics
- **Data Persistence**: Optional storage using SharedPreferences

#### Usage

```dart
// Basic BLE component
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

// Programmatic usage
final bleManager = BLEManager();
await bleManager.initialize(
  scanDuration: Duration(seconds: 10),
  usePrefs: true,
);

await bleManager.startScan();
await bleManager.connectToDevice(device);
```

### FCPSwitch - Customizable Switches

A comprehensive collection of customizable switch components.

#### Features
- **Multiple Types**: Toggle, Single-select, Multi-select switches
- **Customizable**: Colors, sizes, animations, labels
- **Predefined Configs**: iOS, Material, Compact, Large styles
- **Group Support**: Switch groups with consistent styling

#### Usage

```dart
// Basic toggle switch
FCPSwitch(
  value: isEnabled,
  onChanged: (value) => setState(() => isEnabled = value),
  label: 'Enable Feature',
  config: SwitchConfigs.iosStyle,
)

// Single select switch
FCPSingleSelectSwitch<String>(
  title: 'Choose Theme',
  options: [
    SwitchOption(value: 'light', label: 'Light', icon: Icons.light_mode),
    SwitchOption(value: 'dark', label: 'Dark', icon: Icons.dark_mode),
  ],
  selectedValue: selectedTheme,
  onChanged: (value) => setState(() => selectedTheme = value),
)

// Multi select switch
FCPMultiSelectSwitch<String>(
  title: 'Select Features',
  options: [
    SwitchOption(value: 'notifications', label: 'Notifications'),
    SwitchOption(value: 'location', label: 'Location'),
  ],
  selectedValues: selectedFeatures,
  onChanged: (values) => setState(() => selectedFeatures = values),
  maxSelections: 2,
  showSelectAll: true,
)
```

### FCPBottomNavigationBar - Modern Navigation

A customizable bottom navigation bar with asset-based icons.

#### Features
- **Asset-based Icons**: Support for regular and active icon states
- **Customizable Colors**: Background, selected, and unselected colors
- **Theme Integration**: Automatic theme adaptation
- **Accessibility**: Built-in accessibility support

#### Usage

```dart
FCPBottomNavigationBar(
  currentIndex: _currentIndex,
  onItemChanged: (index) => setState(() => _currentIndex = index),
  widgets: _pages,
  icons: _icons,
  activeIcons: _activeIcons,
  labels: _labels,
  backgroundColor: Colors.white,
  selectedItemColor: Colors.blue,
  unselectedItemColor: Colors.grey,
  elevation: 8,
)
```

### FCPDataTable - Advanced Data Tables

Advanced data tables with sorting, filtering, and pagination.

#### Features
- **Sorting**: Column-based sorting
- **Filtering**: Advanced filtering capabilities
- **Pagination**: Built-in pagination support
- **Customizable**: Themes, styling, and behavior
- **Performance**: Optimized for large datasets

#### Usage

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
Text('Hello').pad(left: 16, top: 8)

// Margin
Text('Hello').marginAll(16)
Text('Hello').marginHorizontal(16)
Text('Hello').marginVertical(16)

// Layout
Text('Hello').center()
Text('Hello').width(200)
Text('Hello').height(50)
Text('Hello').size(200, 50)
Text('Hello').square(100)

// Styling
Text('Hello').borderRadius(8)
Text('Hello').shadow()
Text('Hello').backgroundColor(Colors.blue)
Text('Hello').opacity(0.5)

// Transforms
Text('Hello').scale(1.2)
Text('Hello').rotate(0.5)
Text('Hello').translate(10, 20)

// Interactions
Text('Hello').onTap(() {})
Text('Hello').inkWell(onTap: () {})

// Animations
Text('Hello').animatedContainer(
  duration: Duration(milliseconds: 300),
  width: 200,
  height: 50,
)
```

### String Extensions

```dart
// Case conversion
'hello world'.capitalize        // 'Hello world'
'hello world'.titleCase        // 'Hello World'
'hello world'.camelCase        // 'helloWorld'
'hello world'.snakeCase        // 'hello_world'
'hello world'.kebabCase        // 'hello-world'
'hello world'.pascalCase       // 'HelloWorld'

// Validation
'user@example.com'.isEmail     // true
'https://example.com'.isUrl    // true
'+1234567890'.isPhoneNumber    // true
'12345'.isNumeric              // true
'hello'.isAlphabetic           // true
'hello123'.isAlphanumeric      // true

// Manipulation
'hello world'.truncate(5)      // 'hello...'
'hello world'.removeWhitespace // 'helloworld'
'hello world'.reversed         // 'dlrow olleh'

// Extraction
'hello123world'.extractNumbers // '123'
'hello123world'.extractLetters // 'helloworld'
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
now.isThisWeek                 // true
now.isThisMonth                // true
now.isThisYear                 // true

// Date manipulation
now.addDays(7)                 // Add 7 days
now.subtractDays(7)            // Subtract 7 days
now.addMonths(1)               // Add 1 month
now.addYears(1)                // Add 1 year

// Date ranges
now.startOfDay                 // 00:00:00
now.endOfDay                   // 23:59:59
now.startOfWeek                // Monday 00:00:00
now.endOfWeek                  // Sunday 23:59:59
now.startOfMonth               // 1st of month
now.endOfMonth                 // Last day of month

// Age calculation
DateTime(1990, 1, 1).age      // Current age in years

// Formatting
now.dayName                    // 'Monday'
now.shortDayName               // 'Mon'
now.monthName                  // 'January'
now.shortMonthName             // 'Jan'
```

## 🌐 Services

### HTTP Service

```dart
// Initialize
final httpService = FCPHttpService.instance;

// Set base URL
httpService.setBaseUrl('https://api.example.com');

// Add interceptors
httpService.addInterceptor(FCPLoggingInterceptor());
httpService.addInterceptor(FCPAuthInterceptor(token: 'your-token'));

// Make requests
final response = await httpService.get('/users');
final users = response.jsonBody;

// POST request
final createResponse = await httpService.post(
  '/users',
  body: {'name': 'John', 'email': 'john@example.com'},
);

// PUT request
final updateResponse = await httpService.put(
  '/users/1',
  body: {'name': 'John Updated'},
);

// DELETE request
await httpService.delete('/users/1');
```

### Storage Service

```dart
// Initialize
final storage = FCPStorageService.instance;
await storage.initialize();

// Store data
await storage.setString('user_name', 'John');
await storage.setInt('user_age', 25);
await storage.setBool('is_logged_in', true);
await storage.setJson('user_profile', {'name': 'John', 'age': 25});

// Retrieve data
final name = storage.getString('user_name');
final age = storage.getInt('user_age');
final isLoggedIn = storage.getBool('is_logged_in');
final profile = storage.getJson('user_profile');

// With defaults
final name = storage.getStringOrDefault('user_name', 'Guest');
final age = storage.getIntOrDefault('user_age', 0);
```

### Logging Service

```dart
// Initialize
final logger = FCPLoggingService.instance;

// Configure
logger.setMinLevel(FCPLogLevel.info);
logger.setConsoleOutput(true);

// Log messages
logger.debug('Debug message');
logger.info('Info message');
logger.warning('Warning message');
logger.error('Error message', error: Exception('Something went wrong'));

// Log with tags and data
logger.info(
  'User logged in',
  tag: 'AUTH',
  data: {'user_id': 123, 'method': 'email'},
);

// Add listeners
logger.addListener(FCPConsoleLogListener());
```

## ⚙️ Infrastructure

### Environment Configuration

```dart
// Initialize
final config = FCPEnvironmentConfig.instance;

// Set environment
config.setEnvironment(FCPEnvironment.production);

// Set configuration
config.setConfig('api_url', 'https://api.example.com');
config.setConfig('debug_mode', false);

// Get configuration
final apiUrl = config.getConfig<String>('api_url');
final debugMode = config.getConfigOrDefault('debug_mode', true);

// Environment-specific values
config.apiBaseUrl    // Automatically selects based on environment
config.appName       // App name with environment suffix
config.isDebugMode   // Debug mode based on environment
```

### Platform Utils

```dart
// Platform detection
FCPPlatformUtils.isWeb
FCPPlatformUtils.isIOS
FCPPlatformUtils.isAndroid
FCPPlatformUtils.isMobile
FCPPlatformUtils.isDesktop

// Device information
FCPPlatformUtils.platformName
FCPPlatformUtils.platformVersion
FCPPlatformUtils.deviceLocale
FCPPlatformUtils.deviceLanguage

// Device type detection
FCPPlatformUtils.getDeviceType(width, height)
FCPPlatformUtils.isPhone(width, height)
FCPPlatformUtils.isTablet(width, height)

// System information
final systemInfo = FCPPlatformUtils.getSystemInfo();
```

## 🛠️ CLI Tools

The package includes powerful command-line tools for managing components and permissions in your Flutter projects.

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

# List available permissions
fcp list permissions

# Add BLE permissions and complete BLE service
fcp add ble_permissions

# Add all permissions
fcp add permissions

# Add specific components
fcp add component chart
fcp add component table
fcp add component input_fields
fcp add component ble
fcp add component pdf_viewer

# Remove components or permissions
fcp remove ble_permissions
fcp remove component chart
```

### Component Management

The CLI automatically handles:
- Adding/removing dependencies to `pubspec.yaml`
- Managing platform permissions (Android/iOS)
- Updating configuration files
- Providing setup instructions

### Available Components

- **chart** - Interactive charts and graphs
- **table** - Data tables with sorting and filtering
- **button** - Customizable buttons
- **dropdown** - Advanced dropdown components
- **input_fields** - Text, password, search, and other input types
- **ble** - Complete Bluetooth Low Energy solution with service discovery
- **pdf_viewer** - PDF document viewer
- **switch** - Customizable toggle switches
- **navigation** - Navigation components

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

#### 🎨 **Beautiful Example App**
- Interactive UI with expandable dialogs and visual indicators
- Smart button states that adapt to connection status
- Real-time updates with stream-based state management
- Comprehensive usage instructions and error handling

**Total: 25 methods across 5 categories providing a complete BLE solution!**



## 🤝 Contributing

We welcome contributions!


## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for design inspiration
- All contributors and users of this package

---

Made with ❤️ for the Flutter community
