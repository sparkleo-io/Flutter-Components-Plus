import 'dart:convert';

/// Log levels for the logging service
enum FCPLogLevel { debug, info, warning, error, fatal }

/// Log entry model
class FCPLogEntry {
  const FCPLogEntry({
    required this.level,
    required this.message,
    required this.timestamp,
    this.tag,
    this.data,
    this.error,
    this.stackTrace,
  });

  final FCPLogLevel level;
  final String message;
  final DateTime timestamp;
  final String? tag;
  final Map<String, dynamic>? data;
  final Object? error;
  final StackTrace? stackTrace;

  @override
  String toString() {
    final levelStr = level.name.toUpperCase();
    final timeStr = timestamp.toIso8601String();
    final tagStr = tag != null ? '[$tag]' : '';
    final dataStr = data != null ? ' | Data: $data' : '';
    final errorStr = error != null ? ' | Error: $error' : '';

    return '[$levelStr] $timeStr$tagStr: $message$dataStr$errorStr';
  }
}

/// Logging service for the Flutter Components Plus package
class FCPLoggingService {
  FCPLoggingService._();

  static final FCPLoggingService _instance = FCPLoggingService._();
  static FCPLoggingService get instance => _instance;

  FCPLogLevel _minLevel = FCPLogLevel.debug;
  bool _enableConsoleOutput = true;
  bool _enableFileOutput = false;
  String? _logFilePath;
  final List<FCPLogEntry> _logBuffer = [];
  int _maxBufferSize = 1000;
  List<FCPLogListener> _listeners = [];

  /// Set minimum log level
  void setMinLevel(FCPLogLevel level) {
    _minLevel = level;
  }

  /// Enable/disable console output
  void setConsoleOutput(bool enabled) {
    _enableConsoleOutput = enabled;
  }

  /// Enable/disable file output
  void setFileOutput(bool enabled, {String? filePath}) {
    _enableFileOutput = enabled;
    _logFilePath = filePath;
  }

  /// Set maximum buffer size
  void setMaxBufferSize(int size) {
    _maxBufferSize = size;
    _trimBuffer();
  }

  /// Add log listener
  void addListener(FCPLogListener listener) {
    _listeners.add(listener);
  }

  /// Remove log listener
  void removeListener(FCPLogListener listener) {
    _listeners.remove(listener);
  }

  /// Clear all listeners
  void clearListeners() {
    _listeners.clear();
  }

  /// Log debug message
  void debug(String message, {String? tag, Map<String, dynamic>? data}) {
    _log(FCPLogLevel.debug, message, tag: tag, data: data);
  }

  /// Log info message
  void info(String message, {String? tag, Map<String, dynamic>? data}) {
    _log(FCPLogLevel.info, message, tag: tag, data: data);
  }

  /// Log warning message
  void warning(String message, {String? tag, Map<String, dynamic>? data}) {
    _log(FCPLogLevel.warning, message, tag: tag, data: data);
  }

  /// Log error message
  void error(
    String message, {
    String? tag,
    Map<String, dynamic>? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      FCPLogLevel.error,
      message,
      tag: tag,
      data: data,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log fatal message
  void fatal(
    String message, {
    String? tag,
    Map<String, dynamic>? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      FCPLogLevel.fatal,
      message,
      tag: tag,
      data: data,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log HTTP request
  void logHttpRequest(String method, String url, {Map<String, dynamic>? data}) {
    info('HTTP $method $url', tag: 'HTTP', data: data);
  }

  /// Log HTTP response
  void logHttpResponse(
    int statusCode,
    String url, {
    Map<String, dynamic>? data,
  }) {
    final level = statusCode >= 400 ? FCPLogLevel.error : FCPLogLevel.info;
    _log(level, 'HTTP $statusCode $url', tag: 'HTTP', data: data);
  }

  /// Log API call
  void logApiCall(String endpoint, {Map<String, dynamic>? data}) {
    info('API Call: $endpoint', tag: 'API', data: data);
  }

  /// Log user action
  void logUserAction(String action, {Map<String, dynamic>? data}) {
    info('User Action: $action', tag: 'USER', data: data);
  }

  /// Log performance metric
  void logPerformance(
    String metric,
    Duration duration, {
    Map<String, dynamic>? data,
  }) {
    info(
      'Performance: $metric took ${duration.inMilliseconds}ms',
      tag: 'PERFORMANCE',
      data: data,
    );
  }

  /// Get all log entries
  List<FCPLogEntry> getLogEntries() {
    return List.unmodifiable(_logBuffer);
  }

  /// Get log entries by level
  List<FCPLogEntry> getLogEntriesByLevel(FCPLogLevel level) {
    return _logBuffer.where((entry) => entry.level == level).toList();
  }

  /// Get log entries by tag
  List<FCPLogEntry> getLogEntriesByTag(String tag) {
    return _logBuffer.where((entry) => entry.tag == tag).toList();
  }

  /// Get recent log entries
  List<FCPLogEntry> getRecentLogEntries(int count) {
    return _logBuffer.take(count).toList();
  }

  /// Clear log buffer
  void clearLogs() {
    _logBuffer.clear();
  }

  /// Export logs to string
  String exportLogs() {
    return _logBuffer.map((entry) => entry.toString()).join('\n');
  }

  /// Export logs to JSON
  String exportLogsToJson() {
    final logs = _logBuffer
        .map(
          (entry) => {
            'level': entry.level.name,
            'message': entry.message,
            'timestamp': entry.timestamp.toIso8601String(),
            'tag': entry.tag,
            'data': entry.data,
            'error': entry.error?.toString(),
          },
        )
        .toList();

    return jsonEncode(logs);
  }

  /// Internal log method
  void _log(
    FCPLogLevel level,
    String message, {
    String? tag,
    Map<String, dynamic>? data,
    Object? error,
    StackTrace? stackTrace,
  }) {
    // Check minimum level
    if (level.index < _minLevel.index) {
      return;
    }

    // Create log entry
    final entry = FCPLogEntry(
      level: level,
      message: message,
      timestamp: DateTime.now(),
      tag: tag,
      data: data,
      error: error,
      stackTrace: stackTrace,
    );

    // Add to buffer
    _logBuffer.add(entry);
    _trimBuffer();

    // Console output
    if (_enableConsoleOutput) {
      _outputToConsole(entry);
    }

    // File output
    if (_enableFileOutput && _logFilePath != null) {
      _outputToFile(entry);
    }

    // Notify listeners
    for (final listener in _listeners) {
      listener.onLog(entry);
    }
  }

  /// Output to console
  void _outputToConsole(FCPLogEntry entry) {
    final emoji = _getLevelEmoji(entry.level);
    final color = _getLevelColor(entry.level);

    print('$emoji ${entry.toString()}');
  }

  /// Output to file
  void _outputToFile(FCPLogEntry entry) {
    // This would require dart:io, so we'll leave it as a placeholder
    // In a real implementation, you would write to a file here
  }

  /// Get level emoji
  String _getLevelEmoji(FCPLogLevel level) {
    switch (level) {
      case FCPLogLevel.debug:
        return '🐛';
      case FCPLogLevel.info:
        return 'ℹ️';
      case FCPLogLevel.warning:
        return '⚠️';
      case FCPLogLevel.error:
        return '❌';
      case FCPLogLevel.fatal:
        return '💀';
    }
  }

  /// Get level color (for console output)
  String _getLevelColor(FCPLogLevel level) {
    switch (level) {
      case FCPLogLevel.debug:
        return '\x1B[36m'; // Cyan
      case FCPLogLevel.info:
        return '\x1B[32m'; // Green
      case FCPLogLevel.warning:
        return '\x1B[33m'; // Yellow
      case FCPLogLevel.error:
        return '\x1B[31m'; // Red
      case FCPLogLevel.fatal:
        return '\x1B[35m'; // Magenta
    }
  }

  /// Trim buffer if it exceeds max size
  void _trimBuffer() {
    if (_logBuffer.length > _maxBufferSize) {
      _logBuffer.removeRange(0, _logBuffer.length - _maxBufferSize);
    }
  }
}

/// Log listener interface
abstract class FCPLogListener {
  /// Called when a new log entry is created
  void onLog(FCPLogEntry entry);
}

/// Console log listener
class FCPConsoleLogListener implements FCPLogListener {
  const FCPConsoleLogListener();

  @override
  void onLog(FCPLogEntry entry) {
    // Console output is already handled in the main service
  }
}

/// File log listener
class FCPFileLogListener implements FCPLogListener {
  const FCPFileLogListener({required this.filePath});

  final String filePath;

  @override
  void onLog(FCPLogEntry entry) {
    // File output implementation would go here
  }
}

/// Network log listener
class FCPNetworkLogListener implements FCPLogListener {
  const FCPNetworkLogListener({required this.endpoint});

  final String endpoint;

  @override
  void onLog(FCPLogEntry entry) {
    // Network logging implementation would go here
  }
}
