import 'package:flutter/material.dart';
import 'fcp_chart.dart';
import 'models/chart_models.dart';
import '../../core/theme/color_scheme.dart';

/// Comprehensive examples for FCPChart component
class FCPChartExamples extends StatelessWidget {
  const FCPChartExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FCPChart Examples'),
        backgroundColor: FCPColorScheme.primary,
        foregroundColor: Colors.white,
      ),
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
              color: Colors.grey.withOpacity(0.3),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
            getDrawingVerticalLine: (value) => FCPLine(
              color: Colors.grey.withOpacity(0.3),
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
          color: Colors.blue.withOpacity(0.2),
          strokeWidth: 2,
          dashArray: [10, 5],
        ),
        getDrawingVerticalLine: (value) => FCPLine(
          color: Colors.red.withOpacity(0.2),
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
                  color: Colors.blue.withOpacity(0.1),
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
    // Data points based on the chart description
    final currentData = [
      const FCPChartData(x: 0, y: 2.0), // 0s: 2.0 A
      const FCPChartData(x: 0.3, y: 2.1), // ~0.3h: 2.1 A
      const FCPChartData(x: 0.6, y: 2.05), // ~0.6h: 2.05 A
      const FCPChartData(x: 0.9, y: 1.95), // ~0.9h: 1.95 A
      const FCPChartData(x: 1.2, y: 1.8), // ~1.2h: 1.8 A
      const FCPChartData(x: 1.5, y: 0.9), // 1.5h: 0.9 A (sharp drop)
      const FCPChartData(x: 1.7, y: 1.6), // ~1.7h: 1.6 A (sharp rise)
      const FCPChartData(x: 1.8, y: 1.8), // 1.8h: 1.8 A (peak)
      const FCPChartData(x: 2.0, y: 1.0), // 2h: 1.0 A
      const FCPChartData(x: 2.5, y: 0.7), // 2.5h: 0.7 A
      const FCPChartData(x: 3.0, y: 0.4), // 3h: 0.4 A (local minimum)
      const FCPChartData(x: 3.5, y: 0.45), // 3.5h: 0.45 A
      const FCPChartData(x: 4.0, y: 0.5), // 4h: 0.5 A
      const FCPChartData(x: 4.5, y: 0.1), // 4.5h: 0.1 A (sharp drop)
      const FCPChartData(x: 4.8, y: 0.4), // 4.8h: 0.4 A (rise)
      const FCPChartData(x: 5.0, y: 0.0), // 5h: 0.0 A
    ];

    return FCPChart.line.withData(
      data: currentData,
      title: 'Current (in Ampere)',
      height: 300,
      backgroundColor: Colors.white,
      customConfig: FCPLineChartConfig(
        lineColor: const Color(0xFF2E7D32), // Dark green
        lineWidth: 4,
        showDots: false,
        isCurved: true,
        minY: 0.0,
        maxY: 2.5,
        minX: 0.0,
        maxX: 5.0,
      ),
      customGridData: FCPGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: 0.5, // Every 0.5 A
        verticalInterval: 1.0, // Every 1 hour
        getDrawingHorizontalLine: (value) =>
            FCPLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1),
        getDrawingVerticalLine: (value) =>
            FCPLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1),
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
              if (value == 0)
                return const Text('0s', style: TextStyle(color: Colors.grey));
              return Text(
                '${value.toInt()}h',
                style: const TextStyle(color: Colors.grey),
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
                style: const TextStyle(color: Colors.grey),
              );
            },
          ),
        ),
      ),
      customBorderData: FCPBorderData(
        show: true,
        border: Border.all(
          color: const Color(
            0xFF64B5F6,
          ), // Light blue border (closer to the image)
          width: 2,
        ),
      ),
    );
  }
}
