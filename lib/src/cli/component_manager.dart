import 'dart:io';
import 'package:path/path.dart' as path;
import 'file_utils.dart';

/// Manager for handling component configurations
class ComponentManager {
  final FileUtils _fileUtils = FileUtils();

  /// Add a component to the Flutter app
  Future<void> addComponent(String componentName) async {
    switch (componentName.toLowerCase()) {
      case 'chart':
        await _addChartComponent();
        break;
      case 'table':
        await _addTableComponent();
        break;
      case 'button':
        await _addButtonComponent();
        break;
      case 'dropdown':
        await _addDropdownComponent();
        break;
      case 'ble':
        await _addBLEComponent();
        break;
      case 'pdf_viewer':
        await _addPDFViewerComponent();
        break;
      case 'switch':
        await _addSwitchComponent();
        break;
      case 'navigation':
        await _addNavigationComponent();
        break;
      default:
        throw Exception('Unknown component: $componentName');
    }
  }

  /// Remove a component from the Flutter app
  Future<void> removeComponent(String componentName) async {
    switch (componentName.toLowerCase()) {
      case 'chart':
        await _removeChartComponent();
        break;
      case 'table':
        await _removeTableComponent();
        break;
      case 'button':
        await _removeButtonComponent();
        break;
      case 'dropdown':
        await _removeDropdownComponent();
        break;
      case 'ble':
        await _removeBLEComponent();
        break;
      case 'pdf_viewer':
        await _removePDFViewerComponent();
        break;
      case 'switch':
        await _removeSwitchComponent();
        break;
      case 'navigation':
        await _removeNavigationComponent();
        break;
      default:
        throw Exception('Unknown component: $componentName');
    }
  }

  /// Add chart component
  Future<void> _addChartComponent() async {
    await _addPubspecDependencies(['fl_chart']);
    await _createExampleFile('chart_example.dart', _getChartExampleContent());
    print('✅ Chart component added');
  }

  /// Add table component
  Future<void> _addTableComponent() async {
    await _addPubspecDependencies(['syncfusion_flutter_datagrid']);
    await _createExampleFile('table_example.dart', _getTableExampleContent());
    print('✅ Table component added');
  }

  /// Add button component
  Future<void> _addButtonComponent() async {
    await _createExampleFile('button_example.dart', _getButtonExampleContent());
    print('✅ Button component added');
  }

  /// Add dropdown component
  Future<void> _addDropdownComponent() async {
    await _createExampleFile(
      'dropdown_example.dart',
      _getDropdownExampleContent(),
    );
    print('✅ Dropdown component added');
  }

  /// Add BLE component
  Future<void> _addBLEComponent() async {
    await _addPubspecDependencies(['flutter_blue_plus', 'permission_handler']);
    await _createExampleFile('ble_example.dart', _getBLEExampleContent());
    print('✅ BLE component added');
  }

  /// Add PDF viewer component
  Future<void> _addPDFViewerComponent() async {
    await _addPubspecDependencies(['syncfusion_flutter_pdfviewer']);
    await _createExampleFile(
      'pdf_viewer_example.dart',
      _getPDFViewerExampleContent(),
    );
    print('✅ PDF viewer component added');
  }

  /// Add switch component
  Future<void> _addSwitchComponent() async {
    await _createExampleFile('switch_example.dart', _getSwitchExampleContent());
    print('✅ Switch component added');
  }

  /// Add navigation component
  Future<void> _addNavigationComponent() async {
    await _createExampleFile(
      'navigation_example.dart',
      _getNavigationExampleContent(),
    );
    print('✅ Navigation component added');
  }

  /// Remove chart component
  Future<void> _removeChartComponent() async {
    await _removePubspecDependencies(['fl_chart']);
    await _removeExampleFile('chart_example.dart');
    print('✅ Chart component removed');
  }

  /// Remove table component
  Future<void> _removeTableComponent() async {
    await _removePubspecDependencies(['syncfusion_flutter_datagrid']);
    await _removeExampleFile('table_example.dart');
    print('✅ Table component removed');
  }

  /// Remove button component
  Future<void> _removeButtonComponent() async {
    await _removeExampleFile('button_example.dart');
    print('✅ Button component removed');
  }

  /// Remove dropdown component
  Future<void> _removeDropdownComponent() async {
    await _removeExampleFile('dropdown_example.dart');
    print('✅ Dropdown component removed');
  }

  /// Remove BLE component
  Future<void> _removeBLEComponent() async {
    await _removePubspecDependencies([
      'flutter_blue_plus',
      'permission_handler',
    ]);
    await _removeExampleFile('ble_example.dart');
    print('✅ BLE component removed');
  }

  /// Remove PDF viewer component
  Future<void> _removePDFViewerComponent() async {
    await _removePubspecDependencies(['syncfusion_flutter_pdfviewer']);
    await _removeExampleFile('pdf_viewer_example.dart');
    print('✅ PDF viewer component removed');
  }

  /// Remove switch component
  Future<void> _removeSwitchComponent() async {
    await _removeExampleFile('switch_example.dart');
    print('✅ Switch component removed');
  }

  /// Remove navigation component
  Future<void> _removeNavigationComponent() async {
    await _removeExampleFile('navigation_example.dart');
    print('✅ Navigation component removed');
  }

  /// Add dependencies to pubspec.yaml
  Future<void> _addPubspecDependencies(List<String> dependencies) async {
    await _fileUtils.addDependenciesToPubspec(dependencies);
  }

  /// Remove dependencies from pubspec.yaml
  Future<void> _removePubspecDependencies(List<String> dependencies) async {
    await _fileUtils.removeDependenciesFromPubspec(dependencies);
  }

  /// Create example file
  Future<void> _createExampleFile(String fileName, String content) async {
    final examplesDir = Directory('examples');
    if (!await examplesDir.exists()) {
      await examplesDir.create();
    }

    final file = File(path.join('examples', fileName));
    await file.writeAsString(content);
  }

  /// Remove example file
  Future<void> _removeExampleFile(String fileName) async {
    final file = File(path.join('examples', fileName));
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Get chart example content
  String _getChartExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class ChartExample extends StatelessWidget {
  const ChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chart Example')),
      body: const Center(
        child: FCPChart(
          chartType: ChartType.line,
          data: [
            ChartDataPoint(x: 1, y: 10),
            ChartDataPoint(x: 2, y: 20),
            ChartDataPoint(x: 3, y: 15),
            ChartDataPoint(x: 4, y: 25),
          ],
        ),
      ),
    );
  }
}
''';
  }

  /// Get table example content
  String _getTableExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class TableExample extends StatelessWidget {
  const TableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Table Example')),
      body: const FCPDataTable(
        columns: [
          DataTableColumn(title: 'Name', field: 'name'),
          DataTableColumn(title: 'Age', field: 'age'),
          DataTableColumn(title: 'Email', field: 'email'),
        ],
        data: [
          {'name': 'John Doe', 'age': 30, 'email': 'john@example.com'},
          {'name': 'Jane Smith', 'age': 25, 'email': 'jane@example.com'},
        ],
      ),
    );
  }
}
''';
  }

  /// Get button example content
  String _getButtonExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Button Example')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Primary Button',
              buttonType: ButtonType.primary,
            ),
            SizedBox(height: 16),
            CustomButton(
              text: 'Secondary Button',
              buttonType: ButtonType.secondary,
            ),
          ],
        ),
      ),
    );
  }
}
''';
  }

  /// Get dropdown example content
  String _getDropdownExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class DropdownExample extends StatelessWidget {
  const DropdownExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dropdown Example')),
      body: const Center(
        child: InlineDropdown(
          items: ['Option 1', 'Option 2', 'Option 3'],
          onChanged: null,
        ),
      ),
    );
  }
}
''';
  }

  /// Get BLE example content
  String _getBLEExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class BLEExample extends StatelessWidget {
  const BLEExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLE Example')),
      body: const FCPBLEComponent(
        config: BLEComponentConfig(
          scanDuration: Duration(seconds: 10),
          usePrefs: true,
        ),
      ),
    );
  }
}
''';
  }

  /// Get PDF viewer example content
  String _getPDFViewerExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class PDFViewerExample extends StatelessWidget {
  const PDFViewerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer Example')),
      body: const FCPPDFViewer(
        assetPath: 'assets/sample.pdf',
      ),
    );
  }
}
''';
  }

  /// Get switch example content
  String _getSwitchExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({super.key});

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Switch Example')),
      body: Center(
        child: FCPSwitch(
          value: _isEnabled,
          onChanged: (value) {
            setState(() {
              _isEnabled = value;
            });
          },
        ),
      ),
    );
  }
}
''';
  }

  /// Get navigation example content
  String _getNavigationExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          Center(child: Text('Home')),
          Center(child: Text('Search')),
          Center(child: Text('Profile')),
        ],
      ),
      bottomNavigationBar: FCPBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
''';
  }
}
