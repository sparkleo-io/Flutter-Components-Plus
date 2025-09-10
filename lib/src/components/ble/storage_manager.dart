import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/ble_device_model.dart';

/// Manager for storing and retrieving BLE device data using SharedPreferences
class BLEStorageManager {
  static const String _devicesKey = 'ble_devices';
  static const String _connectedDeviceKey = 'connected_ble_device';
  static const String _scanHistoryKey = 'ble_scan_history';
  static const String _settingsKey = 'ble_settings';

  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  static Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Ensure SharedPreferences is initialized
  static Future<SharedPreferences> _getPrefs() async {
    if (_prefs == null) {
      await initialize();
    }
    return _prefs!;
  }

  /// Save a list of BLE devices
  static Future<bool> saveDevices(List<BLEDeviceModel> devices) async {
    try {
      final prefs = await _getPrefs();
      final devicesJson = devices
          .map((device) => device.toJsonString())
          .toList();
      return await prefs.setStringList(_devicesKey, devicesJson);
    } catch (e) {
      return false;
    }
  }

  /// Get all saved BLE devices
  static Future<List<BLEDeviceModel>> getDevices() async {
    try {
      final prefs = await _getPrefs();
      final devicesJson = prefs.getStringList(_devicesKey) ?? [];
      return devicesJson
          .map((json) => BLEDeviceModel.fromJsonString(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Save a single BLE device
  static Future<bool> saveDevice(BLEDeviceModel device) async {
    try {
      final devices = await getDevices();

      // Check if device already exists and update it
      final existingIndex = devices.indexWhere((d) => d.id == device.id);
      if (existingIndex != -1) {
        devices[existingIndex] = device;
      } else {
        devices.add(device);
      }

      return await saveDevices(devices);
    } catch (e) {
      return false;
    }
  }

  /// Remove a BLE device
  static Future<bool> removeDevice(String deviceId) async {
    try {
      final devices = await getDevices();
      devices.removeWhere((device) => device.id == deviceId);
      return await saveDevices(devices);
    } catch (e) {
      return false;
    }
  }

  /// Get a specific device by ID
  static Future<BLEDeviceModel?> getDevice(String deviceId) async {
    try {
      final devices = await getDevices();
      return devices.firstWhere(
        (device) => device.id == deviceId,
        orElse: () => throw StateError('Device not found'),
      );
    } catch (e) {
      return null;
    }
  }

  /// Save currently connected device
  static Future<bool> saveConnectedDevice(BLEDeviceModel device) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.setString(_connectedDeviceKey, device.toJsonString());
    } catch (e) {
      return false;
    }
  }

  /// Get currently connected device
  static Future<BLEDeviceModel?> getConnectedDevice() async {
    try {
      final prefs = await _getPrefs();
      final deviceJson = prefs.getString(_connectedDeviceKey);
      if (deviceJson != null) {
        return BLEDeviceModel.fromJsonString(deviceJson);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Clear connected device
  static Future<bool> clearConnectedDevice() async {
    try {
      final prefs = await _getPrefs();
      return await prefs.remove(_connectedDeviceKey);
    } catch (e) {
      return false;
    }
  }

  /// Save scan history
  static Future<bool> saveScanHistory(List<BLEDeviceModel> devices) async {
    try {
      final prefs = await _getPrefs();
      final devicesJson = devices
          .map((device) => device.toJsonString())
          .toList();
      return await prefs.setStringList(_scanHistoryKey, devicesJson);
    } catch (e) {
      return false;
    }
  }

  /// Get scan history
  static Future<List<BLEDeviceModel>> getScanHistory() async {
    try {
      final prefs = await _getPrefs();
      final devicesJson = prefs.getStringList(_scanHistoryKey) ?? [];
      return devicesJson
          .map((json) => BLEDeviceModel.fromJsonString(json))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// Clear scan history
  static Future<bool> clearScanHistory() async {
    try {
      final prefs = await _getPrefs();
      return await prefs.remove(_scanHistoryKey);
    } catch (e) {
      return false;
    }
  }

  /// Save BLE settings
  static Future<bool> saveSettings(Map<String, dynamic> settings) async {
    try {
      final prefs = await _getPrefs();
      return await prefs.setString(_settingsKey, jsonEncode(settings));
    } catch (e) {
      return false;
    }
  }

  /// Get BLE settings
  static Future<Map<String, dynamic>> getSettings() async {
    try {
      final prefs = await _getPrefs();
      final settingsJson = prefs.getString(_settingsKey);
      if (settingsJson != null) {
        return jsonDecode(settingsJson) as Map<String, dynamic>;
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  /// Update a specific setting
  static Future<bool> updateSetting(String key, dynamic value) async {
    try {
      final settings = await getSettings();
      settings[key] = value;
      return await saveSettings(settings);
    } catch (e) {
      return false;
    }
  }

  /// Get a specific setting
  static Future<T?> getSetting<T>(String key) async {
    try {
      final settings = await getSettings();
      return settings[key] as T?;
    } catch (e) {
      return null;
    }
  }

  /// Clear all BLE data
  static Future<bool> clearAllData() async {
    try {
      final prefs = await _getPrefs();
      await prefs.remove(_devicesKey);
      await prefs.remove(_connectedDeviceKey);
      await prefs.remove(_scanHistoryKey);
      await prefs.remove(_settingsKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get storage statistics
  static Future<Map<String, int>> getStorageStats() async {
    try {
      final devices = await getDevices();
      final scanHistory = await getScanHistory();
      final connectedDevice = await getConnectedDevice();

      return {
        'saved_devices': devices.length,
        'scan_history': scanHistory.length,
        'has_connected_device': connectedDevice != null ? 1 : 0,
      };
    } catch (e) {
      return {'saved_devices': 0, 'scan_history': 0, 'has_connected_device': 0};
    }
  }

  /// Check if storage is available
  static Future<bool> isStorageAvailable() async {
    try {
      await _getPrefs();
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Export all data as JSON
  static Future<String> exportData() async {
    try {
      final devices = await getDevices();
      final scanHistory = await getScanHistory();
      final connectedDevice = await getConnectedDevice();
      final settings = await getSettings();

      final exportData = {
        'devices': devices.map((d) => d.toJson()).toList(),
        'scan_history': scanHistory.map((d) => d.toJson()).toList(),
        'connected_device': connectedDevice?.toJson(),
        'settings': settings,
        'export_timestamp': DateTime.now().toIso8601String(),
      };

      return jsonEncode(exportData);
    } catch (e) {
      return '{}';
    }
  }

  /// Import data from JSON
  static Future<bool> importData(String jsonData) async {
    try {
      final data = jsonDecode(jsonData) as Map<String, dynamic>;

      // Import devices
      if (data['devices'] != null) {
        final devices = (data['devices'] as List<dynamic>)
            .map((d) => BLEDeviceModel.fromJson(d as Map<String, dynamic>))
            .toList();
        await saveDevices(devices);
      }

      // Import scan history
      if (data['scan_history'] != null) {
        final scanHistory = (data['scan_history'] as List<dynamic>)
            .map((d) => BLEDeviceModel.fromJson(d as Map<String, dynamic>))
            .toList();
        await saveScanHistory(scanHistory);
      }

      // Import connected device
      if (data['connected_device'] != null) {
        final connectedDevice = BLEDeviceModel.fromJson(
          data['connected_device'] as Map<String, dynamic>,
        );
        await saveConnectedDevice(connectedDevice);
      }

      // Import settings
      if (data['settings'] != null) {
        await saveSettings(data['settings'] as Map<String, dynamic>);
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}
