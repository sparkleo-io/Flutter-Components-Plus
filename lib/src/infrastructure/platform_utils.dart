import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';

/// Platform utilities for device and platform detection
class FCPPlatformUtils {
  FCPPlatformUtils._();

  /// Check if running on web
  static bool get isWeb => kIsWeb;

  /// Check if running on iOS
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// Check if running on Android
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// Check if running on macOS
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// Check if running on Windows
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// Check if running on Linux
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  /// Check if running on Fuchsia
  static bool get isFuchsia => !kIsWeb && Platform.isFuchsia;

  /// Check if running on mobile (iOS or Android)
  static bool get isMobile => isIOS || isAndroid;

  /// Check if running on desktop (macOS, Windows, or Linux)
  static bool get isDesktop => isMacOS || isWindows || isLinux;

  /// Get current platform name
  static String get platformName {
    if (isWeb) return 'web';
    if (isIOS) return 'ios';
    if (isAndroid) return 'android';
    if (isMacOS) return 'macos';
    if (isWindows) return 'windows';
    if (isLinux) return 'linux';
    if (isFuchsia) return 'fuchsia';
    return 'unknown';
  }

  /// Get platform version
  static String get platformVersion {
    if (isWeb) return 'web';
    try {
      return Platform.operatingSystemVersion;
    } catch (e) {
      return 'unknown';
    }
  }

  /// Get device locale
  static String get deviceLocale {
    try {
      return Platform.localeName;
    } catch (e) {
      return 'en_US';
    }
  }

  /// Get device locale language code
  static String get deviceLanguage {
    final locale = deviceLocale;
    return locale.split('_').first;
  }

  /// Get device locale country code
  static String get deviceCountry {
    final locale = deviceLocale;
    final parts = locale.split('_');
    return parts.length > 1 ? parts[1] : '';
  }

  /// Check if device is in portrait mode
  static bool isPortrait(double width, double height) {
    return height > width;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(double width, double height) {
    return width > height;
  }

  /// Get device type based on screen size
  static String getDeviceType(double width, double height) {
    final diagonal = sqrt(width * width + height * height);

    if (diagonal < 600) {
      return 'phone';
    } else if (diagonal < 900) {
      return 'tablet';
    } else {
      return 'desktop';
    }
  }

  /// Check if device is a phone
  static bool isPhone(double width, double height) {
    return getDeviceType(width, height) == 'phone';
  }

  /// Check if device is a tablet
  static bool isTablet(double width, double height) {
    return getDeviceType(width, height) == 'tablet';
  }

  /// Check if device is a desktop
  static bool isDesktopDevice(double width, double height) {
    return getDeviceType(width, height) == 'desktop';
  }

  /// Get screen density
  static double getScreenDensity(double width, double height) {
    return (width * height) / (width * height);
  }

  /// Check if device has high DPI display
  static bool hasHighDpiDisplay(double width, double height) {
    return getScreenDensity(width, height) > 2.0;
  }

  /// Get recommended font size based on device type
  static double getRecommendedFontSize(double width, double height) {
    final deviceType = getDeviceType(width, height);

    switch (deviceType) {
      case 'phone':
        return 14.0;
      case 'tablet':
        return 16.0;
      case 'desktop':
        return 18.0;
      default:
        return 14.0;
    }
  }

  /// Get recommended icon size based on device type
  static double getRecommendedIconSize(double width, double height) {
    final deviceType = getDeviceType(width, height);

    switch (deviceType) {
      case 'phone':
        return 24.0;
      case 'tablet':
        return 28.0;
      case 'desktop':
        return 32.0;
      default:
        return 24.0;
    }
  }

  /// Get recommended padding based on device type
  static double getRecommendedPadding(double width, double height) {
    final deviceType = getDeviceType(width, height);

    switch (deviceType) {
      case 'phone':
        return 16.0;
      case 'tablet':
        return 24.0;
      case 'desktop':
        return 32.0;
      default:
        return 16.0;
    }
  }

  /// Check if device supports haptic feedback
  static bool supportsHapticFeedback() {
    return isMobile;
  }

  /// Check if device supports camera
  static bool supportsCamera() {
    return isMobile;
  }

  /// Check if device supports GPS
  static bool supportsGPS() {
    return isMobile;
  }

  /// Check if device supports biometric authentication
  static bool supportsBiometrics() {
    return isMobile;
  }

  /// Check if device supports push notifications
  static bool supportsPushNotifications() {
    return isMobile;
  }

  /// Check if device supports file system access
  static bool supportsFileSystem() {
    return !isWeb;
  }

  /// Check if device supports local storage
  static bool supportsLocalStorage() {
    return true; // All platforms support some form of local storage
  }

  /// Check if device supports network connectivity
  static bool supportsNetworkConnectivity() {
    return true; // All platforms support network connectivity
  }

  /// Get available storage space (approximate)
  static Future<int?> getAvailableStorageSpace() async {
    // This would require platform-specific implementation
    // For now, return null to indicate not implemented
    return null;
  }

  /// Get total storage space (approximate)
  static Future<int?> getTotalStorageSpace() async {
    // This would require platform-specific implementation
    // For now, return null to indicate not implemented
    return null;
  }

  /// Get battery level (approximate)
  static Future<double?> getBatteryLevel() async {
    // This would require platform-specific implementation
    // For now, return null to indicate not implemented
    return null;
  }

  /// Check if device is charging
  static Future<bool?> isCharging() async {
    // This would require platform-specific implementation
    // For now, return null to indicate not implemented
    return null;
  }

  /// Get device model
  static String getDeviceModel() {
    try {
      if (isWeb) return 'Web Browser';
      return Platform.operatingSystem;
    } catch (e) {
      return 'Unknown';
    }
  }

  /// Get device manufacturer
  static String getDeviceManufacturer() {
    // This would require platform-specific implementation
    // For now, return a generic value
    if (isWeb) return 'Web';
    if (isIOS) return 'Apple';
    if (isAndroid) return 'Android';
    return 'Unknown';
  }

  /// Get app version
  static String getAppVersion() {
    // This would require platform-specific implementation
    // For now, return a placeholder
    return '1.0.0';
  }

  /// Get build number
  static String getBuildNumber() {
    // This would require platform-specific implementation
    // For now, return a placeholder
    return '1';
  }

  /// Check if app is running in debug mode
  static bool get isDebugMode => kDebugMode;

  /// Check if app is running in profile mode
  static bool get isProfileMode => kProfileMode;

  /// Check if app is running in release mode
  static bool get isReleaseMode => kReleaseMode;

  /// Get Flutter version
  static String getFlutterVersion() {
    // This would require platform-specific implementation
    // For now, return a placeholder
    return '3.0.0';
  }

  /// Get Dart version
  static String getDartVersion() {
    // This would require platform-specific implementation
    // For now, return a placeholder
    return '2.19.0';
  }

  /// Get system information
  static Map<String, dynamic> getSystemInfo() {
    return {
      'platform': platformName,
      'platformVersion': platformVersion,
      'deviceLocale': deviceLocale,
      'deviceLanguage': deviceLanguage,
      'deviceCountry': deviceCountry,
      'deviceModel': getDeviceModel(),
      'deviceManufacturer': getDeviceManufacturer(),
      'appVersion': getAppVersion(),
      'buildNumber': getBuildNumber(),
      'flutterVersion': getFlutterVersion(),
      'dartVersion': getDartVersion(),
      'isDebugMode': isDebugMode,
      'isProfileMode': isProfileMode,
      'isReleaseMode': isReleaseMode,
      'isWeb': isWeb,
      'isMobile': isMobile,
      'isDesktop': isDesktop,
    };
  }
}
