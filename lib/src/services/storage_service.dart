import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Storage service for managing local data persistence
class FCPStorageService {
  FCPStorageService._();

  static final FCPStorageService _instance = FCPStorageService._();
  static FCPStorageService get instance => _instance;

  SharedPreferences? _prefs;

  /// Initialize the storage service
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Check if storage is initialized
  bool get isInitialized => _prefs != null;

  /// Get SharedPreferences instance
  SharedPreferences get prefs {
    if (!isInitialized) {
      throw StateError(
        'Storage service not initialized. Call initialize() first.',
      );
    }
    return _prefs!;
  }

  // String operations
  /// Set string value
  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  /// Get string value
  String? getString(String key) {
    return prefs.getString(key);
  }

  /// Get string value with default
  String getStringOrDefault(String key, String defaultValue) {
    return prefs.getString(key) ?? defaultValue;
  }

  // Boolean operations
  /// Set boolean value
  Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  /// Get boolean value
  bool? getBool(String key) {
    return prefs.getBool(key);
  }

  /// Get boolean value with default
  bool getBoolOrDefault(String key, bool defaultValue) {
    return prefs.getBool(key) ?? defaultValue;
  }

  // Integer operations
  /// Set integer value
  Future<bool> setInt(String key, int value) async {
    return await prefs.setInt(key, value);
  }

  /// Get integer value
  int? getInt(String key) {
    return prefs.getInt(key);
  }

  /// Get integer value with default
  int getIntOrDefault(String key, int defaultValue) {
    return prefs.getInt(key) ?? defaultValue;
  }

  // Double operations
  /// Set double value
  Future<bool> setDouble(String key, double value) async {
    return await prefs.setDouble(key, value);
  }

  /// Get double value
  double? getDouble(String key) {
    return prefs.getDouble(key);
  }

  /// Get double value with default
  double getDoubleOrDefault(String key, double defaultValue) {
    return prefs.getDouble(key) ?? defaultValue;
  }

  // List operations
  /// Set string list
  Future<bool> setStringList(String key, List<String> value) async {
    return await prefs.setStringList(key, value);
  }

  /// Get string list
  List<String>? getStringList(String key) {
    return prefs.getStringList(key);
  }

  /// Get string list with default
  List<String> getStringListOrDefault(String key, List<String> defaultValue) {
    return prefs.getStringList(key) ?? defaultValue;
  }

  // JSON operations
  /// Set JSON object
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    return await prefs.setString(key, jsonEncode(value));
  }

  /// Get JSON object
  Map<String, dynamic>? getJson(String key) {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Get JSON object with default
  Map<String, dynamic> getJsonOrDefault(
    String key,
    Map<String, dynamic> defaultValue,
  ) {
    return getJson(key) ?? defaultValue;
  }

  /// Set JSON array
  Future<bool> setJsonArray(String key, List<dynamic> value) async {
    return await prefs.setString(key, jsonEncode(value));
  }

  /// Get JSON array
  List<dynamic>? getJsonArray(String key) {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    try {
      return jsonDecode(jsonString) as List<dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Get JSON array with default
  List<dynamic> getJsonArrayOrDefault(String key, List<dynamic> defaultValue) {
    return getJsonArray(key) ?? defaultValue;
  }

  // Object operations (using JSON serialization)
  /// Set object (serialized as JSON)
  Future<bool> setObject<T>(String key, T value) async {
    return await prefs.setString(key, jsonEncode(value));
  }

  /// Get object (deserialized from JSON)
  T? getObject<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Get object with default
  T getObjectOrDefault<T>(
    String key,
    T defaultValue,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return getObject(key, fromJson) ?? defaultValue;
  }

  // Utility operations
  /// Check if key exists
  bool containsKey(String key) {
    return prefs.containsKey(key);
  }

  /// Remove value for key
  Future<bool> remove(String key) async {
    return await prefs.remove(key);
  }

  /// Clear all data
  Future<bool> clear() async {
    return await prefs.clear();
  }

  /// Get all keys
  Set<String> getKeys() {
    return prefs.getKeys();
  }

  /// Get all values as map
  Map<String, dynamic> getAll() {
    final keys = prefs.getKeys();
    final Map<String, dynamic> result = {};

    for (final key in keys) {
      final value = prefs.get(key);
      if (value != null) {
        result[key] = value;
      }
    }

    return result;
  }

  /// Get storage size in bytes
  Future<int> getSize() async {
    final keys = prefs.getKeys();
    int size = 0;

    for (final key in keys) {
      final value = prefs.get(key);
      if (value != null) {
        size += key.length;
        if (value is String) {
          size += value.length;
        } else if (value is List) {
          size += value.length * 8; // Approximate size
        } else {
          size += 8; // Approximate size for numbers/booleans
        }
      }
    }

    return size;
  }

  /// Check if storage is empty
  bool get isEmpty => prefs.getKeys().isEmpty;

  /// Get number of stored items
  int get length => prefs.getKeys().length;

  // Migration helpers
  /// Migrate data from old key to new key
  Future<bool> migrateKey(String oldKey, String newKey) async {
    if (!containsKey(oldKey)) return false;

    final value = prefs.get(oldKey);
    if (value == null) return false;

    final success = await prefs.setString(newKey, value.toString());
    if (success) {
      await remove(oldKey);
    }
    return success;
  }

  /// Backup all data to JSON string
  String backupToJson() {
    final data = getAll();
    return jsonEncode(data);
  }

  /// Restore data from JSON string
  Future<bool> restoreFromJson(String jsonString) async {
    try {
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      bool success = true;

      for (final entry in data.entries) {
        final result = await prefs.setString(entry.key, entry.value.toString());
        if (!result) success = false;
      }

      return success;
    } catch (e) {
      return false;
    }
  }
}
