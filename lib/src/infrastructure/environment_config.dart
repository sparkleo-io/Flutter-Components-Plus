import 'dart:convert';

/// Environment types
enum FCPEnvironment { development, staging, production }

/// Environment configuration manager
class FCPEnvironmentConfig {
  FCPEnvironmentConfig._();

  static final FCPEnvironmentConfig _instance = FCPEnvironmentConfig._();
  static FCPEnvironmentConfig get instance => _instance;

  FCPEnvironment _environment = FCPEnvironment.development;
  final Map<String, dynamic> _config = {};

  /// Get current environment
  FCPEnvironment get environment => _environment;

  /// Check if current environment is development
  bool get isDevelopment => _environment == FCPEnvironment.development;

  /// Check if current environment is staging
  bool get isStaging => _environment == FCPEnvironment.staging;

  /// Check if current environment is production
  bool get isProduction => _environment == FCPEnvironment.production;

  /// Set environment
  void setEnvironment(FCPEnvironment environment) {
    _environment = environment;
  }

  /// Set configuration value
  void setConfig(String key, dynamic value) {
    _config[key] = value;
  }

  /// Get configuration value
  T? getConfig<T>(String key) {
    final value = _config[key];
    if (value is T) {
      return value;
    }
    return null;
  }

  /// Get configuration value with default
  T getConfigOrDefault<T>(String key, T defaultValue) {
    return getConfig<T>(key) ?? defaultValue;
  }

  /// Get all configuration
  Map<String, dynamic> getAllConfig() {
    return Map.unmodifiable(_config);
  }

  /// Clear all configuration
  void clearConfig() {
    _config.clear();
  }

  /// Load configuration from map
  void loadFromMap(Map<String, dynamic> config) {
    _config.addAll(config);
  }

  /// Get API base URL for current environment
  String get apiBaseUrl {
    switch (_environment) {
      case FCPEnvironment.development:
        return getConfig<String>('dev_api_url') ?? 'http://localhost:3000/api';
      case FCPEnvironment.staging:
        return getConfig<String>('staging_api_url') ??
            'https://staging-api.example.com/api';
      case FCPEnvironment.production:
        return getConfig<String>('prod_api_url') ??
            'https://api.example.com/api';
    }
  }

  /// Get app name for current environment
  String get appName {
    final baseName = getConfig<String>('app_name') ?? 'Flutter Components Plus';
    switch (_environment) {
      case FCPEnvironment.development:
        return '$baseName (Dev)';
      case FCPEnvironment.staging:
        return '$baseName (Staging)';
      case FCPEnvironment.production:
        return baseName;
    }
  }

  /// Get app version
  String get appVersion {
    return getConfig<String>('app_version') ?? '1.0.0';
  }

  /// Get build number
  String get buildNumber {
    return getConfig<String>('build_number') ?? '1';
  }

  /// Get debug mode status
  bool get isDebugMode {
    return getConfig<bool>('debug_mode') ?? !isProduction;
  }

  /// Get logging level
  String get loggingLevel {
    return getConfig<String>('logging_level') ?? 'info';
  }

  /// Get analytics enabled status
  bool get isAnalyticsEnabled {
    return getConfig<bool>('analytics_enabled') ?? isProduction;
  }

  /// Get crash reporting enabled status
  bool get isCrashReportingEnabled {
    return getConfig<bool>('crash_reporting_enabled') ?? isProduction;
  }

  /// Get feature flags
  Map<String, bool> get featureFlags {
    final flags = getConfig<Map<String, dynamic>>('feature_flags') ?? {};
    return flags.map(
      (key, value) => MapEntry(key, value is bool ? value : false),
    );
  }

  /// Check if feature is enabled
  bool isFeatureEnabled(String featureName) {
    return featureFlags[featureName] ?? false;
  }

  /// Get timeout duration for HTTP requests
  Duration get httpTimeout {
    final seconds = getConfig<int>('http_timeout_seconds') ?? 30;
    return Duration(seconds: seconds);
  }

  /// Get retry count for HTTP requests
  int get httpRetryCount {
    return getConfig<int>('http_retry_count') ?? 3;
  }

  /// Get cache duration
  Duration get cacheDuration {
    final minutes = getConfig<int>('cache_duration_minutes') ?? 15;
    return Duration(minutes: minutes);
  }

  /// Get maximum log file size
  int get maxLogFileSize {
    return getConfig<int>('max_log_file_size_mb') ?? 10;
  }

  /// Get database name
  String get databaseName {
    final baseName = getConfig<String>('database_name') ?? 'fcp_database';
    switch (_environment) {
      case FCPEnvironment.development:
        return '${baseName}_dev';
      case FCPEnvironment.staging:
        return '${baseName}_staging';
      case FCPEnvironment.production:
        return baseName;
    }
  }

  /// Get database version
  int get databaseVersion {
    return getConfig<int>('database_version') ?? 1;
  }

  /// Get encryption key
  String? get encryptionKey {
    return getConfig<String>('encryption_key');
  }

  /// Get push notification settings
  Map<String, dynamic> get pushNotificationSettings {
    return getConfig<Map<String, dynamic>>('push_notifications') ?? {};
  }

  /// Get social login settings
  Map<String, dynamic> get socialLoginSettings {
    return getConfig<Map<String, dynamic>>('social_login') ?? {};
  }

  /// Get payment settings
  Map<String, dynamic> get paymentSettings {
    return getConfig<Map<String, dynamic>>('payment') ?? {};
  }

  /// Get third-party service keys
  Map<String, String> get thirdPartyKeys {
    final keys = getConfig<Map<String, dynamic>>('third_party_keys') ?? {};
    return keys.map((key, value) => MapEntry(key, value.toString()));
  }

  /// Get third-party service key
  String? getThirdPartyKey(String serviceName) {
    return thirdPartyKeys[serviceName];
  }

  /// Validate configuration
  bool validateConfig() {
    final requiredKeys = ['app_name', 'app_version'];

    for (final key in requiredKeys) {
      if (!_config.containsKey(key)) {
        return false;
      }
    }

    return true;
  }

  /// Export configuration as JSON
  String exportConfig() {
    final exportData = {'environment': _environment.name, 'config': _config};

    return jsonEncode(exportData);
  }

  /// Import configuration from JSON
  bool importConfig(String jsonString) {
    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;

      if (data.containsKey('environment')) {
        final envName = data['environment'] as String;
        _environment = FCPEnvironment.values.firstWhere(
          (e) => e.name == envName,
          orElse: () => FCPEnvironment.development,
        );
      }

      if (data.containsKey('config')) {
        final config = data['config'] as Map<String, dynamic>;
        _config.clear();
        _config.addAll(config);
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}

/// Configuration keys constants
class FCPConfigKeys {
  FCPConfigKeys._();

  // App configuration
  static const String appName = 'app_name';
  static const String appVersion = 'app_version';
  static const String buildNumber = 'build_number';
  static const String debugMode = 'debug_mode';
  static const String loggingLevel = 'logging_level';

  // API configuration
  static const String devApiUrl = 'dev_api_url';
  static const String stagingApiUrl = 'staging_api_url';
  static const String prodApiUrl = 'prod_api_url';

  // Feature flags
  static const String featureFlags = 'feature_flags';

  // HTTP configuration
  static const String httpTimeoutSeconds = 'http_timeout_seconds';
  static const String httpRetryCount = 'http_retry_count';

  // Cache configuration
  static const String cacheDurationMinutes = 'cache_duration_minutes';

  // Logging configuration
  static const String maxLogFileSizeMb = 'max_log_file_size_mb';

  // Database configuration
  static const String databaseName = 'database_name';
  static const String databaseVersion = 'database_version';

  // Security configuration
  static const String encryptionKey = 'encryption_key';

  // Services configuration
  static const String analyticsEnabled = 'analytics_enabled';
  static const String crashReportingEnabled = 'crash_reporting_enabled';
  static const String pushNotifications = 'push_notifications';
  static const String socialLogin = 'social_login';
  static const String payment = 'payment';
  static const String thirdPartyKeys = 'third_party_keys';
}
