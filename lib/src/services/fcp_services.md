# FCP Services

A collection of services for common app functionality including HTTP requests, logging, and storage.

## Services Overview

- **HTTP Service**: HTTP requests with retry logic and error handling
- **Logging Service**: Structured logging with different levels
- **Storage Service**: Local storage with encryption support

## HTTP Service

### Features
- GET, POST, PUT, DELETE requests
- Request/response interceptors
- Retry logic with exponential backoff
- Timeout handling
- Error handling and logging
- Request/response logging

### Basic Usage

#### Initialize HTTP Service
```dart
final httpService = FCPHttpService();
```

#### GET Request
```dart
final response = await httpService.get(
  'https://api.example.com/users',
  headers: {'Authorization': 'Bearer token'},
);

if (response.isSuccess) {
  print('Data: ${response.data}');
} else {
  print('Error: ${response.error}');
}
```

#### POST Request
```dart
final response = await httpService.post(
  'https://api.example.com/users',
  body: {
    'name': 'John Doe',
    'email': 'john@example.com',
  },
  headers: {'Content-Type': 'application/json'},
);

if (response.isSuccess) {
  print('User created: ${response.data}');
} else {
  print('Error: ${response.error}');
}
```

#### PUT Request
```dart
final response = await httpService.put(
  'https://api.example.com/users/1',
  body: {
    'name': 'Jane Doe',
    'email': 'jane@example.com',
  },
);

if (response.isSuccess) {
  print('User updated: ${response.data}');
}
```

#### DELETE Request
```dart
final response = await httpService.delete(
  'https://api.example.com/users/1',
);

if (response.isSuccess) {
  print('User deleted');
}
```

### Advanced Usage

#### Custom Configuration
```dart
final httpService = FCPHttpService(
  baseUrl: 'https://api.example.com',
  timeout: Duration(seconds: 30),
  retryCount: 3,
  retryDelay: Duration(seconds: 1),
  enableLogging: true,
);
```

#### Request Interceptor
```dart
httpService.addRequestInterceptor((request) {
  // Add authentication token
  request.headers['Authorization'] = 'Bearer ${getAuthToken()}';
  return request;
});
```

#### Response Interceptor
```dart
httpService.addResponseInterceptor((response) {
  // Log response
  print('Response: ${response.statusCode} ${response.data}');
  return response;
});
```

#### Error Handling
```dart
try {
  final response = await httpService.get('/users');
  
  if (response.isSuccess) {
    // Handle success
    print('Users: ${response.data}');
  } else {
    // Handle error
    switch (response.statusCode) {
      case 401:
        print('Unauthorized - redirect to login');
        break;
      case 404:
        print('Resource not found');
        break;
      case 500:
        print('Server error');
        break;
      default:
        print('Unknown error: ${response.error}');
    }
  }
} catch (e) {
  print('Request failed: $e');
}
```

## Logging Service

### Features
- Multiple log levels (debug, info, warning, error)
- Structured logging with context
- Log filtering and formatting
- File and console output
- Log rotation and cleanup

### Basic Usage

#### Initialize Logging Service
```dart
final loggingService = FCPLoggingService();
```

#### Log Messages
```dart
// Debug level
loggingService.debug('Debug message', context: {'userId': '123'});

// Info level
loggingService.info('User logged in', context: {'userId': '123'});

// Warning level
loggingService.warning('Deprecated API used', context: {'api': 'old-api'});

// Error level
loggingService.error('Database connection failed', 
  context: {'database': 'users'}, 
  error: Exception('Connection timeout'),
);
```

#### Log with Context
```dart
loggingService.info('API request', context: {
  'method': 'GET',
  'url': '/api/users',
  'statusCode': 200,
  'responseTime': '150ms',
});
```

### Advanced Usage

#### Custom Log Configuration
```dart
final loggingService = FCPLoggingService(
  level: LogLevel.info,
  enableConsole: true,
  enableFile: true,
  logDirectory: 'logs',
  maxFileSize: 10 * 1024 * 1024, // 10MB
  maxFiles: 5,
  format: LogFormat.json,
);
```

#### Log Filtering
```dart
loggingService.addFilter((log) {
  // Only log errors in production
  return log.level == LogLevel.error;
});
```

#### Custom Log Formatter
```dart
loggingService.setFormatter((log) {
  return '${log.timestamp} [${log.level}] ${log.message}';
});
```

## Storage Service

### Features
- Key-value storage
- Encryption support
- Data serialization
- Backup and restore
- Data migration

### Basic Usage

#### Initialize Storage Service
```dart
final storageService = FCPStorageService();
```

#### Store Data
```dart
// Store string
await storageService.setString('username', 'john_doe');

// Store integer
await storageService.setInt('age', 25);

// Store boolean
await storageService.setBool('isLoggedIn', true);

// Store object
await storageService.setObject('user', {
  'name': 'John Doe',
  'email': 'john@example.com',
  'age': 25,
});
```

#### Retrieve Data
```dart
// Retrieve string
final username = await storageService.getString('username');
print('Username: $username');

// Retrieve integer
final age = await storageService.getInt('age');
print('Age: $age');

// Retrieve boolean
final isLoggedIn = await storageService.getBool('isLoggedIn');
print('Is logged in: $isLoggedIn');

// Retrieve object
final user = await storageService.getObject('user');
print('User: $user');
```

#### Remove Data
```dart
// Remove specific key
await storageService.remove('username');

// Clear all data
await storageService.clear();
```

### Advanced Usage

#### Encrypted Storage
```dart
final storageService = FCPStorageService(
  encryptionKey: 'your-encryption-key',
  enableEncryption: true,
);
```

#### Data Migration
```dart
storageService.addMigration((oldVersion, newVersion) {
  if (oldVersion < 2) {
    // Migrate data from version 1 to 2
    final oldData = storageService.getObject('old_key');
    storageService.setObject('new_key', oldData);
    storageService.remove('old_key');
  }
});
```

#### Backup and Restore
```dart
// Create backup
final backup = await storageService.createBackup();
print('Backup created: ${backup.length} bytes');

// Restore from backup
await storageService.restoreFromBackup(backup);
print('Data restored from backup');
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class ServicesExample extends StatefulWidget {
  @override
  _ServicesExampleState createState() => _ServicesExampleState();
}

class _ServicesExampleState extends State<ServicesExample> {
  final _httpService = FCPHttpService();
  final _loggingService = FCPLoggingService();
  final _storageService = FCPStorageService();

  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  void _initializeServices() async {
    _loggingService.info('Services initialized');

    final username = await _storageService.getString('username');
    if (username != null) {
      _loggingService.info('Loaded username: $username');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Services Example')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HTTP Service
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('HTTP Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('HTTP requests and API calls'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _makeHTTPRequest,
                      child: Text('Make HTTP Request'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Logging Service
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Logging Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Structured logging and debugging'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _logMessage,
                      child: Text('Log Message'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Storage Service
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Storage Service', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Local storage and data persistence'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _storeData,
                      child: Text('Store Data'),
                    ),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _retrieveData,
                      child: Text('Retrieve Data'),
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

  void _makeHTTPRequest() async {
    _loggingService.info('Making HTTP request');
    
    try {
      final response = await _httpService.get('https://jsonplaceholder.typicode.com/posts/1');
      
      if (response.isSuccess) {
        _loggingService.info('HTTP request successful: ${response.data}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('HTTP request successful')),
        );
      } else {
        _loggingService.error('HTTP request failed: ${response.error}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('HTTP request failed: ${response.error}')),
        );
      }
    } catch (e) {
      _loggingService.error('HTTP request exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('HTTP request failed: $e')),
      );
    }
  }

  void _logMessage() {
    _loggingService.info('User tapped log message button', context: {
      'timestamp': DateTime.now().toIso8601String(),
      'action': 'button_tap',
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Message logged')),
    );
  }

  void _storeData() async {
    await _storageService.setString('username', 'john_doe');
    await _storageService.setInt('age', 25);
    await _storageService.setBool('isLoggedIn', true);
    
    _loggingService.info('Data stored successfully');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data stored')),
    );
  }

  void _retrieveData() async {
    final username = await _storageService.getString('username');
    final age = await _storageService.getInt('age');
    final isLoggedIn = await _storageService.getBool('isLoggedIn');
    
    _loggingService.info('Data retrieved: username=$username, age=$age, isLoggedIn=$isLoggedIn');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data retrieved: $username, $age, $isLoggedIn')),
    );
  }
}
```

## Best Practices

1. **Service Lifecycle**: Properly initialize and dispose services
2. **Error Handling**: Implement comprehensive error handling
3. **Logging**: Use structured logging for debugging
4. **Storage**: Encrypt sensitive data in storage
5. **Performance**: Use appropriate timeouts and retry logic
6. **Security**: Handle authentication tokens securely
7. **Testing**: Write unit tests for service functionality

## Accessibility

- All services support proper error handling and user feedback
- Logging service provides structured information for debugging
- Storage service maintains data integrity and security
- HTTP service provides clear error messages and status codes
