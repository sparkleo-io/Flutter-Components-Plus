// ignore_for_file: avoid_print
import 'dart:io';
import '../permission_manager.dart';
import '../component_manager.dart';

/// Command handler for adding components and permissions
class AddCommand {
  final PermissionManager _permissionManager = PermissionManager();
  final ComponentManager _componentManager = ComponentManager();

  /// Run the add command
  Future<void> run(List<String> arguments) async {
    if (arguments.isEmpty) {
      _showAddUsage();
      return;
    }

    final subcommand = arguments[0];
    final subArguments = arguments.skip(1).toList();

    switch (subcommand) {
      case 'permissions':
        await _addAllPermissions();
        break;
      case 'component':
        await _addComponent(subArguments);
        break;
      default:
        _showAddUsage();
    }
  }

  /// Add all necessary permissions to the Flutter app
  Future<void> _addAllPermissions() async {
    print('🔧 Adding all necessary permissions to your Flutter app...');

    try {
      await _permissionManager.addAllPermissions();
      print('✅ All permissions added successfully!');
      print('');
      print('The following permissions have been added:');
      print('  • Camera');
      print('  • Microphone');
      print('  • Storage');
      print('  • Internet');
      print('');
      print('Next steps:');
      print('  1. Run "flutter pub get" to install dependencies');
      print('  2. Test your app on a physical device');
      print('  3. Permissions will be requested as needed by your app');
    } catch (e) {
      print('❌ Error adding permissions: $e');
      exit(1);
    }
  }

  /// Add a specific component to the Flutter app
  Future<void> _addComponent(List<String> arguments) async {
    final componentName = arguments.isNotEmpty ? arguments.first : null;

    if (componentName == null) {
      print('❌ Please specify a component name');
      print('');
      print('Available components:');
      print('  • chart');
      print('  • quadrant_chart');
      print('  • live_graph');
      print('  • table');
      print('  • button');
      print('  • card');
      print('  • dropdown');
      print('  • inline_dropdown');
      print('  • multi_select');
      print('  • input_field');
      print('  • pdf_viewer');
      print('  • switch');
      print('  • navigation');
      print('  • themes');
      print('');
      print('Usage: fcp add component <component_name>');
      return;
    }

    print('🔧 Adding $componentName component to your Flutter app...');

    try {
      await _componentManager.addComponent(componentName);
      print('✅ $componentName component added successfully!');
      print('');
      print('Next steps:');
      print('  1. Run "flutter pub get" to install dependencies');
      print('  2. Import the component in your Dart files');
      print('  3. Use the component in your widgets');
    } catch (e) {
      print('❌ Error adding $componentName component: $e');
      exit(1);
    }
  }

  /// Show usage information for the add command
  void _showAddUsage() {
    print('''
Usage: fcp add <subcommand> [arguments]

Available subcommands:
  permissions        Add all necessary permissions
  component          Add a specific component

Examples:
  fcp add permissions              # Add all permissions
  fcp add component chart          # Add chart component
  fcp add component quadrant_chart # Add quadrant chart component

Run "fcp help" for more information.
''');
  }
}
