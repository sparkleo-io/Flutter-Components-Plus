import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Comprehensive examples for FCPChart component
class FCPChartExamples extends StatelessWidget {
  const FCPChartExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Area Charts'),
            const SizedBox(height: 16),
            _buildAreaChartExample(),
            const SizedBox(height: 32),

            _buildSectionTitle('Bar Charts'),
            const SizedBox(height: 16),
            _buildBarChartExample(),
            const SizedBox(height: 32),

            _buildSectionTitle('Line Charts'),
            const SizedBox(height: 16),
            _buildLineChartExample(),
            const SizedBox(height: 32),

            _buildSectionTitle('Histogram Charts'),
            const SizedBox(height: 16),
            _buildHistogramChartExample(),
            const SizedBox(height: 32),

            _buildSectionTitle('Custom Styled Charts'),
            const SizedBox(height: 16),
            _buildCustomStyledCharts(),
            const SizedBox(height: 32),

            _buildSectionTitle('Multiple Data Series'),
            const SizedBox(height: 16),
            _buildMultipleDataSeriesExample(),
            const SizedBox(height: 32),

            _buildSectionTitle('Current Measurement Chart'),
            const SizedBox(height: 16),
            _buildCurrentMeasurementExample(),
            const SizedBox(height: 32),

            // _buildSectionTitle('Live Current Chart'),
            // const SizedBox(height: 16),
            // _buildLiveCurrentChart(),
            // const SizedBox(height: 32),
            _buildSectionTitle('Live Graphs'),
            const SizedBox(height: 16),
            _buildLiveGraphExamples(),
            const SizedBox(height: 32),

            _buildSectionTitle('Charts with Legends'),
            const SizedBox(height: 16),
            _buildChartsWithLegends(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: FCPColorScheme.primary,
      ),
    );
  }

  Widget _buildAreaChartExample() {
    final data = [
      const FCPChartData(x: 0, y: 10),
      const FCPChartData(x: 1, y: 25),
      const FCPChartData(x: 2, y: 15),
      const FCPChartData(x: 3, y: 40),
      const FCPChartData(x: 4, y: 30),
      const FCPChartData(x: 5, y: 50),
      const FCPChartData(x: 6, y: 35),
    ];

    return FCPChart.area.withData(
      data: data,
      title: 'Sales Performance',
      subtitle: 'Monthly sales data for 2024',
      height: 250,
      customConfig: FCPAreaChartConfig(
        showDots: true,
        areaOpacity: 0.3,
        isCurved: true,
      ),
      padding: const EdgeInsets.all(16),
    );
  }

  Widget _buildBarChartExample() {
    final data = [
      const FCPChartData(x: 0, y: 20, label: 'Jan'),
      const FCPChartData(x: 1, y: 35, label: 'Feb'),
      const FCPChartData(x: 2, y: 15, label: 'Mar'),
      const FCPChartData(x: 3, y: 45, label: 'Apr'),
      const FCPChartData(x: 4, y: 30, label: 'May'),
      const FCPChartData(x: 5, y: 55, label: 'Jun'),
    ];

    return FCPChart.bar.withData(
      data: data,
      title: 'Monthly Revenue',
      subtitle: 'Revenue in thousands',
      height: 250,
      customConfig: FCPBarChartConfig(barWidth: 25, barBorderRadius: 6),
    );
  }

  Widget _buildLineChartExample() {
    final data = [
      const FCPChartData(x: 0, y: 100),
      const FCPChartData(x: 1, y: 120),
      const FCPChartData(x: 2, y: 110),
      const FCPChartData(x: 3, y: 140),
      const FCPChartData(x: 4, y: 130),
      const FCPChartData(x: 5, y: 160),
      const FCPChartData(x: 6, y: 150),
    ];

    return FCPChart.line.withData(
      data: data,
      title: 'Stock Price Trend',
      subtitle: 'Price movement over time',
      height: 250,
      customConfig: FCPLineChartConfig(
        showDots: true,
        isCurved: false,
        lineWidth: 3,
      ),
    );
  }

  Widget _buildHistogramChartExample() {
    final data = [
      const FCPChartData(x: 0, y: 5, label: '0-10'),
      const FCPChartData(x: 1, y: 12, label: '10-20'),
      const FCPChartData(x: 2, y: 8, label: '20-30'),
      const FCPChartData(x: 3, y: 15, label: '30-40'),
      const FCPChartData(x: 4, y: 10, label: '40-50'),
      const FCPChartData(x: 5, y: 7, label: '50-60'),
    ];

    return FCPChart.histogram.withData(
      data: data,
      title: 'Age Distribution',
      subtitle: 'Number of people in each age group',
      height: 250,
      customConfig: FCPHistogramChartConfig(barWidth: 35),
    );
  }

  Widget _buildCustomStyledCharts() {
    return Column(
      children: [
        // Minimal style
        FCPChart.area.withData(
          data: _generateSampleData(),
          title: 'Minimal Style',
          height: 200,
          customConfig: FCPChartThemes.minimalArea,
        ),
        const SizedBox(height: 16),

        // Bold style
        FCPChart.bar.withData(
          data: _generateSampleBarData(),
          title: 'Bold Style',
          height: 200,
          customConfig: FCPChartThemes.boldBar,
        ),
        const SizedBox(height: 16),

        // Advanced customization example
        FCPChart.line.withData(
          data: _generateSampleData(),
          title: 'Advanced Customization',
          subtitle: 'Custom grid, colors, and interactions',
          height: 200,
          customConfig: FCPLineChartConfig(
            lineColor: Colors.purple,
            lineWidth: 4,
            showDots: true,
            dotColor: Colors.orange,
            dotRadius: 6,
          ),
          customGridData: FCPGridData(
            show: true,
            drawVerticalLine: true,
            drawHorizontalLine: true,
            getDrawingHorizontalLine: (value) => FCPLine(
              color: Colors.grey.withValues(alpha: 0.3),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
            getDrawingVerticalLine: (value) => FCPLine(
              color: Colors.grey.withValues(alpha: 0.3),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
          ),
          customTitlesData: FCPTitlesData(
            show: true,
            bottomTitles: FCPAxisTitles(
              sideTitles: FCPSideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  return Text(
                    'Day ${value.toInt()}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            leftTitles: FCPAxisTitles(
              sideTitles: FCPSideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}k',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleDataSeriesExample() {
    // Create multiple data series
    final salesData = [
      const FCPChartData(x: 0, y: 20, color: Colors.blue),
      const FCPChartData(x: 1, y: 35, color: Colors.blue),
      const FCPChartData(x: 2, y: 25, color: Colors.blue),
      const FCPChartData(x: 3, y: 45, color: Colors.blue),
      const FCPChartData(x: 4, y: 40, color: Colors.blue),
    ];

    final targetData = [
      const FCPChartData(x: 0, y: 30, color: Colors.red),
      const FCPChartData(x: 1, y: 30, color: Colors.red),
      const FCPChartData(x: 2, y: 30, color: Colors.red),
      const FCPChartData(x: 3, y: 30, color: Colors.red),
      const FCPChartData(x: 4, y: 30, color: Colors.red),
    ];

    final forecastData = [
      const FCPChartData(x: 0, y: 15, color: Colors.green),
      const FCPChartData(x: 1, y: 25, color: Colors.green),
      const FCPChartData(x: 2, y: 35, color: Colors.green),
      const FCPChartData(x: 3, y: 50, color: Colors.green),
      const FCPChartData(x: 4, y: 60, color: Colors.green),
    ];

    return FCPChart.line.withData(
      data: salesData, // Primary data series
      title: 'Multiple Data Series',
      subtitle: 'Sales, Target, and Forecast comparison',
      height: 250,
      multipleDataSeries: [salesData, targetData, forecastData],
      customConfig: FCPLineChartConfig(
        showDots: true,
        lineWidth: 3,
        isCurved: true,
      ),
    );
  }

  Widget _buildCurrentMeasurementExample() {
    return FCPChartQuickExamples.currentMeasurementChart();
  }

  Widget _buildLiveGraphExamples() {
    return Column(
      children: [
        // Live updating graph example
        const LiveGraphExample(),
        const SizedBox(height: 16),

        // Multi-series live graph
        const MultiSeriesLiveGraphExample(),
        const SizedBox(height: 16),

        // Professional styled live graph
        const ProfessionalLiveGraphExample(),
      ],
    );
  }

  Widget _buildChartsWithLegends() {
    final legend = FCPChartLegend(
      items: [
        const FCPLegendItem(label: 'Sales', color: FCPColorScheme.primary),
        const FCPLegendItem(label: 'Target', color: FCPColorScheme.secondary),
        const FCPLegendItem(label: 'Forecast', color: FCPColorScheme.success),
      ],
    );

    return FCPChart.line.withData(
      data: _generateSampleData(),
      title: 'Sales vs Target vs Forecast',
      subtitle: 'With custom legend',
      height: 250,
      legend: legend,
      customConfig: FCPLineChartConfig(showDots: true, lineWidth: 3),
    );
  }

  List<FCPChartData> _generateSampleData() {
    return [
      const FCPChartData(x: 0, y: 20),
      const FCPChartData(x: 1, y: 35),
      const FCPChartData(x: 2, y: 25),
      const FCPChartData(x: 3, y: 45),
      const FCPChartData(x: 4, y: 40),
      const FCPChartData(x: 5, y: 55),
      const FCPChartData(x: 6, y: 50),
    ];
  }

  List<FCPChartData> _generateSampleBarData() {
    return [
      const FCPChartData(x: 0, y: 15, label: 'Q1'),
      const FCPChartData(x: 1, y: 25, label: 'Q2'),
      const FCPChartData(x: 2, y: 20, label: 'Q3'),
      const FCPChartData(x: 3, y: 35, label: 'Q4'),
    ];
  }
}

/// Live updating graph example with real-time data
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

  // Configuration for data management
  static const bool _persistentData = false;
  static const int _maxDataPoints = 50;
  static const int _maxVisibleDataPoints = 30;

  @override
  void initState() {
    super.initState();
    // Add initial value
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

        // Data management based on configuration
        if (!_persistentData && _liveData.length > _maxDataPoints) {
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
      // Add initial value
      _liveData.add(FcpLiveGraphData(x: _xValue, y: _randomY()));
    });
  }

  double _randomY() {
    return double.parse(
      (_random.nextDouble() * 2).toStringAsFixed(2),
    ); // Range 0.0 → 2.0
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Control buttons
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
            ElevatedButton(onPressed: _resetData, child: const Text('Reset')),
          ],
        ),
        const SizedBox(height: 16),

        // Live graph
        FcpLiveGraph.single(
          data: _liveData,
          color: const Color(0xFFFFBC00),
          name: 'Current',
          config: FcpLiveGraphConfig(
            title: 'Live Current Measurement',
            subtitle: _isRunning
                ? 'Real-time current monitoring (${_liveData.length} points)'
                : 'Click Start to begin live updates',
            height: 250,
            showLegend: true,
            persistentData: _persistentData,
            maxDataPoints: _maxDataPoints,
            maxVisibleDataPoints: _maxVisibleDataPoints,
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
      ],
    );
  }
}

/// Multi-series live graph example
class MultiSeriesLiveGraphExample extends StatefulWidget {
  const MultiSeriesLiveGraphExample({super.key});

  @override
  State<MultiSeriesLiveGraphExample> createState() =>
      _MultiSeriesLiveGraphExampleState();
}

class _MultiSeriesLiveGraphExampleState
    extends State<MultiSeriesLiveGraphExample> {
  final List<FcpLiveGraphData> _currentData = [];
  final List<FcpLiveGraphData> _voltageData = [];
  final Random _random = Random();
  Timer? _timer;
  double _xValue = 0;
  bool _isRunning = false;

  // Configuration for data management
  static const bool _persistentData = true; // Keep all data for multi-series
  static const int _maxDataPoints = 30;
  static const int _maxVisibleDataPoints = 20;

  @override
  void initState() {
    super.initState();
    // Add initial values
    _currentData.add(FcpLiveGraphData(x: _xValue, y: _randomCurrent()));
    _voltageData.add(FcpLiveGraphData(x: _xValue, y: _randomVoltage()));
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
        _currentData.add(FcpLiveGraphData(x: _xValue, y: _randomCurrent()));
        _voltageData.add(FcpLiveGraphData(x: _xValue, y: _randomVoltage()));

        // Data management based on configuration
        if (!_persistentData && _currentData.length > _maxDataPoints) {
          _currentData.removeAt(0);
          _voltageData.removeAt(0);
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
      _currentData.clear();
      _voltageData.clear();
      _xValue = 0;
      _isRunning = false;
      // Add initial values
      _currentData.add(FcpLiveGraphData(x: _xValue, y: _randomCurrent()));
      _voltageData.add(FcpLiveGraphData(x: _xValue, y: _randomVoltage()));
    });
  }

  double _randomCurrent() {
    return double.parse(
      (_random.nextDouble() * 2).toStringAsFixed(2),
    ); // Range 0.0 → 2.0
  }

  double _randomVoltage() {
    return double.parse(
      (_random.nextDouble() * 4 + 1).toStringAsFixed(2),
    ); // Range 1.0 → 5.0
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Control buttons
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
            ElevatedButton(onPressed: _resetData, child: const Text('Reset')),
          ],
        ),
        const SizedBox(height: 16),

        // Multi-series live graph
        FcpLiveGraph.multi(
          series: [
            FcpLiveGraphSeries(
              data: _currentData,
              color: const Color(0xFFFFBC00),
              name: 'Current',
              lineWidth: 2.0,
              showDots: false,
            ),
            FcpLiveGraphSeries(
              data: _voltageData,
              color: const Color(0xFF01B2A8),
              name: 'Voltage',
              lineWidth: 2.0,
              showDots: false,
            ),
          ],
          config: FcpLiveGraphConfig(
            title: 'Live Current & Voltage',
            subtitle: _isRunning
                ? 'Dual parameter monitoring (${_currentData.length} points)'
                : 'Click Start to begin live updates',
            height: 250,
            showLegend: true,
            persistentData: _persistentData,
            maxDataPoints: _maxDataPoints,
            maxVisibleDataPoints: _maxVisibleDataPoints,
            yAxis: const FcpLiveGraphAxis(
              title: 'Value',
              unit: '',
              interval: 1,
              min: 0,
              max: 6,
            ),
            xAxis: FcpLiveGraphAxis(
              title: 'Time',
              unit: 's',
              interval: 5,
              min: _currentData.isNotEmpty ? _currentData.first.x : 0,
              max: _currentData.isNotEmpty ? _currentData.last.x + 5 : 10,
            ),
          ),
        ),
      ],
    );
  }
}

/// Professional styled live graph example
class ProfessionalLiveGraphExample extends StatefulWidget {
  const ProfessionalLiveGraphExample({super.key});

  @override
  State<ProfessionalLiveGraphExample> createState() =>
      _ProfessionalLiveGraphExampleState();
}

class _ProfessionalLiveGraphExampleState
    extends State<ProfessionalLiveGraphExample> {
  final List<FcpLiveGraphData> _batteryData = [];
  final Random _random = Random();
  Timer? _timer;
  double _xValue = 0;
  bool _isRunning = false;

  // Configuration for data management
  static const bool _persistentData = false; // Remove old data for performance
  static const int _maxDataPoints = 100;
  static const int _maxVisibleDataPoints = 50;

  @override
  void initState() {
    super.initState();
    // Add initial value
    _batteryData.add(FcpLiveGraphData(x: _xValue, y: _randomBatteryCurrent()));
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

    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _xValue += 0.5;
        _batteryData.add(
          FcpLiveGraphData(x: _xValue, y: _randomBatteryCurrent()),
        );

        // Data management based on configuration
        if (!_persistentData && _batteryData.length > _maxDataPoints) {
          _batteryData.removeAt(0);
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
      _batteryData.clear();
      _xValue = 0;
      _isRunning = false;
      // Add initial value
      _batteryData.add(
        FcpLiveGraphData(x: _xValue, y: _randomBatteryCurrent()),
      );
    });
  }

  double _randomBatteryCurrent() {
    // Simulate battery current with some realistic patterns
    double base = 1.5 + _random.nextDouble() * 0.5; // Base 1.5-2.0A
    double noise = (_random.nextDouble() - 0.5) * 0.2; // ±0.1A noise
    return double.parse((base + noise).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Control buttons
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
            ElevatedButton(onPressed: _resetData, child: const Text('Reset')),
          ],
        ),
        const SizedBox(height: 16),

        // Professional styled live graph
        FcpLiveGraph.single(
          data: _batteryData,
          color: const Color(0xFF2E7D32),
          name: 'Battery Current',
          config: FcpLiveGraphConfig(
            title: 'Battery Current Monitoring',
            subtitle: _isRunning
                ? 'Professional monitoring dashboard (${_batteryData.length} points)'
                : 'Click Start to begin live updates',
            height: 300,
            backgroundColor: const Color(0xFFF5F5F5),
            borderRadius: 16,
            showBorder: true,
            borderColor: const Color(0xFFE0E0E0),
            borderWidth: 2,
            showLegend: true,
            showTooltips: true,
            tooltipBackgroundColor: const Color(0xFF424242),
            tooltipTextColor: Colors.white,
            tooltipBorderRadius: 8,
            persistentData: _persistentData,
            maxDataPoints: _maxDataPoints,
            maxVisibleDataPoints: _maxVisibleDataPoints,
            yAxis: const FcpLiveGraphAxis(
              title: 'Current',
              unit: ' A',
              interval: 0.5,
              min: 1.0,
              max: 2.5,
              showGrid: true,
              gridColor: Color(0xFFE0E0E0),
              gridWidth: 1,
              showDashedLines: true,
              dashArray: [5, 5],
            ),
            xAxis: FcpLiveGraphAxis(
              title: 'Time',
              unit: 's',
              interval: 10,
              min: _batteryData.isNotEmpty ? _batteryData.first.x : 0,
              max: _batteryData.isNotEmpty ? _batteryData.last.x + 10 : 20,
              showGrid: true,
              gridColor: const Color(0xFFE0E0E0),
              gridWidth: 1,
              showDashedLines: true,
              dashArray: [5, 5],
            ),
          ),
        ),
      ],
    );
  }
}

/// Quick usage examples for different chart types
class FCPChartQuickExamples {
  /// Simple area chart
  static Widget simpleAreaChart() {
    return FCPChart.area.withData(
      data: const [
        FCPChartData(x: 0, y: 10),
        FCPChartData(x: 1, y: 25),
        FCPChartData(x: 2, y: 15),
        FCPChartData(x: 3, y: 40),
      ],
      title: 'Simple Area Chart',
    );
  }

  /// Simple bar chart
  static Widget simpleBarChart() {
    return FCPChart.bar.withData(
      data: const [
        FCPChartData(x: 0, y: 20, label: 'A'),
        FCPChartData(x: 1, y: 35, label: 'B'),
        FCPChartData(x: 2, y: 15, label: 'C'),
        FCPChartData(x: 3, y: 45, label: 'D'),
      ],
      title: 'Simple Bar Chart',
    );
  }

  /// Simple line chart
  static Widget simpleLineChart() {
    return FCPChart.line.withData(
      data: const [
        FCPChartData(x: 0, y: 100),
        FCPChartData(x: 1, y: 120),
        FCPChartData(x: 2, y: 110),
        FCPChartData(x: 3, y: 140),
      ],
      title: 'Simple Line Chart',
    );
  }

  /// Simple histogram
  static Widget simpleHistogram() {
    return FCPChart.histogram.withData(
      data: const [
        FCPChartData(x: 0, y: 5, label: '0-10'),
        FCPChartData(x: 1, y: 12, label: '10-20'),
        FCPChartData(x: 2, y: 8, label: '20-30'),
        FCPChartData(x: 3, y: 15, label: '30-40'),
      ],
      title: 'Simple Histogram',
    );
  }

  /// Custom styled chart
  static Widget customStyledChart() {
    return FCPChart.area.withData(
      data: const [
        FCPChartData(x: 0, y: 20),
        FCPChartData(x: 1, y: 35),
        FCPChartData(x: 2, y: 25),
        FCPChartData(x: 3, y: 45),
      ],
      title: 'Custom Styled Chart',
      backgroundColor: Colors.grey[50],
      borderRadius: 16,
      customConfig: FCPAreaChartConfig(
        showDots: true,
        areaOpacity: 0.4,
        lineWidth: 4,
        dotRadius: 6,
      ),
    );
  }

  /// Fully customizable chart with all fl_chart properties
  static Widget fullyCustomizableChart() {
    return FCPChart.line.withData(
      data: const [
        FCPChartData(x: 0, y: 20),
        FCPChartData(x: 1, y: 35),
        FCPChartData(x: 2, y: 25),
        FCPChartData(x: 3, y: 45),
        FCPChartData(x: 4, y: 40),
      ],
      title: 'Fully Customizable Chart',
      subtitle: 'All fl_chart properties exposed',
      height: 300,
      customConfig: FCPLineChartConfig(
        lineColor: Colors.deepPurple,
        lineWidth: 5,
        showDots: true,
        dotColor: Colors.orange,
        dotRadius: 8,
        isCurved: true,
      ),
      customGridData: FCPGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) => FCPLine(
          color: Colors.blue.withValues(alpha: 0.2),
          strokeWidth: 2,
          dashArray: [10, 5],
        ),
        getDrawingVerticalLine: (value) => FCPLine(
          color: Colors.red.withValues(alpha: 0.2),
          strokeWidth: 2,
          dashArray: [10, 5],
        ),
      ),
      customTitlesData: FCPTitlesData(
        show: true,
        bottomTitles: FCPAxisTitles(
          sideTitles: FCPSideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              return Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Q${value.toInt() + 1}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: FCPAxisTitles(
          sideTitles: FCPSideTitles(
            showTitles: true,
            reservedSize: 50,
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toInt()}k',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
      ),
      customBorderData: FCPBorderData(
        show: true,
        border: Border.all(color: Colors.purple, width: 2),
      ),
    );
  }

  /// Multiple data series example
  static Widget multipleDataSeriesChart() {
    final series1 = [
      const FCPChartData(x: 0, y: 10, color: Colors.blue),
      const FCPChartData(x: 1, y: 25, color: Colors.blue),
      const FCPChartData(x: 2, y: 15, color: Colors.blue),
      const FCPChartData(x: 3, y: 40, color: Colors.blue),
    ];

    final series2 = [
      const FCPChartData(x: 0, y: 20, color: Colors.red),
      const FCPChartData(x: 1, y: 30, color: Colors.red),
      const FCPChartData(x: 2, y: 25, color: Colors.red),
      const FCPChartData(x: 3, y: 35, color: Colors.red),
    ];

    return FCPChart.area.withData(
      data: series1,
      title: 'Multiple Data Series',
      subtitle: 'Two overlapping area charts',
      height: 250,
      multipleDataSeries: [series1, series2],
      customConfig: FCPAreaChartConfig(
        showDots: true,
        areaOpacity: 0.3,
        lineWidth: 3,
      ),
    );
  }

  /// Simple current measurement chart
  static Widget simpleCurrentChart() {
    return FCPChart.line.withData(
      data: const [
        FCPChartData(x: 0, y: 2.0),
        FCPChartData(x: 1, y: 1.8),
        FCPChartData(x: 2, y: 1.0),
        FCPChartData(x: 3, y: 0.4),
        FCPChartData(x: 4, y: 0.5),
        FCPChartData(x: 5, y: 0.0),
      ],
      title: 'Current (in Ampere)',
      height: 300,
      backgroundColor: Colors.white,
      customConfig: FCPLineChartConfig(
        lineColor: const Color(0xFF2E7D32), // Dark green
        lineWidth: 4,
        showDots: false,
        isCurved: true,
      ),
      customBorderData: FCPBorderData(
        show: true,
        border: Border.all(
          color: const Color(0xFF64B5F6), // Light blue border
          width: 2,
        ),
      ),
    );
  }

  /// Current measurement chart - recreates the uploaded image
  static Widget currentMeasurementChart() {
    // Generate smooth data points that exactly match the image pattern
    final List<FCPChartData> currentData = [];

    // Generate 500 points for smooth curve
    for (int i = 0; i <= 500; i++) {
      double time = (i / 500.0) * 5.0; // 0 to 5 hours
      double current = _calculateExactCurrent(time);
      currentData.add(FCPChartData(x: time, y: current));
    }

    return FCPChart.line.withData(
      data: currentData,
      title: 'Current (in Ampere)',
      height: 300,
      backgroundColor: Colors.white,
      customConfig: FCPLineChartConfig(
        lineColor: const Color(0xFF1B5E20), // Dark green
        lineWidth: 3,
        showDots: false,
        isCurved: true,
      ),
      customGridData: FCPGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: 0.5, // Every 0.5 A
        verticalInterval: 1.0, // Every 1 hour
        getDrawingHorizontalLine: (value) =>
            FCPLine(color: Colors.grey.withValues(alpha: 0.4), strokeWidth: 1),
        getDrawingVerticalLine: (value) =>
            FCPLine(color: Colors.grey.withValues(alpha: 0.4), strokeWidth: 1),
      ),
      customTitlesData: FCPTitlesData(
        show: true,
        rightTitles: const FCPAxisTitles(
          sideTitles: FCPSideTitles(showTitles: false),
        ),
        topTitles: const FCPAxisTitles(
          sideTitles: FCPSideTitles(showTitles: false),
        ),
        bottomTitles: FCPAxisTitles(
          sideTitles: FCPSideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1.0, // Every hour
            getTitlesWidget: (value, meta) {
              if (value == 0) {
                return const Text(
                  '0s',
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                );
              }
              return Text(
                '${value.toInt()}h',
                style: const TextStyle(color: Colors.black87, fontSize: 12),
              );
            },
          ),
        ),
        leftTitles: FCPAxisTitles(
          sideTitles: FCPSideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: 0.5, // Every 0.5 A
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toStringAsFixed(1)} A',
                style: const TextStyle(color: Colors.black87, fontSize: 12),
              );
            },
          ),
        ),
      ),
      customBorderData: FCPBorderData(
        show: true,
        border: Border.all(
          color: const Color(0xFF1976D2), // Blue border
          width: 2,
        ),
      ),
    );
  }

  /// Calculate exact current value at given time to match the image
  static double _calculateExactCurrent(double time) {
    if (time <= 1.0) {
      // Initial stable phase: 2.0A to 1.9A
      return 2.0 - (time * 0.1);
    } else if (time <= 1.5) {
      // Sharp drop phase: 1.9A to 0.9A
      double progress = (time - 1.0) / 0.5;
      return 1.9 - (progress * 1.0);
    } else if (time <= 1.8) {
      // Sharp rise phase: 0.9A to 1.6A
      double progress = (time - 1.5) / 0.3;
      return 0.9 + (progress * 0.7);
    } else if (time <= 2.0) {
      // Drop phase: 1.6A to 1.0A
      double progress = (time - 1.8) / 0.2;
      return 1.6 - (progress * 0.6);
    } else if (time <= 3.0) {
      // Gradual decline: 1.0A to 0.4A
      double progress = (time - 2.0) / 1.0;
      return 1.0 - (progress * 0.6);
    } else if (time <= 3.5) {
      // Small fluctuation: 0.4A to 0.5A to 0.4A
      double progress = (time - 3.0) / 0.5;
      return 0.4 + (sin(progress * pi) * 0.1);
    } else if (time <= 4.0) {
      // Stable around 0.4A
      return 0.4 + (sin(time * 10) * 0.05);
    } else if (time <= 4.5) {
      // Dip and rise: 0.4A to 0.2A to 0.3A
      double progress = (time - 4.0) / 0.5;
      return 0.4 - (progress * 0.2) + (sin(progress * pi * 2) * 0.1);
    } else {
      // Final drop: 0.3A to 0.1A
      double progress = (time - 4.5) / 0.5;
      return 0.3 - (progress * 0.2);
    }
  }
}
