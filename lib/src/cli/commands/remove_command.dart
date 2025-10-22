import 'dart:io';
import '../permission_manager.dart';
import '../component_manager.dart';

/// Command handler for removing components and permissions
class RemoveCommand {
  final PermissionManager _permissionManager = PermissionManager();
  final ComponentManager _componentManager = ComponentManager();

  /// Run the remove command
  Future<void> run(List<String> arguments) async {
    if (arguments.isEmpty) {
      _showRemoveUsage();
      return;
    }

    final subcommand = arguments[0];
    final subArguments = arguments.skip(1).toList();

    switch (subcommand) {
      case 'ble_permissions':
        await _removeBLEPermissions();
        break;
      case 'permissions':
        await _removeAllPermissions();
        break;
      case 'component':
        await _removeComponent(subArguments);
        break;
      default:
        _showRemoveUsage();
    }
  }

  /// Remove BLE permissions from the Flutter app
  Future<void> _removeBLEPermissions() async {
    print('🗑️  Removing BLE permissions from your Flutter app...');

    try {
      await _permissionManager.removeBLEPermissions();
      print('✅ BLE permissions removed successfully!');
      print('');
      print('The following permissions have been removed:');
      print('  • Bluetooth');
      print('  • Bluetooth Scan (Android 12+)');
      print('  • Bluetooth Connect (Android 12+)');
      print('  • Location (BLE-related)');
      print('');
      print(
        'Note: You may need to manually remove BLE-related code from your app.',
      );
    } catch (e) {
      print('❌ Error removing BLE permissions: $e');
      exit(1);
    }
  }

  /// Remove all permissions from the Flutter app
  Future<void> _removeAllPermissions() async {
    print('🗑️  Removing all permissions from your Flutter app...');

    try {
      await _permissionManager.removeAllPermissions();
      print('✅ All permissions removed successfully!');
      print('');
      print(
        'Note: You may need to manually remove permission-related code from your app.',
      );
    } catch (e) {
      print('❌ Error removing permissions: $e');
      exit(1);
    }
  }

  /// Remove a specific component from the Flutter app
  Future<void> _removeComponent(List<String> arguments) async {
    final componentName = arguments.isNotEmpty ? arguments.first : null;

    if (componentName == null) {
      print('❌ Please specify a component name');
      print('');
      print('Available components:');
      print('  • chart');
      print('  • live_graph');
      print('  • table');
      print('  • button');
      print('  • card');
      print('  • dropdown');
      print('  • inline_dropdown');
      print('  • multi_select');
      print('  • input_field');
      print('  • ble');
      print('  • pdf_viewer');
      print('  • switch');
      print('  • navigation');
      print('  • themes');
      print('');
      print('Usage: fcp remove component <component_name>');
      return;
    }

    print('🗑️  Removing $componentName component from your Flutter app...');

    try {
      await _componentManager.removeComponent(componentName);
      print('✅ $componentName component removed successfully!');
      print('');
      print(
        'Note: You may need to manually remove component-related code from your app.',
      );
    } catch (e) {
      print('❌ Error removing $componentName component: $e');
      exit(1);
    }
  }

  /// Show usage information for the remove command
  void _showRemoveUsage() {
    print('''
Usage: fcp remove <subcommand> [arguments]

Available subcommands:
  ble_permissions    Remove BLE (Bluetooth Low Energy) permissions
  permissions        Remove all permissions
  component          Remove a specific component

Examples:
  fcp remove ble_permissions          # Remove BLE permissions
  fcp remove permissions              # Remove all permissions
  fcp remove component chart          # Remove chart component
  fcp remove component ble            # Remove BLE component

Run "fcp help" for more information.
''');
  }
}
