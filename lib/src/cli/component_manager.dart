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
      case 'quadrant_chart':
        await _addQuadrantChartComponent();
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
      case 'themes':
        await _addThemesComponent();
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
      case 'quadrant_chart':
        await _removeQuadrantChartComponent();
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
      case 'themes':
        await _removeThemesComponent();
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

  /// Add quadrant chart component
  Future<void> _addQuadrantChartComponent() async {
    await _createExampleFile(
      'quadrant_chart_example.dart',
      _getQuadrantChartExampleContent(),
    );
    print('✅ Quadrant chart component added');
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

  /// Add themes component
  Future<void> _addThemesComponent() async {
    await _createThemesStructure();
    print('✅ Themes component added');
  }

  /// Remove chart component
  Future<void> _removeChartComponent() async {
    await _removePubspecDependencies(['fl_chart']);
    await _removeExampleFile('chart_example.dart');
    print('✅ Chart component removed');
  }

  /// Remove quadrant chart component
  Future<void> _removeQuadrantChartComponent() async {
    await _removeExampleFile('quadrant_chart_example.dart');
    print('✅ Quadrant chart component removed');
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

  /// Remove themes component
  Future<void> _removeThemesComponent() async {
    await _removeThemesStructure();
    print('✅ Themes component removed');
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

  /// Get quadrant chart example content
  String _getQuadrantChartExampleContent() {
    return '''
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class QuadrantChartExample extends StatelessWidget {
  const QuadrantChartExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quadrant Chart Example')),
      body: Center(
        child: FCPQuadrantChart(
          xValue: 72,
          yValue: 58,
          xThreshold: 50,
          yThreshold: 50,
          title: 'Risk vs Impact',
          subtitle: 'Primary marker in top-right region',
          showRegionLabels: true,
          topLeftRegionLabel: 'Low Impact / High Risk',
          topRightRegionLabel: 'High Impact / High Risk',
          bottomLeftRegionLabel: 'Low Impact / Low Risk',
          bottomRightRegionLabel: 'High Impact / Low Risk',
          titlesData: FCPTitlesData(
            show: true,
            bottomTitles: FCPAxisTitles(
              sideTitles: FCPSideTitles(showTitles: true, interval: 25),
            ),
            leftTitles: FCPAxisTitles(
              sideTitles: FCPSideTitles(showTitles: true, interval: 25),
            ),
          ),
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

  /// Create themes structure
  Future<void> _createThemesStructure() async {
    // Create themes directory
    final themesDir = Directory('lib/themes');
    if (!await themesDir.exists()) {
      await themesDir.create(recursive: true);
    }

    // Create custom_themes directory
    final customThemesDir = Directory('lib/themes/custom_themes');
    if (!await customThemesDir.exists()) {
      await customThemesDir.create(recursive: true);
    }

    // Create main app_theme.dart
    await _createAppThemeFile();

    // Create individual theme files
    await _createTextThemeFile();
    await _createAppBarThemeFile();
    await _createElevatedButtonThemeFile();
    await _createTextButtonThemeFile();
    await _createOutlinedButtonThemeFile();
    await _createTextFormFieldThemeFile();
    await _createCheckboxThemeFile();
    await _createBottomSheetThemeFile();
    await _createChipThemeFile();
    await _createThemesImportsFile();
  }

  /// Remove themes structure
  Future<void> _removeThemesStructure() async {
    final themesDir = Directory('lib/themes');
    if (await themesDir.exists()) {
      await themesDir.delete(recursive: true);
    }
  }

  /// Create app_theme.dart file
  Future<void> _createAppThemeFile() async {
    final content = '''
import 'package:flutter/material.dart';

import 'custom_themes/text_btn_theme.dart';
import 'custom_themes/elevated_btn_theme.dart';
import 'custom_themes/outlined_btn_theme.dart';
import 'custom_themes/appbar_theme.dart';
import 'custom_themes/text_theme.dart';
import 'custom_themes/text_field_theme.dart';
import 'custom_themes/checkbox_theme.dart';
import 'custom_themes/bottom_sheet_theme.dart';
import 'custom_themes/chip_theme.dart';
import 'custom_themes/themes_imports.dart';

class AppTheme {
  AppTheme._();

  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF1976D2);
  static const Color lightPrimaryVariant = Color(0xFF1565C0);
  static const Color lightSecondary = Color(0xFF03DAC6);
  static const Color lightSecondaryVariant = Color(0xFF018786);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightError = Color(0xFFB00020);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFF000000);
  static const Color lightOnSurface = Color(0xFF1C1B1F);
  static const Color lightOnBackground = Color(0xFF1C1B1F);
  static const Color lightOnError = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF90CAF9);
  static const Color darkPrimaryVariant = Color(0xFF1976D2);
  static const Color darkSecondary = Color(0xFF03DAC6);
  static const Color darkSecondaryVariant = Color(0xFF03DAC6);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkBackground = Color(0xFF000000);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkOnPrimary = Color(0xFF000000);
  static const Color darkOnSecondary = Color(0xFF000000);
  static const Color darkOnSurface = Color(0xFFE1E1E1);
  static const Color darkOnBackground = Color(0xFFE1E1E1);
  static const Color darkOnError = Color(0xFF000000);

  // Customizable Light Theme
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      onPrimary: lightOnPrimary,
      secondary: lightSecondary,
      onSecondary: lightOnSecondary,
      surface: lightSurface,
      onSurface: lightOnSurface,
      background: lightBackground,
      onBackground: lightOnBackground,
      error: lightError,
      onError: lightOnError,
    ),
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppElevatedBtnTheme.lightElevatedButtonTheme,
    textButtonTheme: AppTextBtnTheme.lightTextButtonTheme,
    outlinedButtonTheme: AppOutlinedBtnTheme.lightOutlineButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.lightInputDecorationTheme,
    checkboxTheme: AppCheckBoxTheme.lightCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
    chipTheme: AppChipTheme.lightChipTheme,
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: lightSurface,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E0E0),
      thickness: 1,
      space: 1,
    ),
    iconTheme: const IconThemeData(
      color: lightOnSurface,
      size: 24,
    ),
    primaryIconTheme: const IconThemeData(
      color: lightOnPrimary,
      size: 24,
    ),
    secondaryIconTheme: const IconThemeData(
      color: lightOnSecondary,
      size: 24,
    ),
  );

  // Customizable Dark Theme
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      onPrimary: darkOnPrimary,
      secondary: darkSecondary,
      onSecondary: darkOnSecondary,
      surface: darkSurface,
      onSurface: darkOnSurface,
      background: darkBackground,
      onBackground: darkOnBackground,
      error: darkError,
      onError: darkOnError,
    ),
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: AppElevatedBtnTheme.darkElevatedButtonTheme,
    textButtonTheme: AppTextBtnTheme.darkTextButtonTheme,
    outlinedButtonTheme: AppOutlinedBtnTheme.darkOutlineButtonTheme,
    inputDecorationTheme: AppTextFormFieldTheme.darkInputDecorationTheme,
    checkboxTheme: AppCheckBoxTheme.darkCheckboxTheme,
    bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
    chipTheme: AppChipTheme.darkChipTheme,
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: darkSurface,
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF424242),
      thickness: 1,
      space: 1,
    ),
    iconTheme: const IconThemeData(
      color: darkOnSurface,
      size: 24,
    ),
    primaryIconTheme: const IconThemeData(
      color: darkOnPrimary,
      size: 24,
    ),
    secondaryIconTheme: const IconThemeData(
      color: darkOnSecondary,
      size: 24,
    ),
  );
}
''';

    final file = File('lib/themes/app_theme.dart');
    await file.writeAsString(content);
  }

  /// Create text_theme.dart file
  Future<void> _createTextThemeFile() async {
    final content = '''
import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  // Light Text Theme
  static const lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: Color(0xFF1C1B1F),
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFF1C1B1F),
      height: 1.16,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFF1C1B1F),
      height: 1.22,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFF1C1B1F),
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFF1C1B1F),
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFF1C1B1F),
      height: 1.33,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFF1C1B1F),
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Color(0xFF1C1B1F),
      height: 1.50,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Color(0xFF1C1B1F),
      height: 1.43,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xFF1C1B1F),
      height: 1.50,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Color(0xFF1C1B1F),
      height: 1.43,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: Color(0xFF1C1B1F),
      height: 1.33,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Color(0xFF1C1B1F),
      height: 1.43,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: Color(0xFF1C1B1F),
      height: 1.33,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: Color(0xFF1C1B1F),
      height: 1.45,
    ),
  );

  // Dark Text Theme
  static const darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
      color: Color(0xFFE1E1E1),
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFFE1E1E1),
      height: 1.16,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFFE1E1E1),
      height: 1.22,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFFE1E1E1),
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFFE1E1E1),
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFFE1E1E1),
      height: 1.33,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      color: Color(0xFFE1E1E1),
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Color(0xFFE1E1E1),
      height: 1.50,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Color(0xFFE1E1E1),
      height: 1.43,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xFFE1E1E1),
      height: 1.50,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      color: Color(0xFFE1E1E1),
      height: 1.43,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      color: Color(0xFFE1E1E1),
      height: 1.33,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: Color(0xFFE1E1E1),
      height: 1.43,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: Color(0xFFE1E1E1),
      height: 1.33,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      color: Color(0xFFE1E1E1),
      height: 1.45,
    ),
  );
}
''';

    final file = File('lib/themes/custom_themes/text_theme.dart');
    await file.writeAsString(content);
  }

  /// Create appbar_theme.dart file
  Future<void> _createAppBarThemeFile() async {
    final content = '''
import 'package:flutter/material.dart';

class CustomAppBarTheme {
  CustomAppBarTheme._();

  // Light AppBar Theme
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Color(0xFFFFFFFF),
    surfaceTintColor: Color(0xFFFFFFFF),
    foregroundColor: Color(0xFF1C1B1F),
    iconTheme: IconThemeData(
      color: Color(0xFF1C1B1F),
      size: 24,
      opacity: 1.0,
    ),
    actionsIconTheme: IconThemeData(
      color: Color(0xFF1C1B1F),
      size: 24,
      opacity: 1.0,
    ),
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: Color(0xFF1C1B1F),
      letterSpacing: 0,
      height: 1.27,
    ),
    toolbarTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFF1C1B1F),
      letterSpacing: 0.15,
      height: 1.50,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    shadowColor: Color(0xFF000000),
    surfaceTintColor: Color(0xFFFFFFFF),
  );

  // Dark AppBar Theme
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Color(0xFF121212),
    surfaceTintColor: Color(0xFF121212),
    foregroundColor: Color(0xFFE1E1E1),
    iconTheme: IconThemeData(
      color: Color(0xFFE1E1E1),
      size: 24,
      opacity: 1.0,
    ),
    actionsIconTheme: IconThemeData(
      color: Color(0xFFE1E1E1),
      size: 24,
      opacity: 1.0,
    ),
    titleTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: Color(0xFFE1E1E1),
      letterSpacing: 0,
      height: 1.27,
    ),
    toolbarTextStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFFE1E1E1),
      letterSpacing: 0.15,
      height: 1.50,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.light,
    shadowColor: Color(0xFF000000),
    surfaceTintColor: Color(0xFF121212),
  );
}
''';

    final file = File('lib/themes/custom_themes/appbar_theme.dart');
    await file.writeAsString(content);
  }

  /// Create elevated_btn_theme.dart file
  Future<void> _createElevatedButtonThemeFile() async {
    final content = '''
import 'package:flutter/material.dart';

class AppElevatedBtnTheme {
  AppElevatedBtnTheme._();

  // Light Elevated Button Theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 1,
      shadowColor: Color(0xFF000000),
      backgroundColor: Color(0xFF1976D2),
      foregroundColor: Color(0xFFFFFFFF),
      disabledBackgroundColor: Color(0xFFE0E0E0),
      disabledForegroundColor: Color(0xFF9E9E9E),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      minimumSize: Size(64, 40),
      maximumSize: Size.infinite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      animationDuration: Duration(milliseconds: 200),
      enableFeedback: true,
      alignment: Alignment.center,
      visualDensity: VisualDensity.standard,
    ),
  );

  // Dark Elevated Button Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 1,
      shadowColor: Color(0xFF000000),
      backgroundColor: Color(0xFF90CAF9),
      foregroundColor: Color(0xFF000000),
      disabledBackgroundColor: Color(0xFF424242),
      disabledForegroundColor: Color(0xFF757575),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      minimumSize: Size(64, 40),
      maximumSize: Size.infinite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      animationDuration: Duration(milliseconds: 200),
      enableFeedback: true,
      alignment: Alignment.center,
      visualDensity: VisualDensity.standard,
    ),
  );
}
''';

    final file = File('lib/themes/custom_themes/elevated_btn_theme.dart');
    await file.writeAsString(content);
  }

  /// Create text_btn_theme.dart file
  Future<void> _createTextButtonThemeFile() async {
    final content = '''
import 'package:flutter/material.dart';

class AppTextBtnTheme {
  AppTextBtnTheme._();

  // Light Text Button Theme
  static final lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF1976D2),
      disabledForegroundColor: Color(0xFF9E9E9E),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      minimumSize: Size(48, 40),
      maximumSize: Size.infinite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      animationDuration: Duration(milliseconds: 200),
      enableFeedback: true,
      alignment: Alignment.center,
      visualDensity: VisualDensity.standard,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Color(0xFF1976D2).withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return Color(0xFF1976D2).withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return Color(0xFF1976D2).withOpacity(0.12);
          }
          return null;
        },
      ),
    ),
  );

  // Dark Text Button Theme
  static final darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF90CAF9),
      disabledForegroundColor: Color(0xFF757575),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      minimumSize: Size(48, 40),
      maximumSize: Size.infinite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      animationDuration: Duration(milliseconds: 200),
      enableFeedback: true,
      alignment: Alignment.center,
      visualDensity: VisualDensity.standard,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Color(0xFF90CAF9).withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return Color(0xFF90CAF9).withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return Color(0xFF90CAF9).withOpacity(0.12);
          }
          return null;
        },
      ),
    ),
  );
}
''';

    final file = File('lib/themes/custom_themes/text_btn_theme.dart');
    await file.writeAsString(content);
  }

  /// Create outlined_btn_theme.dart file
  Future<void> _createOutlinedButtonThemeFile() async {
    final content = '''
import 'package:flutter/material.dart';

class AppOutlinedBtnTheme {
  AppOutlinedBtnTheme._();

  // Light Outlined Button Theme
  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFF1976D2),
      disabledForegroundColor: Color(0xFF9E9E9E),
      side: BorderSide(color: Color(0xFF1976D2), width: 1),
      disabledSide: BorderSide(color: Color(0xFFE0E0E0), width: 1),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      minimumSize: Size(64, 40),
      maximumSize: Size.infinite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      animationDuration: Duration(milliseconds: 200),
      enableFeedback: true,
      alignment: Alignment.center,
      visualDensity: VisualDensity.standard,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Color(0xFF1976D2).withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return Color(0xFF1976D2).withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return Color(0xFF1976D2).withOpacity(0.12);
          }
          return null;
        },
      ),
    ),
  );

  // Dark Outlined Button Theme
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color(0xFF90CAF9),
      disabledForegroundColor: Color(0xFF757575),
      side: BorderSide(color: Color(0xFF90CAF9), width: 1),
      disabledSide: BorderSide(color: Color(0xFF424242), width: 1),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      minimumSize: Size(64, 40),
      maximumSize: Size.infinite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      animationDuration: Duration(milliseconds: 200),
      enableFeedback: true,
      alignment: Alignment.center,
      visualDensity: VisualDensity.standard,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Color(0xFF90CAF9).withOpacity(0.12);
          }
          if (states.contains(MaterialState.hovered)) {
            return Color(0xFF90CAF9).withOpacity(0.08);
          }
          if (states.contains(MaterialState.focused)) {
            return Color(0xFF90CAF9).withOpacity(0.12);
          }
          return null;
        },
      ),
    ),
  );
}
''';

    final file = File('lib/themes/custom_themes/outlined_btn_theme.dart');
    await file.writeAsString(content);
  }

  /// Create text_field_theme.dart file
  Future<void> _createTextFormFieldThemeFile() async {
    final content = '''
import 'package:flutter/material.dart';

class AppTextFormFieldTheme {
  AppTextFormFieldTheme._();

  // Light Input Decoration Theme
  static final lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFF5F5F5),
    hintStyle: TextStyle(
      color: Color(0xFF9E9E9E),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.50,
    ),
    labelStyle: TextStyle(
      color: Color(0xFF1976D2),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.50,
    ),
    floatingLabelStyle: TextStyle(
      color: Color(0xFF1976D2),
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ),
    errorStyle: TextStyle(
      color: Color(0xFFB00020),
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF1976D2), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFB00020), width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFB00020), width: 2),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFE0E0E0), width: 1),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    isDense: false,
    isCollapsed: false,
    counterStyle: TextStyle(
      color: Color(0xFF9E9E9E),
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ),
    prefixIconColor: Color(0xFF1976D2),
    suffixIconColor: Color(0xFF1976D2),
    iconColor: Color(0xFF1976D2),
  );

  // Dark Input Decoration Theme
  static final darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF2C2C2C),
    hintStyle: TextStyle(
      color: Color(0xFF757575),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.50,
    ),
    labelStyle: TextStyle(
      color: Color(0xFF90CAF9),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.50,
    ),
    floatingLabelStyle: TextStyle(
      color: Color(0xFF90CAF9),
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ),
    errorStyle: TextStyle(
      color: Color(0xFFCF6679),
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF424242), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF424242), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF90CAF9), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFCF6679), width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFFCF6679), width: 2),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Color(0xFF424242), width: 1),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    isDense: false,
    isCollapsed: false,
    counterStyle: TextStyle(
      color: Color(0xFF757575),
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.33,
    ),
    prefixIconColor: Color(0xFF90CAF9),
    suffixIconColor: Color(0xFF90CAF9),
    iconColor: Color(0xFF90CAF9),
  );
}
''';

    final file = File('lib/themes/custom_themes/text_field_theme.dart');
    await file.writeAsString(content);
  }

  /// Create checkbox_theme.dart file
  Future<void> _createCheckboxThemeFile() async {
    final content = '''
import 'package:flutter/material.dart';

class AppCheckBoxTheme {
  AppCheckBoxTheme._();

  // Light Checkbox Theme
  static final lightCheckboxTheme = CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Color(0xFFE0E0E0);
        }
        if (states.contains(MaterialState.selected)) {
          return Color(0xFF1976D2);
        }
        return Color(0xFFFFFFFF);
      },
    ),
    checkColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Color(0xFF9E9E9E);
        }
        return Color(0xFFFFFFFF);
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Color(0xFF1976D2).withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return Color(0xFF1976D2).withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return Color(0xFF1976D2).withOpacity(0.12);
        }
        return null;
      },
    ),
    side: BorderSide(
      color: Color(0xFF1976D2),
      width: 2,
      style: BorderStyle.solid,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    splashRadius: 20,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.standard,
  );

  // Dark Checkbox Theme
  static final darkCheckboxTheme = CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Color(0xFF424242);
        }
        if (states.contains(MaterialState.selected)) {
          return Color(0xFF90CAF9);
        }
        return Color(0xFF121212);
      },
    ),
    checkColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Color(0xFF757575);
        }
        return Color(0xFF000000);
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) {
          return Color(0xFF90CAF9).withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return Color(0xFF90CAF9).withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return Color(0xFF90CAF9).withOpacity(0.12);
        }
        return null;
      },
    ),
    side: BorderSide(
      color: Color(0xFF90CAF9),
      width: 2,
      style: BorderStyle.solid,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
    splashRadius: 20,
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.standard,
  );
}
''';

    final file = File('lib/themes/custom_themes/checkbox_theme.dart');
    await file.writeAsString(content);
  }

  /// Create bottom_sheet_theme.dart file
  Future<void> _createBottomSheetThemeFile() async {
    final content = '''
import 'package:flutter/material.dart';

class AppBottomSheetTheme {
  AppBottomSheetTheme._();

  // Light Bottom Sheet Theme
  static final lightBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: Color(0xFFFFFFFF),
    surfaceTintColor: Color(0xFFFFFFFF),
    elevation: 8,
    shadowColor: Color(0xFF000000),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      side: BorderSide.none,
    ),
    clipBehavior: Clip.antiAlias,
    constraints: BoxConstraints(
      maxHeight: double.infinity,
      minHeight: 0,
    ),
    showDragHandle: true,
    dragHandleColor: Color(0xFFE0E0E0),
    dragHandleSize: Size(32, 4),
  );

  // Dark Bottom Sheet Theme
  static final darkBottomSheetTheme = BottomSheetThemeData(
    backgroundColor: Color(0xFF121212),
    surfaceTintColor: Color(0xFF121212),
    elevation: 8,
    shadowColor: Color(0xFF000000),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      side: BorderSide.none,
    ),
    clipBehavior: Clip.antiAlias,
    constraints: BoxConstraints(
      maxHeight: double.infinity,
      minHeight: 0,
    ),
    showDragHandle: true,
    dragHandleColor: Color(0xFF424242),
    dragHandleSize: Size(32, 4),
  );
}
''';

    final file = File('lib/themes/custom_themes/bottom_sheet_theme.dart');
    await file.writeAsString(content);
  }

  /// Create chip_theme.dart file
  Future<void> _createChipThemeFile() async {
    final content = '''
import 'package:flutter/material.dart';

class AppChipTheme {
  AppChipTheme._();

  // Light Chip Theme
  static final lightChipTheme = ChipThemeData(
    backgroundColor: Color(0xFFE0E0E0),
    deleteIconColor: Color(0xFF1976D2),
    disabledColor: Color(0xFFF5F5F5),
    selectedColor: Color(0xFF1976D2),
    secondarySelectedColor: Color(0xFFE3F2FD),
    shadowColor: Color(0xFF000000),
    surfaceTintColor: Color(0xFF1976D2),
    labelStyle: TextStyle(
      color: Color(0xFF1C1B1F),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    secondaryLabelStyle: TextStyle(
      color: Color(0xFF1976D2),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    brightness: Brightness.light,
    elevation: 0,
    pressElevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide.none,
    ),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.standard,
    side: BorderSide.none,
  );

  // Dark Chip Theme
  static final darkChipTheme = ChipThemeData(
    backgroundColor: Color(0xFF424242),
    deleteIconColor: Color(0xFF90CAF9),
    disabledColor: Color(0xFF2C2C2C),
    selectedColor: Color(0xFF90CAF9),
    secondarySelectedColor: Color(0xFF1A237E),
    shadowColor: Color(0xFF000000),
    surfaceTintColor: Color(0xFF90CAF9),
    labelStyle: TextStyle(
      color: Color(0xFFE1E1E1),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    secondaryLabelStyle: TextStyle(
      color: Color(0xFF90CAF9),
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.43,
    ),
    brightness: Brightness.dark,
    elevation: 0,
    pressElevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide.none,
    ),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    visualDensity: VisualDensity.standard,
    side: BorderSide.none,
  );
}
''';

    final file = File('lib/themes/custom_themes/chip_theme.dart');
    await file.writeAsString(content);
  }

  /// Create themes_imports.dart file
  Future<void> _createThemesImportsFile() async {
    final content = '''
// Themes Imports
// This file contains all theme imports for easy management

export 'text_theme.dart';
export 'appbar_theme.dart';
export 'elevated_btn_theme.dart';
export 'text_btn_theme.dart';
export 'outlined_btn_theme.dart';
export 'text_field_theme.dart';
export 'checkbox_theme.dart';
export 'bottom_sheet_theme.dart';
export 'chip_theme.dart';
''';

    final file = File('lib/themes/custom_themes/themes_imports.dart');
    await file.writeAsString(content);
  }
}
