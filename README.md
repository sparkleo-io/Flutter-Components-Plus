# Flutter Components Plus

A comprehensive Flutter package providing highly customizable widgets, themes, and utilities for modern app development.

## 🚀 Features

### 🧩 UI Components
- **Customizable Buttons** - Primary, secondary, outline, ghost, and danger variants with loading states
- **Input Fields** - Text, password, search, and other input types (coming soon)
- **Dialogs & Sheets** - Bottom sheets, snackbars, and modal dialogs (coming soon)
- **Loaders** - Progress indicators, shimmer effects, pull-to-refresh (coming soon)
- **Cards & Tables** - Customizable cards and data tables (coming soon)
- **Navigation** - Custom navigation bars and tab bars (coming soon)
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

### 2. Use the custom button

```dart
FCPButton(
  text: 'Click Me',
  onPressed: () {
    print('Button pressed!');
  },
  variant: FCPButtonVariant.primary,
  size: FCPButtonSize.medium,
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

### FCPButton

A highly customizable button widget with multiple variants and states.

```dart
// Basic usage
FCPButton(
  text: 'Primary Button',
  onPressed: () {},
)

// With different variants
FCPButton(
  text: 'Secondary Button',
  variant: FCPButtonVariant.secondary,
  onPressed: () {},
)

FCPButton(
  text: 'Outline Button',
  variant: FCPButtonVariant.outline,
  onPressed: () {},
)

FCPButton(
  text: 'Ghost Button',
  variant: FCPButtonVariant.ghost,
  onPressed: () {},
)

FCPButton(
  text: 'Danger Button',
  variant: FCPButtonVariant.danger,
  onPressed: () {},
)

// Different sizes
FCPButton(
  text: 'Small Button',
  size: FCPButtonSize.small,
  onPressed: () {},
)

FCPButton(
  text: 'Large Button',
  size: FCPButtonSize.large,
  onPressed: () {},
)

// With loading state
FCPButton(
  text: 'Loading Button',
  isLoading: true,
  onPressed: () {},
)

// With icon
FCPButton(
  text: 'Button with Icon',
  icon: Icons.star,
  iconPosition: IconPosition.start,
  onPressed: () {},
)

// Custom styling
FCPButton(
  text: 'Custom Button',
  backgroundColor: Colors.purple,
  foregroundColor: Colors.white,
  borderRadius: 20,
  elevation: 8,
  onPressed: () {},
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

## 🎯 Roadmap

### Phase 1 (Current)
- ✅ Core design system (colors, text styles, constants)
- ✅ Custom button component
- ✅ Widget extensions
- ✅ String and date extensions
- ✅ HTTP service with interceptors
- ✅ Storage service
- ✅ Logging service
- ✅ Environment configuration
- ✅ Platform utilities

### Phase 2 (Next)
- 🔄 Input fields (text, password, search)
- 🔄 Dialogs and bottom sheets
- 🔄 Loaders and progress indicators
- 🔄 Cards and containers
- 🔄 Navigation components

### Phase 3 (Future)
- 📋 Tables and data grids
- 📋 Date and time pickers
- 📋 Charts and graphs
- 📋 Form builders
- 📋 Image and media components

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for design inspiration
- All contributors and users of this package

---

Made with ❤️ for the Flutter community
