# FCP Infrastructure

Infrastructure utilities and configuration management for the Flutter Components Plus package.

## Features

- **Environment Configuration**: Environment-specific settings and configuration
- **Platform Utilities**: Cross-platform utilities and platform detection
- **Configuration Management**: Centralized configuration management
- **Environment Variables**: Environment variable handling
- **Platform Detection**: Platform-specific functionality

## Environment Configuration

### Basic Usage

#### Initialize Environment Configuration
```dart
final envConfig = FCPEnvironmentConfig(
  environment: Environment.development,
  apiBaseUrl: 'https://api-dev.example.com',
  debugMode: true,
  logLevel: LogLevel.debug,
);
```

#### Access Configuration
```dart
// Get current environment
final environment = envConfig.environment;
print('Current environment: $environment');

// Get API base URL
final apiUrl = envConfig.apiBaseUrl;
print('API URL: $apiUrl');

// Check if debug mode is enabled
final isDebug = envConfig.debugMode;
print('Debug mode: $isDebug');

// Get log level
final logLevel = envConfig.logLevel;
print('Log level: $logLevel');
```

#### Environment-Specific Configuration
```dart
// Development environment
final devConfig = FCPEnvironmentConfig.development(
  apiBaseUrl: 'https://api-dev.example.com',
  debugMode: true,
  logLevel: LogLevel.debug,
);

// Production environment
final prodConfig = FCPEnvironmentConfig.production(
  apiBaseUrl: 'https://api.example.com',
  debugMode: false,
  logLevel: LogLevel.error,
);

// Staging environment
final stagingConfig = FCPEnvironmentConfig.staging(
  apiBaseUrl: 'https://api-staging.example.com',
  debugMode: false,
  logLevel: LogLevel.info,
);
```

### Advanced Usage

#### Custom Environment Configuration
```dart
final customConfig = FCPEnvironmentConfig.custom(
  environment: Environment.custom,
  apiBaseUrl: 'https://api-custom.example.com',
  debugMode: true,
  logLevel: LogLevel.warning,
  customSettings: {
    'featureFlag1': true,
    'featureFlag2': false,
    'maxRetries': 3,
    'timeout': 30,
  },
);
```

#### Environment Variables
```dart
// Load from environment variables
final envConfig = FCPEnvironmentConfig.fromEnvironment(
  environment: Environment.fromString(Platform.environment['ENVIRONMENT'] ?? 'development'),
  apiBaseUrl: Platform.environment['API_BASE_URL'] ?? 'https://api.example.com',
  debugMode: Platform.environment['DEBUG_MODE'] == 'true',
  logLevel: LogLevel.fromString(Platform.environment['LOG_LEVEL'] ?? 'info'),
);
```

#### Configuration Validation
```dart
final envConfig = FCPEnvironmentConfig(
  environment: Environment.production,
  apiBaseUrl: 'https://api.example.com',
  debugMode: false,
  logLevel: LogLevel.error,
);

// Validate configuration
final isValid = envConfig.validate();
if (!isValid) {
  print('Configuration validation failed');
  return;
}

// Get validation errors
final errors = envConfig.getValidationErrors();
if (errors.isNotEmpty) {
  print('Validation errors: $errors');
}
```

## Platform Utilities

### Basic Platform Detection
```dart
// Check if running on specific platform
if (FCPPlatformUtils.isAndroid) {
  print('Running on Android');
} else if (FCPPlatformUtils.isIOS) {
  print('Running on iOS');
} else if (FCPPlatformUtils.isWeb) {
  print('Running on Web');
} else if (FCPPlatformUtils.isDesktop) {
  print('Running on Desktop');
}

// Get platform name
final platformName = FCPPlatformUtils.platformName;
print('Platform: $platformName');

// Get platform version
final platformVersion = FCPPlatformUtils.platformVersion;
print('Platform version: $platformVersion');
```

### Advanced Platform Detection
```dart
// Check if running on mobile
if (FCPPlatformUtils.isMobile) {
  print('Running on mobile device');
}

// Check if running on desktop
if (FCPPlatformUtils.isDesktop) {
  print('Running on desktop');
}

// Check if running on web
if (FCPPlatformUtils.isWeb) {
  print('Running on web');
}

// Check if running on specific OS
if (FCPPlatformUtils.isWindows) {
  print('Running on Windows');
} else if (FCPPlatformUtils.isMacOS) {
  print('Running on macOS');
} else if (FCPPlatformUtils.isLinux) {
  print('Running on Linux');
}
```

### Platform-Specific Utilities
```dart
// Get device information
final deviceInfo = await FCPPlatformUtils.getDeviceInfo();
print('Device: ${deviceInfo.deviceName}');
print('Model: ${deviceInfo.deviceModel}');
print('OS: ${deviceInfo.operatingSystem}');
print('OS Version: ${deviceInfo.operatingSystemVersion}');

// Check if device is tablet
final isTablet = await FCPPlatformUtils.isTablet();
print('Is tablet: $isTablet');

// Check if device is phone
final isPhone = await FCPPlatformUtils.isPhone();
print('Is phone: $isPhone');

// Get screen size category
final screenSize = await FCPPlatformUtils.getScreenSizeCategory();
print('Screen size: $screenSize');
```

### Platform-Specific Features
```dart
// Check if feature is supported
final isBluetoothSupported = await FCPPlatformUtils.isBluetoothSupported();
print('Bluetooth supported: $isBluetoothSupported');

final isLocationSupported = await FCPPlatformUtils.isLocationSupported();
print('Location supported: $isLocationSupported');

final isCameraSupported = await FCPPlatformUtils.isCameraSupported();
print('Camera supported: $isCameraSupported');

final isBiometricSupported = await FCPPlatformUtils.isBiometricSupported();
print('Biometric supported: $isBiometricSupported');
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class InfrastructureExample extends StatefulWidget {
  @override
  _InfrastructureExampleState createState() => _InfrastructureExampleState();
}

class _InfrastructureExampleState extends State<InfrastructureExample> {
  late FCPEnvironmentConfig _envConfig;
  late FCPPlatformInfo _platformInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeInfrastructure();
  }

  Future<void> _initializeInfrastructure() async {
    // Initialize environment configuration
    _envConfig = FCPEnvironmentConfig(
      environment: Environment.development,
      apiBaseUrl: 'https://api-dev.example.com',
      debugMode: true,
      logLevel: LogLevel.debug,
    );

    // Get platform information
    _platformInfo = await FCPPlatformUtils.getPlatformInfo();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Infrastructure Example')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Environment Configuration
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Environment Configuration',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Environment: ${_envConfig.environment}'),
                    Text('API URL: ${_envConfig.apiBaseUrl}'),
                    Text('Debug Mode: ${_envConfig.debugMode}'),
                    Text('Log Level: ${_envConfig.logLevel}'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _validateConfiguration,
                      child: Text('Validate Configuration'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Platform Information
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Platform Information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Platform: ${_platformInfo.platformName}'),
                    Text('Version: ${_platformInfo.platformVersion}'),
                    Text('Device: ${_platformInfo.deviceName}'),
                    Text('Model: ${_platformInfo.deviceModel}'),
                    Text('OS: ${_platformInfo.operatingSystem}'),
                    Text('OS Version: ${_platformInfo.operatingSystemVersion}'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _checkPlatformFeatures,
                      child: Text('Check Platform Features'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Platform Detection
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Platform Detection',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Is Android: ${FCPPlatformUtils.isAndroid}'),
                    Text('Is iOS: ${FCPPlatformUtils.isIOS}'),
                    Text('Is Web: ${FCPPlatformUtils.isWeb}'),
                    Text('Is Desktop: ${FCPPlatformUtils.isDesktop}'),
                    Text('Is Mobile: ${FCPPlatformUtils.isMobile}'),
                    Text('Is Windows: ${FCPPlatformUtils.isWindows}'),
                    Text('Is macOS: ${FCPPlatformUtils.isMacOS}'),
                    Text('Is Linux: ${FCPPlatformUtils.isLinux}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Environment Variables
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Environment Variables',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text('Environment: ${Platform.environment['ENVIRONMENT'] ?? 'Not set'}'),
                    Text('API URL: ${Platform.environment['API_BASE_URL'] ?? 'Not set'}'),
                    Text('Debug Mode: ${Platform.environment['DEBUG_MODE'] ?? 'Not set'}'),
                    Text('Log Level: ${Platform.environment['LOG_LEVEL'] ?? 'Not set'}'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadFromEnvironment,
                      child: Text('Load from Environment'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateConfiguration() {
    final isValid = _envConfig.validate();
    if (isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Configuration is valid')),
      );
    } else {
      final errors = _envConfig.getValidationErrors();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Configuration errors: $errors')),
      );
    }
  }

  void _checkPlatformFeatures() async {
    final features = <String, bool>{
      'Bluetooth': await FCPPlatformUtils.isBluetoothSupported(),
      'Location': await FCPPlatformUtils.isLocationSupported(),
      'Camera': await FCPPlatformUtils.isCameraSupported(),
      'Biometric': await FCPPlatformUtils.isBiometricSupported(),
    };

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Platform Features'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: features.entries.map((entry) {
            return Text('${entry.key}: ${entry.value ? "Supported" : "Not Supported"}');
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _loadFromEnvironment() {
    final envConfig = FCPEnvironmentConfig.fromEnvironment(
      environment: Environment.fromString(Platform.environment['ENVIRONMENT'] ?? 'development'),
      apiBaseUrl: Platform.environment['API_BASE_URL'] ?? 'https://api.example.com',
      debugMode: Platform.environment['DEBUG_MODE'] == 'true',
      logLevel: LogLevel.fromString(Platform.environment['LOG_LEVEL'] ?? 'info'),
    );

    setState(() {
      _envConfig = envConfig;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Configuration loaded from environment')),
    );
  }
}
```

## API Reference

### FCPEnvironmentConfig

| Property | Type | Description |
|----------|--------|-------------|
| `environment` | `Environment` | Current environment |
| `apiBaseUrl` | `String` | API base URL |
| `debugMode` | `bool` | Debug mode flag |
| `logLevel` | `LogLevel` | Log level |
| `customSettings` | `Map<String, dynamic>?` | Custom settings |

### FCPPlatformUtils

| Method | Type | Description |
|--------|------|-------------|
| `isAndroid` | `bool` | Check if running on Android |
| `isIOS` | `bool` | Check if running on iOS |
| `isWeb` | `bool` | Check if running on Web |
| `isDesktop` | `bool` | Check if running on Desktop |
| `isMobile` | `bool` | Check if running on mobile |
| `isWindows` | `bool` | Check if running on Windows |
| `isMacOS` | `bool` | Check if running on macOS |
| `isLinux` | `bool` | Check if running on Linux |
| `platformName` | `String` | Platform name |
| `platformVersion` | `String` | Platform version |
| `getDeviceInfo()` | `Future<FCPDeviceInfo>` | Get device information |
| `isTablet()` | `Future<bool>` | Check if device is tablet |
| `isPhone()` | `Future<bool>` | Check if device is phone |
| `getScreenSizeCategory()` | `Future<ScreenSizeCategory>` | Get screen size category |
| `isBluetoothSupported()` | `Future<bool>` | Check if Bluetooth is supported |
| `isLocationSupported()` | `Future<bool>` | Check if Location is supported |
| `isCameraSupported()` | `Future<bool>` | Check if Camera is supported |
| `isBiometricSupported()` | `Future<bool>` | Check if Biometric is supported |

### Environment

| Value | Description |
|-------|-------------|
| `development` | Development environment |
| `staging` | Staging environment |
| `production` | Production environment |
| `testing` | Testing environment |
| `custom` | Custom environment |

### LogLevel

| Value | Description |
|-------|-------------|
| `debug` | Debug level |
| `info` | Info level |
| `warning` | Warning level |
| `error` | Error level |
| `critical` | Critical level |

### ScreenSizeCategory

| Value | Description |
|-------|-------------|
| `small` | Small screen |
| `medium` | Medium screen |
| `large` | Large screen |
| `extraLarge` | Extra large screen |

## Best Practices

1. **Environment Management**: Use different configurations for different environments
2. **Platform Detection**: Use platform-specific features appropriately
3. **Configuration Validation**: Always validate configuration before use
4. **Environment Variables**: Use environment variables for sensitive configuration
5. **Platform Features**: Check feature support before using platform-specific APIs
6. **Error Handling**: Implement proper error handling for platform detection
7. **Testing**: Test on different platforms and environments

## Accessibility

- All infrastructure utilities support proper error handling
- Platform detection provides accurate information for accessibility features
- Environment configuration supports different accessibility settings
- Platform utilities include accessibility feature detection
