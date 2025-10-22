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
      case 'live_graph':
        await _addLiveGraphComponent();
        break;
      case 'table':
        await _addTableComponent();
        break;
      case 'button':
        await _addButtonComponent();
        break;
      case 'card':
        await _addCardComponent();
        break;
      case 'dropdown':
        await _addDropdownComponent();
        break;
      case 'inline_dropdown':
        await _addInlineDropdownComponent();
        break;
      case 'multi_select':
        await _addMultiSelectComponent();
        break;
      case 'input_field':
        await _addInputFieldComponent();
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
      case 'live_graph':
        await _removeLiveGraphComponent();
        break;
      case 'table':
        await _removeTableComponent();
        break;
      case 'button':
        await _removeButtonComponent();
        break;
      case 'card':
        await _removeCardComponent();
        break;
      case 'dropdown':
        await _removeDropdownComponent();
        break;
      case 'inline_dropdown':
        await _removeInlineDropdownComponent();
        break;
      case 'multi_select':
        await _removeMultiSelectComponent();
        break;
      case 'input_field':
        await _removeInputFieldComponent();
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

  /// Add live graph component
  Future<void> _addLiveGraphComponent() async {
    await _addPubspecDependencies(['fl_chart']);
    await _createExampleFile(
      'live_graph_example.dart',
      _getLiveGraphExampleContent(),
    );
    print('✅ Live graph component added');
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

  /// Add card component
  Future<void> _addCardComponent() async {
    await _createExampleFile('card_example.dart', _getCardExampleContent());
    print('✅ Card component added');
  }

  /// Add dropdown component
  Future<void> _addDropdownComponent() async {
    await _createExampleFile(
      'dropdown_example.dart',
      _getDropdownExampleContent(),
    );
    print('✅ Dropdown component added');
  }

  /// Add inline dropdown component
  Future<void> _addInlineDropdownComponent() async {
    await _createExampleFile(
      'inline_dropdown_example.dart',
      _getInlineDropdownExampleContent(),
    );
    print('✅ Inline dropdown component added');
  }

  /// Add multi-select component
  Future<void> _addMultiSelectComponent() async {
    await _createExampleFile(
      'multi_select_example.dart',
      _getMultiSelectExampleContent(),
    );
    print('✅ Multi-select component added');
  }

  /// Add input field component
  Future<void> _addInputFieldComponent() async {
    await _createExampleFile(
      'input_field_example.dart',
      _getInputFieldExampleContent(),
    );
    print('✅ Input field component added');
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

  /// Remove live graph component
  Future<void> _removeLiveGraphComponent() async {
    await _removePubspecDependencies(['fl_chart']);
    await _removeExampleFile('live_graph_example.dart');
    print('✅ Live graph component removed');
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

  /// Remove card component
  Future<void> _removeCardComponent() async {
    await _removeExampleFile('card_example.dart');
    print('✅ Card component removed');
  }

  /// Remove dropdown component
  Future<void> _removeDropdownComponent() async {
    await _removeExampleFile('dropdown_example.dart');
    print('✅ Dropdown component removed');
  }

  /// Remove inline dropdown component
  Future<void> _removeInlineDropdownComponent() async {
    await _removeExampleFile('inline_dropdown_example.dart');
    print('✅ Inline dropdown component removed');
  }

  /// Remove multi-select component
  Future<void> _removeMultiSelectComponent() async {
    await _removeExampleFile('multi_select_example.dart');
    print('✅ Multi-select component removed');
  }

  /// Remove input field component
  Future<void> _removeInputFieldComponent() async {
    await _removeExampleFile('input_field_example.dart');
    print('✅ Input field component removed');
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
        child: FCPChart.line.withData(
          data: [
            FCPChartData(x: 1, y: 10),
            FCPChartData(x: 2, y: 20),
            FCPChartData(x: 3, y: 15),
            FCPChartData(x: 4, y: 25),
          ],
          title: 'Sample Chart',
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
      body: FCPDataTable(
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Age')),
          DataColumn(label: Text('Email')),
        ],
        rows: [
          DataRow(cells: [
            DataCell(Text('John Doe')),
            DataCell(Text('30')),
            DataCell(Text('john@example.com')),
          ]),
          DataRow(cells: [
            DataCell(Text('Jane Smith')),
            DataCell(Text('25')),
            DataCell(Text('jane@example.com')),
          ]),
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
            FCPButton.medium.primary(text: 'Primary Button'),
            SizedBox(height: 16),
            FCPButton.medium.secondary(text: 'Secondary Button'),
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
      body: Center(
        child: FCPDropdownBottomSheet(
          title: 'Select Option',
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
      body: FCPPdfViewer(
        pdfType: FCPPdfType.assets,
        pdfPath: 'assets/sample.pdf',
        showZoomControls: true,
        showPageNavigationControls: true,
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
        onItemChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        widgets: const [
          Center(child: Text('Home')),
          Center(child: Text('Search')),
          Center(child: Text('Profile')),
        ],
        icons: const [
          Icons.home,
          Icons.search,
          Icons.person,
        ],
        labels: const ['Home', 'Search', 'Profile'],
      ),
    );
  }
}
''';
  }

  /// Get live graph example content
  String _getLiveGraphExampleContent() {
    return '''
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class LiveGraphExample extends StatefulWidget {
  const LiveGraphExample({super.key});

  @override
  State<LiveGraphExample> createState() => _LiveGraphExampleState();
}

class _LiveGraphExampleState extends State<LiveGraphExample> {
  final List<FcpLiveGraphData> _liveData = [];
  final Random _random = Random();
  Timer? _timer;
  double _xValue = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _liveData.add(FcpLiveGraphData(x: _xValue, y: _randomY()));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startLiveUpdates() {
    if (_isRunning) return;
    
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _xValue++;
        _liveData.add(FcpLiveGraphData(x: _xValue, y: _randomY()));

        if (_liveData.length > 50) {
          _liveData.removeAt(0);
        }
      });
    });
  }

  void _stopLiveUpdates() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetData() {
    _timer?.cancel();
    setState(() {
      _liveData.clear();
      _xValue = 0;
      _isRunning = false;
      _liveData.add(FcpLiveGraphData(x: _xValue, y: _randomY()));
    });
  }

  double _randomY() {
    return double.parse((_random.nextDouble() * 2).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Graph Example')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _isRunning ? _stopLiveUpdates : _startLiveUpdates,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRunning ? Colors.red : Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: Text(_isRunning ? 'Stop' : 'Start'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _resetData,
                child: const Text('Reset'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FcpLiveGraph.single(
              data: _liveData,
              color: const Color(0xFFFFBC00),
              name: 'Current',
              config: FcpLiveGraphConfig(
                title: 'Live Current Measurement',
                subtitle: _isRunning 
                    ? 'Real-time current monitoring (\${_liveData.length} points)'
                    : 'Click Start to begin live updates',
                height: 250,
                showLegend: true,
                yAxis: const FcpLiveGraphAxis(
                  title: 'Current',
                  unit: ' A',
                  interval: 0.5,
                  min: 0,
                  max: 2.5,
                ),
                xAxis: FcpLiveGraphAxis(
                  title: 'Time',
                  unit: 's',
                  interval: 5,
                  min: _liveData.isNotEmpty ? _liveData.first.x : 0,
                  max: _liveData.isNotEmpty ? _liveData.last.x + 5 : 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
''';
  }

  /// Get card example content
  String _getCardExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Card Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Basic card
            FCPCard(
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Basic Card'),
              ),
            ),
            const SizedBox(height: 16),
            
            // Flat card
            FCPCard.flat(
              backgroundColor: Colors.green.shade50,
              borderColor: Colors.green.shade300,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Flat Card'),
              ),
            ),
            const SizedBox(height: 16),
            
            // Shaded card
            FCPCard.shaded(
              shadowType: ShadowType.medium,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Shaded Card'),
              ),
            ),
            const SizedBox(height: 16),
            
            // Gradient card
            FCPCard.gradient(
              gradientType: GradientType.sunset,
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Gradient Card',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Info card
            FCPCard.info(
              icon: Icons.info,
              title: 'Information',
              subtitle: 'This is a subtitle',
              content: 'This is the main content of the information card.',
            ),
            const SizedBox(height: 16),
            
            // Action card
            FCPCard.action(
              icon: Icons.settings,
              title: 'Settings',
              content: 'Configure your application settings.',
              actions: [
                TextButton(
                  onPressed: () => print('Cancel pressed'),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => print('Save pressed'),
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
''';
  }

  /// Get inline dropdown example content
  String _getInlineDropdownExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class InlineDropdownExample extends StatefulWidget {
  const InlineDropdownExample({super.key});

  @override
  State<InlineDropdownExample> createState() => _InlineDropdownExampleState();
}

class _InlineDropdownExampleState extends State<InlineDropdownExample> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inline Dropdown Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FCPInlineDropdown(
              title: 'Select Country',
              items: const ['USA', 'Canada', 'UK', 'Germany', 'France'],
              selectedIndex: _selectedIndex,
              onItemSelected: (value) {
                setState(() {
                  _selectedIndex = value as int;
                });
              },
            ),
            const SizedBox(height: 16),
            FCPInlineDropdown(
              title: 'Select City',
              items: const ['New York', 'London', 'Paris', 'Tokyo', 'Sydney'],
              selectedIndex: _selectedIndex,
              isSearchEnabled: true,
              prefixIcon: Icons.location_city,
              enableBorder: true,
              onItemSelected: (value) {
                setState(() {
                  _selectedIndex = value as int;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
''';
  }

  /// Get multi-select example content
  String _getMultiSelectExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class MultiSelectExample extends StatefulWidget {
  const MultiSelectExample({super.key});

  @override
  State<MultiSelectExample> createState() => _MultiSelectExampleState();
}

class _MultiSelectExampleState extends State<MultiSelectExample> {
  List<FCPMultiSelectItem> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multi-Select Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FCPMultiSelectDropdown(
              title: 'Select Categories',
              items: const [
                FCPMultiSelectItem(label: 'Technology', value: 'tech'),
                FCPMultiSelectItem(label: 'Sports', value: 'sports'),
                FCPMultiSelectItem(label: 'Music', value: 'music'),
                FCPMultiSelectItem(label: 'Movies', value: 'movies'),
              ],
              onSelectionChanged: (selectedItems) {
                setState(() {
                  _selectedItems = selectedItems;
                });
              },
            ),
            const SizedBox(height: 16),
            FCPMultiSelectDropdown(
              title: 'Select Skills (Max 3)',
              items: const [
                FCPMultiSelectItem(label: 'Flutter', value: 'flutter'),
                FCPMultiSelectItem(label: 'Dart', value: 'dart'),
                FCPMultiSelectItem(label: 'React Native', value: 'react_native'),
                FCPMultiSelectItem(label: 'Vue.js', value: 'vue'),
                FCPMultiSelectItem(label: 'Angular', value: 'angular'),
              ],
              maxSelections: 3,
              showSelectAll: true,
              isSearchEnabled: true,
              prefixIcon: Icons.code,
              enableBorder: true,
              onSelectionChanged: (selectedItems) {
                setState(() {
                  _selectedItems = selectedItems;
                });
              },
            ),
            const SizedBox(height: 16),
            if (_selectedItems.isNotEmpty)
              Text('Selected: \${_selectedItems.map((item) => item.label).join(', ')}'),
          ],
        ),
      ),
    );
  }
}
''';
  }

  /// Get input field example content
  String _getInputFieldExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class InputFieldExample extends StatefulWidget {
  const InputFieldExample({super.key});

  @override
  State<InputFieldExample> createState() => _InputFieldExampleState();
}

class _InputFieldExampleState extends State<InputFieldExample> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    _passwordController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Input Field Example')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FCPInputField(
              controller: _textController,
              label: 'Email',
              hintText: 'Enter your email',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            FCPInputField(
              controller: _passwordController,
              label: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icons.lock,
              obscureText: true,
              suffixIcon: Icons.visibility,
            ),
            const SizedBox(height: 16),
            FCPInputField(
              controller: _searchController,
              label: 'Search',
              hintText: 'Search for something...',
              prefixIcon: Icons.search,
              suffixIcon: Icons.clear,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print('Email: \${_textController.text}');
                print('Password: \${_passwordController.text}');
                print('Search: \${_searchController.text}');
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
''';
  }
}
