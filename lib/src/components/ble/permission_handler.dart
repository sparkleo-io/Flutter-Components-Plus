import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// Enum representing different permission states
enum BLEPermissionState {
  granted,
  denied,
  permanentlyDenied,
  restricted,
  limited,
  provisional,
}

/// Handler for BLE-related permissions (Bluetooth and Location)
class BLEPermissionHandler {
  /// Check if all required permissions and services are ready
  static Future<bool> areAllPermissionsGranted() async {
    final bluetoothGranted = await isBluetoothPermissionGranted();
    final locationGranted = await isLocationPermissionGranted();
    final bluetoothEnabled = await isBluetoothEnabled();
    final locationEnabled = await isLocationEnabled();
    return bluetoothGranted &&
        locationGranted &&
        bluetoothEnabled &&
        locationEnabled;
  }

  /// Check if Bluetooth is enabled
  static Future<bool> isBluetoothEnabled() async {
    try {
      final adapterState = await FlutterBluePlus.adapterState.first;
      return adapterState == BluetoothAdapterState.on;
    } catch (e) {
      return false;
    }
  }

  /// Check if Location services are enabled
  static Future<bool> isLocationEnabled() async {
    try {
      final serviceStatus = await Permission.location.serviceStatus;
      return serviceStatus == ServiceStatus.enabled;
    } catch (e) {
      return false;
    }
  }

  /// Turn on Bluetooth (Android only)
  static Future<bool> turnOnBluetooth() async {
    try {
      await FlutterBluePlus.turnOn();
      // Wait a moment for Bluetooth to turn on
      await Future.delayed(const Duration(seconds: 2));
      return await isBluetoothEnabled();
    } catch (e) {
      return false;
    }
  }

  /// Open Location settings
  static Future<bool> openLocationSettings() async {
    try {
      final status = await Permission.location.request();
      return status == PermissionStatus.granted;
    } catch (e) {
      return false;
    }
  }

  /// Check if Bluetooth permission is granted
  static Future<bool> isBluetoothPermissionGranted() async {
    if (await Permission.bluetooth.isGranted) {
      return true;
    }

    // For Android 12+, check for BluetoothScan and BluetoothConnect permissions
    if (await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothConnect.isGranted) {
      return true;
    }

    return false;
  }

  /// Check if Location permission is granted
  static Future<bool> isLocationPermissionGranted() async {
    return await Permission.location.isGranted ||
        await Permission.locationWhenInUse.isGranted ||
        await Permission.locationAlways.isGranted;
  }

  /// Request all required permissions
  static Future<Map<Permission, PermissionStatus>>
  requestAllPermissions() async {
    final permissions = <Permission>[
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
      Permission.locationWhenInUse,
    ];

    return await permissions.request();
  }

  /// Request Bluetooth permissions
  static Future<Map<Permission, PermissionStatus>>
  requestBluetoothPermissions() async {
    final permissions = <Permission>[
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ];

    return await permissions.request();
  }

  /// Request Location permissions
  static Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.locationWhenInUse.request();
  }

  /// Get permission status for a specific permission
  static Future<PermissionStatus> getPermissionStatus(
    Permission permission,
  ) async {
    return await permission.status;
  }

  /// Check if permission is permanently denied
  static Future<bool> isPermissionPermanentlyDenied(
    Permission permission,
  ) async {
    return await permission.isPermanentlyDenied;
  }

  /// Open app settings to allow user to manually grant permissions
  static Future<bool> openAppSettings() async {
    return await openAppSettings();
  }

  /// Show Bluetooth enable dialog
  static Future<bool> showBluetoothEnableDialog(
    BuildContext context, {
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title ?? 'Bluetooth Required'),
              content: Text(
                message ??
                    'Bluetooth is required to scan for and connect to BLE devices. Would you like to turn on Bluetooth?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(cancelText ?? 'Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(confirmText ?? 'Turn On Bluetooth'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// Show Location enable dialog
  static Future<bool> showLocationEnableDialog(
    BuildContext context, {
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title ?? 'Location Required'),
              content: Text(
                message ??
                    'Location services are required to scan for BLE devices. Would you like to enable Location services?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(cancelText ?? 'Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(confirmText ?? 'Enable Location'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// Show permission dialog with explanation
  static Future<bool> showPermissionDialog(
    BuildContext context, {
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
  }) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title ?? 'Permissions Required'),
              content: Text(
                message ??
                    'This app needs Bluetooth and Location permissions to scan for and connect to BLE devices. Please grant these permissions in the next dialog.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(cancelText ?? 'Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(confirmText ?? 'Grant Permissions'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  /// Comprehensive method to ensure all BLE requirements are met
  static Future<bool> ensureBLERequirements(
    BuildContext context, {
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    bool showDialogFirst = true,
  }) async {
    // Check if everything is already ready
    if (await areAllPermissionsGranted()) {
      return true;
    }

    // Check Bluetooth state
    final bluetoothEnabled = await isBluetoothEnabled();
    if (!bluetoothEnabled) {
      final userConfirmed = await showBluetoothEnableDialog(
        context,
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
      );

      if (!userConfirmed) {
        return false;
      }

      // Try to turn on Bluetooth
      final turnedOn = await turnOnBluetooth();
      if (!turnedOn) {
        // Show error dialog
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Bluetooth Error'),
            content: const Text(
              'Failed to turn on Bluetooth. Please turn on Bluetooth manually in your device settings.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return false;
      }
    }

    // Check Location state
    final locationEnabled = await isLocationEnabled();
    if (!locationEnabled) {
      final userConfirmed = await showLocationEnableDialog(
        context,
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
      );

      if (!userConfirmed) {
        return false;
      }

      // Try to enable Location
      final locationGranted = await openLocationSettings();
      if (!locationGranted) {
        // Show error dialog
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Location Error'),
            content: const Text(
              'Failed to enable Location services. Please enable Location services manually in your device settings.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return false;
      }
    }

    // Check and request permissions
    return await requestPermissionsWithDialog(
      context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      showDialogFirst: showDialogFirst,
    );
  }

  /// Request permissions with user-friendly dialog
  static Future<bool> requestPermissionsWithDialog(
    BuildContext context, {
    String? title,
    String? message,
    String? confirmText,
    String? cancelText,
    bool showDialogFirst = true,
  }) async {
    // Check if permissions are already granted
    if (await areAllPermissionsGranted()) {
      return true;
    }

    // Show explanation dialog first if requested
    if (showDialogFirst) {
      final userConfirmed = await showPermissionDialog(
        context,
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
      );

      if (!userConfirmed) {
        return false;
      }
    }

    // Request permissions
    final results = await requestAllPermissions();

    // Check if all permissions were granted
    bool allGranted = true;
    for (final status in results.values) {
      if (status != PermissionStatus.granted) {
        allGranted = false;
        break;
      }
    }

    // If not all granted, check for permanently denied permissions
    if (!allGranted) {
      final permanentlyDeniedPermissions = <Permission>[];

      for (final entry in results.entries) {
        if (entry.value == PermissionStatus.permanentlyDenied) {
          permanentlyDeniedPermissions.add(entry.key);
        }
      }

      // Show dialog for permanently denied permissions
      if (permanentlyDeniedPermissions.isNotEmpty) {
        final openSettings = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Permissions Required'),
              content: const Text(
                'Some permissions are permanently denied. Please go to app settings and manually grant the required permissions.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Open Settings'),
                ),
              ],
            );
          },
        );

        if (openSettings == true) {
          await openAppSettings();
        }
      }
    }

    return allGranted;
  }

  /// Get human-readable permission status
  static String getPermissionStatusText(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Granted';
      case PermissionStatus.denied:
        return 'Denied';
      case PermissionStatus.permanentlyDenied:
        return 'Permanently Denied';
      case PermissionStatus.restricted:
        return 'Restricted';
      case PermissionStatus.limited:
        return 'Limited';
      case PermissionStatus.provisional:
        return 'Provisional';
    }
  }

  /// Get list of required permissions for BLE
  static List<Permission> getRequiredPermissions() {
    return [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
      Permission.locationWhenInUse,
    ];
  }

  /// Check if device supports BLE
  static Future<bool> isBLESupported() async {
    try {
      // This is a basic check - in a real app you might want to check
      // if the device actually supports BLE
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get permission state enum from PermissionStatus
  static BLEPermissionState getPermissionState(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return BLEPermissionState.granted;
      case PermissionStatus.denied:
        return BLEPermissionState.denied;
      case PermissionStatus.permanentlyDenied:
        return BLEPermissionState.permanentlyDenied;
      case PermissionStatus.restricted:
        return BLEPermissionState.restricted;
      case PermissionStatus.limited:
        return BLEPermissionState.limited;
      case PermissionStatus.provisional:
        return BLEPermissionState.provisional;
    }
  }
}
