import 'dart:io';
import 'package:path/path.dart' as path;
import 'file_utils.dart';

/// Manager for handling permission configurations
class PermissionManager {
  final FileUtils _fileUtils = FileUtils();

  /// Add BLE permissions to the Flutter app
  Future<void> addBLEPermissions() async {
    await _addAndroidBLEPermissions();
    await _addIOSBLEPermissions();
    await _addPubspecDependencies(['flutter_blue_plus', 'permission_handler']);
  }

  /// Add all necessary permissions to the Flutter app
  Future<void> addAllPermissions() async {
    await _addAndroidAllPermissions();
    await _addIOSAllPermissions();
    await _addPubspecDependencies([
      'flutter_blue_plus',
      'permission_handler',
      'camera',
      'microphone',
      'path_provider',
    ]);
  }

  /// Remove BLE permissions from the Flutter app
  Future<void> removeBLEPermissions() async {
    await _removeAndroidBLEPermissions();
    await _removeIOSBLEPermissions();
    await _removePubspecDependencies([
      'flutter_blue_plus',
      'permission_handler',
    ]);
  }

  /// Remove all permissions from the Flutter app
  Future<void> removeAllPermissions() async {
    await _removeAndroidAllPermissions();
    await _removeIOSAllPermissions();
    await _removePubspecDependencies([
      'flutter_blue_plus',
      'permission_handler',
      'camera',
      'microphone',
      'path_provider',
    ]);
  }

  /// Add Android BLE permissions
  Future<void> _addAndroidBLEPermissions() async {
    final androidManifestPath = path.join(
      'android',
      'app',
      'src',
      'main',
      'AndroidManifest.xml',
    );

    if (!await File(androidManifestPath).exists()) {
      print('⚠️  Android manifest not found. Skipping Android permissions.');
      return;
    }

    final manifestContent = await File(androidManifestPath).readAsString();

    // BLE permissions to add
    final blePermissions = [
      '<uses-permission android:name="android.permission.BLUETOOTH" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />',
      '<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />',
      '<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />',
      '<uses-feature android:name="android.hardware.bluetooth_le" android:required="true" />',
    ];

    String updatedContent = manifestContent;

    for (final permission in blePermissions) {
      if (!updatedContent.contains(permission)) {
        updatedContent = updatedContent.replaceFirst(
          '<application',
          '$permission\n    <application',
        );
      }
    }

    await File(androidManifestPath).writeAsString(updatedContent);
    print('✅ Android BLE permissions added');
  }

  /// Add Android all permissions
  Future<void> _addAndroidAllPermissions() async {
    final androidManifestPath = path.join(
      'android',
      'app',
      'src',
      'main',
      'AndroidManifest.xml',
    );

    if (!await File(androidManifestPath).exists()) {
      print('⚠️  Android manifest not found. Skipping Android permissions.');
      return;
    }

    final manifestContent = await File(androidManifestPath).readAsString();

    // All permissions to add
    final allPermissions = [
      '<uses-permission android:name="android.permission.BLUETOOTH" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />',
      '<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />',
      '<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />',
      '<uses-permission android:name="android.permission.CAMERA" />',
      '<uses-permission android:name="android.permission.RECORD_AUDIO" />',
      '<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />',
      '<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />',
      '<uses-permission android:name="android.permission.INTERNET" />',
      '<uses-feature android:name="android.hardware.bluetooth_le" android:required="true" />',
      '<uses-feature android:name="android.hardware.camera" android:required="false" />',
      '<uses-feature android:name="android.hardware.microphone" android:required="false" />',
    ];

    String updatedContent = manifestContent;

    for (final permission in allPermissions) {
      if (!updatedContent.contains(permission)) {
        updatedContent = updatedContent.replaceFirst(
          '<application',
          '$permission\n    <application',
        );
      }
    }

    await File(androidManifestPath).writeAsString(updatedContent);
    print('✅ Android permissions added');
  }

  /// Add iOS BLE permissions
  Future<void> _addIOSBLEPermissions() async {
    final iosInfoPlistPath = path.join('ios', 'Runner', 'Info.plist');

    if (!await File(iosInfoPlistPath).exists()) {
      print('⚠️  iOS Info.plist not found. Skipping iOS permissions.');
      return;
    }

    final plistContent = await File(iosInfoPlistPath).readAsString();

    // BLE permissions to add
    final blePermissions = [
      '<key>NSBluetoothAlwaysUsageDescription</key>',
      '<string>This app uses Bluetooth to connect to BLE devices.</string>',
      '<key>NSBluetoothPeripheralUsageDescription</key>',
      '<string>This app uses Bluetooth to connect to BLE devices.</string>',
      '<key>NSLocationWhenInUseUsageDescription</key>',
      '<string>This app uses location to scan for nearby BLE devices.</string>',
    ];

    String updatedContent = plistContent;

    for (int i = 0; i < blePermissions.length; i += 2) {
      final key = blePermissions[i];
      final value = blePermissions[i + 1];

      if (!updatedContent.contains(key)) {
        updatedContent = updatedContent.replaceFirst(
          '</dict>',
          '    $key\n    $value\n</dict>',
        );
      }
    }

    await File(iosInfoPlistPath).writeAsString(updatedContent);
    print('✅ iOS BLE permissions added');
  }

  /// Add iOS all permissions
  Future<void> _addIOSAllPermissions() async {
    final iosInfoPlistPath = path.join('ios', 'Runner', 'Info.plist');

    if (!await File(iosInfoPlistPath).exists()) {
      print('⚠️  iOS Info.plist not found. Skipping iOS permissions.');
      return;
    }

    final plistContent = await File(iosInfoPlistPath).readAsString();

    // All permissions to add
    final allPermissions = [
      '<key>NSBluetoothAlwaysUsageDescription</key>',
      '<string>This app uses Bluetooth to connect to BLE devices.</string>',
      '<key>NSBluetoothPeripheralUsageDescription</key>',
      '<string>This app uses Bluetooth to connect to BLE devices.</string>',
      '<key>NSLocationWhenInUseUsageDescription</key>',
      '<string>This app uses location to scan for nearby BLE devices.</string>',
      '<key>NSCameraUsageDescription</key>',
      '<string>This app uses the camera to take photos.</string>',
      '<key>NSMicrophoneUsageDescription</key>',
      '<string>This app uses the microphone to record audio.</string>',
      '<key>NSPhotoLibraryUsageDescription</key>',
      '<string>This app accesses the photo library to save and load images.</string>',
    ];

    String updatedContent = plistContent;

    for (int i = 0; i < allPermissions.length; i += 2) {
      final key = allPermissions[i];
      final value = allPermissions[i + 1];

      if (!updatedContent.contains(key)) {
        updatedContent = updatedContent.replaceFirst(
          '</dict>',
          '    $key\n    $value\n</dict>',
        );
      }
    }

    await File(iosInfoPlistPath).writeAsString(updatedContent);
    print('✅ iOS permissions added');
  }

  /// Remove Android BLE permissions
  Future<void> _removeAndroidBLEPermissions() async {
    final androidManifestPath = path.join(
      'android',
      'app',
      'src',
      'main',
      'AndroidManifest.xml',
    );

    if (!await File(androidManifestPath).exists()) {
      print(
        '⚠️  Android manifest not found. Skipping Android permissions removal.',
      );
      return;
    }

    final manifestContent = await File(androidManifestPath).readAsString();

    // BLE permissions to remove
    final blePermissions = [
      '<uses-permission android:name="android.permission.BLUETOOTH" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />',
      '<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />',
      '<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />',
      '<uses-feature android:name="android.hardware.bluetooth_le" android:required="true" />',
    ];

    String updatedContent = manifestContent;

    for (final permission in blePermissions) {
      updatedContent = updatedContent.replaceAll('$permission\n    ', '');
      updatedContent = updatedContent.replaceAll('$permission\n', '');
      updatedContent = updatedContent.replaceAll(permission, '');
    }

    await File(androidManifestPath).writeAsString(updatedContent);
    print('✅ Android BLE permissions removed');
  }

  /// Remove Android all permissions
  Future<void> _removeAndroidAllPermissions() async {
    final androidManifestPath = path.join(
      'android',
      'app',
      'src',
      'main',
      'AndroidManifest.xml',
    );

    if (!await File(androidManifestPath).exists()) {
      print(
        '⚠️  Android manifest not found. Skipping Android permissions removal.',
      );
      return;
    }

    final manifestContent = await File(androidManifestPath).readAsString();

    // All permissions to remove
    final allPermissions = [
      '<uses-permission android:name="android.permission.BLUETOOTH" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />',
      '<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />',
      '<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />',
      '<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />',
      '<uses-permission android:name="android.permission.CAMERA" />',
      '<uses-permission android:name="android.permission.RECORD_AUDIO" />',
      '<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />',
      '<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />',
      '<uses-permission android:name="android.permission.INTERNET" />',
      '<uses-feature android:name="android.hardware.bluetooth_le" android:required="true" />',
      '<uses-feature android:name="android.hardware.camera" android:required="false" />',
      '<uses-feature android:name="android.hardware.microphone" android:required="false" />',
    ];

    String updatedContent = manifestContent;

    for (final permission in allPermissions) {
      updatedContent = updatedContent.replaceAll('$permission\n    ', '');
      updatedContent = updatedContent.replaceAll('$permission\n', '');
      updatedContent = updatedContent.replaceAll(permission, '');
    }

    await File(androidManifestPath).writeAsString(updatedContent);
    print('✅ Android permissions removed');
  }

  /// Remove iOS BLE permissions
  Future<void> _removeIOSBLEPermissions() async {
    final iosInfoPlistPath = path.join('ios', 'Runner', 'Info.plist');

    if (!await File(iosInfoPlistPath).exists()) {
      print('⚠️  iOS Info.plist not found. Skipping iOS permissions removal.');
      return;
    }

    final plistContent = await File(iosInfoPlistPath).readAsString();

    // BLE permissions to remove
    final blePermissions = [
      '<key>NSBluetoothAlwaysUsageDescription</key>',
      '<string>This app uses Bluetooth to connect to BLE devices.</string>',
      '<key>NSBluetoothPeripheralUsageDescription</key>',
      '<string>This app uses Bluetooth to connect to BLE devices.</string>',
      '<key>NSLocationWhenInUseUsageDescription</key>',
      '<string>This app uses location to scan for nearby BLE devices.</string>',
    ];

    String updatedContent = plistContent;

    for (int i = 0; i < blePermissions.length; i += 2) {
      final key = blePermissions[i];
      final value = blePermissions[i + 1];

      updatedContent = updatedContent.replaceAll('    $key\n    $value\n', '');
    }

    await File(iosInfoPlistPath).writeAsString(updatedContent);
    print('✅ iOS BLE permissions removed');
  }

  /// Remove iOS all permissions
  Future<void> _removeIOSAllPermissions() async {
    final iosInfoPlistPath = path.join('ios', 'Runner', 'Info.plist');

    if (!await File(iosInfoPlistPath).exists()) {
      print('⚠️  iOS Info.plist not found. Skipping iOS permissions removal.');
      return;
    }

    final plistContent = await File(iosInfoPlistPath).readAsString();

    // All permissions to remove
    final allPermissions = [
      '<key>NSBluetoothAlwaysUsageDescription</key>',
      '<string>This app uses Bluetooth to connect to BLE devices.</string>',
      '<key>NSBluetoothPeripheralUsageDescription</key>',
      '<string>This app uses Bluetooth to connect to BLE devices.</string>',
      '<key>NSLocationWhenInUseUsageDescription</key>',
      '<string>This app uses location to scan for nearby BLE devices.</string>',
      '<key>NSCameraUsageDescription</key>',
      '<string>This app uses the camera to take photos.</string>',
      '<key>NSMicrophoneUsageDescription</key>',
      '<string>This app uses the microphone to record audio.</string>',
      '<key>NSPhotoLibraryUsageDescription</key>',
      '<string>This app accesses the photo library to save and load images.</string>',
    ];

    String updatedContent = plistContent;

    for (int i = 0; i < allPermissions.length; i += 2) {
      final key = allPermissions[i];
      final value = allPermissions[i + 1];

      updatedContent = updatedContent.replaceAll('    $key\n    $value\n', '');
    }

    await File(iosInfoPlistPath).writeAsString(updatedContent);
    print('✅ iOS permissions removed');
  }

  /// Add dependencies to pubspec.yaml
  Future<void> _addPubspecDependencies(List<String> dependencies) async {
    await _fileUtils.addDependenciesToPubspec(dependencies);
  }

  /// Remove dependencies from pubspec.yaml
  Future<void> _removePubspecDependencies(List<String> dependencies) async {
    await _fileUtils.removeDependenciesFromPubspec(dependencies);
  }
}
