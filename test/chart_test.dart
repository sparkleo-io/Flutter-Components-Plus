import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

void main() {
  group('FCPChart Tests', () {
    testWidgets('FCPChart.area creates area chart', (
      WidgetTester tester,
    ) async {
      final data = [
        const FCPChartData(x: 0, y: 10),
        const FCPChartData(x: 1, y: 25),
        const FCPChartData(x: 2, y: 15),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FCPChart.area.withData(data: data, title: 'Test Area Chart'),
          ),
        ),
      );

      expect(find.text('Test Area Chart'), findsOneWidget);
      expect(find.byType(FCPChart), findsOneWidget);
    });

    testWidgets('FCPChart.bar creates bar chart', (WidgetTester tester) async {
      final data = [
        const FCPChartData(x: 0, y: 20, label: 'A'),
        const FCPChartData(x: 1, y: 35, label: 'B'),
        const FCPChartData(x: 2, y: 15, label: 'C'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FCPChart.bar.withData(data: data, title: 'Test Bar Chart'),
          ),
        ),
      );

      expect(find.text('Test Bar Chart'), findsOneWidget);
      expect(find.byType(FCPChart), findsOneWidget);
    });

    testWidgets('FCPChart.line creates line chart', (
      WidgetTester tester,
    ) async {
      final data = [
        const FCPChartData(x: 0, y: 100),
        const FCPChartData(x: 1, y: 120),
        const FCPChartData(x: 2, y: 110),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FCPChart.line.withData(data: data, title: 'Test Line Chart'),
          ),
        ),
      );

      expect(find.text('Test Line Chart'), findsOneWidget);
      expect(find.byType(FCPChart), findsOneWidget);
    });

    testWidgets('FCPChart.histogram creates histogram chart', (
      WidgetTester tester,
    ) async {
      final data = [
        const FCPChartData(x: 0, y: 5, label: '0-10'),
        const FCPChartData(x: 1, y: 12, label: '10-20'),
        const FCPChartData(x: 2, y: 8, label: '20-30'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FCPChart.histogram.withData(
              data: data,
              title: 'Test Histogram Chart',
            ),
          ),
        ),
      );

      expect(find.text('Test Histogram Chart'), findsOneWidget);
      expect(find.byType(FCPChart), findsOneWidget);
    });

    testWidgets('FCPChart with legend displays legend', (
      WidgetTester tester,
    ) async {
      final data = [
        const FCPChartData(x: 0, y: 20),
        const FCPChartData(x: 1, y: 35),
      ];

      final legend = FCPChartLegend(
        items: [const FCPLegendItem(label: 'Series 1', color: Colors.blue)],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FCPChart.area.withData(
              data: data,
              title: 'Test Chart with Legend',
              legend: legend,
            ),
          ),
        ),
      );

      expect(find.text('Test Chart with Legend'), findsOneWidget);
      expect(find.text('Series 1'), findsOneWidget);
      expect(find.byType(FCPChart), findsOneWidget);
    });
  });
}
