/// Command handler for listing available components and permissions
class ListCommand {
  /// Run the list command
  Future<void> run(List<String> arguments) async {
    if (arguments.isEmpty) {
      _showListUsage();
      return;
    }

    final subcommand = arguments[0];

    switch (subcommand) {
      case 'components':
        _listComponents();
        break;
      case 'permissions':
        _listPermissions();
        break;
      default:
        _showListUsage();
    }
  }

  /// List available components
  void _listComponents() {
    print('📦 Available Flutter Components Plus Components:');
    print('');

    final components = [
      {
        'name': 'chart',
        'description': 'Interactive charts and graphs (Line, Bar, Pie, etc.)',
        'dependencies': ['fl_chart'],
        'permissions': [],
      },
      {
        'name': 'table',
        'description': 'Data tables with sorting, filtering, and pagination',
        'dependencies': ['syncfusion_flutter_datagrid'],
        'permissions': [],
      },
      {
        'name': 'button',
        'description':
            'Customizable buttons with various styles and animations',
        'dependencies': [],
        'permissions': [],
      },
      {
        'name': 'dropdown',
        'description':
            'Advanced dropdown components with search and multi-select',
        'dependencies': [],
        'permissions': [],
      },
      {
        'name': 'ble',
        'description': 'Bluetooth Low Energy (BLE) device management',
        'dependencies': ['flutter_blue_plus', 'permission_handler'],
        'permissions': ['bluetooth', 'location'],
      },
      {
        'name': 'pdf_viewer',
        'description': 'PDF document viewer with zoom and navigation',
        'dependencies': ['syncfusion_flutter_pdfviewer'],
        'permissions': ['storage'],
      },
      {
        'name': 'switch',
        'description': 'Customizable toggle switches and controls',
        'dependencies': [],
        'permissions': [],
      },
      {
        'name': 'navigation',
        'description': 'Bottom navigation bar with animations',
        'dependencies': [],
        'permissions': [],
      },
    ];

    for (final component in components) {
      print('  📱 ${component['name']}');
      print('     ${component['description']}');

      if ((component['dependencies'] as List).isNotEmpty) {
        print(
          '     Dependencies: ${(component['dependencies'] as List).join(', ')}',
        );
      }

      if ((component['permissions'] as List).isNotEmpty) {
        print(
          '     Permissions: ${(component['permissions'] as List).join(', ')}',
        );
      }

      print('');
    }

    print('Usage: fcp add component <component_name>');
  }

  /// List available permissions
  void _listPermissions() {
    print('🔐 Available Permissions:');
    print('');

    final permissions = [
      {
        'name': 'bluetooth',
        'description': 'Bluetooth access for device communication',
        'platforms': ['Android', 'iOS'],
        'required_for': ['BLE component'],
      },
      {
        'name': 'bluetooth_scan',
        'description': 'Bluetooth scanning (Android 12+)',
        'platforms': ['Android'],
        'required_for': ['BLE component'],
      },
      {
        'name': 'bluetooth_connect',
        'description': 'Bluetooth connection (Android 12+)',
        'platforms': ['Android'],
        'required_for': ['BLE component'],
      },
      {
        'name': 'location',
        'description': 'Location access for BLE scanning and other features',
        'platforms': ['Android', 'iOS'],
        'required_for': ['BLE component'],
      },
      {
        'name': 'camera',
        'description': 'Camera access for photo capture',
        'platforms': ['Android', 'iOS'],
        'required_for': ['Camera features'],
      },
      {
        'name': 'microphone',
        'description': 'Microphone access for audio recording',
        'platforms': ['Android', 'iOS'],
        'required_for': ['Audio features'],
      },
      {
        'name': 'storage',
        'description': 'File system access for reading/writing files',
        'platforms': ['Android', 'iOS'],
        'required_for': ['PDF viewer', 'File operations'],
      },
      {
        'name': 'internet',
        'description': 'Internet access for network operations',
        'platforms': ['Android', 'iOS'],
        'required_for': ['HTTP requests', 'Online features'],
      },
    ];

    for (final permission in permissions) {
      print('  🔑 ${permission['name']}');
      print('     ${permission['description']}');
      print('     Platforms: ${(permission['platforms'] as List).join(', ')}');
      print(
        '     Required for: ${(permission['required_for'] as List).join(', ')}',
      );
      print('');
    }

    print('Usage: fcp add permissions          # Add all permissions');
    print('       fcp add ble_permissions      # Add BLE-related permissions');
  }

  /// Show usage information for the list command
  void _showListUsage() {
    print('''
Usage: fcp list <subcommand>

Available subcommands:
  components    List available components
  permissions   List available permissions

Examples:
  fcp list components           # List all available components
  fcp list permissions          # List all available permissions

Run "fcp help" for more information.
''');
  }
}
