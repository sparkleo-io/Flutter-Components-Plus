import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import 'package:get/get.dart';

class LiveChartController extends GetxController {
  // Observable data list
  final RxList<FCPChartData> chartData = <FCPChartData>[].obs;

  // Timer for live updates
  Timer? _timer;

  // Chart configuration
  final RxBool isPlaying = false.obs;
  final RxDouble currentTime = 0.0.obs;
  final RxDouble currentValue = 0.0.obs;

  // Chart parameters
  static const double maxTime = 5.0; // 5 hours
  static const double maxCurrent = 2.5; // 2.5 Amperes
  static const int pointsPerSecond =
      10; // 10 points per second for smooth animation

  @override
  void onInit() {
    super.onInit();
    _initializeChartData();
  }

  // @override
  // void onClose() {
  //   _timer?.cancel();
  //   super.onClose();
  // }

  void _initializeChartData() {
    chartData.clear();
    // Add initial data points to establish proper axis ranges
    // This ensures the chart knows the full range from the start
    chartData.addAll([
      const FCPChartData(x: 0.0, y: 0.0),
      const FCPChartData(x: 1.0, y: 0.0),
      const FCPChartData(x: 2.0, y: 0.0),
      const FCPChartData(x: 3.0, y: 0.0),
      const FCPChartData(x: 4.0, y: 0.0),
      const FCPChartData(x: 5.0, y: 0.0),
    ]);
  }

  double _calculateCurrentAtTime(double time, Random random) {
    double baseValue;

    if (time <= 1.0) {
      // Initial stable phase: 2.0A to 1.9A
      baseValue = 2.0 - (time * 0.1);
    } else if (time <= 1.5) {
      // Sharp drop phase: 1.9A to 0.9A
      double progress = (time - 1.0) / 0.5;
      baseValue = 1.9 - (progress * 1.0);
    } else if (time <= 1.8) {
      // Sharp rise phase: 0.9A to 1.6A
      double progress = (time - 1.5) / 0.3;
      baseValue = 0.9 + (progress * 0.7);
    } else if (time <= 2.0) {
      // Drop phase: 1.6A to 1.0A
      double progress = (time - 1.8) / 0.2;
      baseValue = 1.6 - (progress * 0.6);
    } else if (time <= 3.0) {
      // Gradual decline: 1.0A to 0.4A
      double progress = (time - 2.0) / 1.0;
      baseValue = 1.0 - (progress * 0.6);
    } else if (time <= 3.5) {
      // Small fluctuation: 0.4A to 0.5A to 0.4A
      double progress = (time - 3.0) / 0.5;
      baseValue = 0.4 + (sin(progress * pi) * 0.1);
    } else if (time <= 4.0) {
      // Stable around 0.4A
      baseValue = 0.4 + (sin(time * 10) * 0.05);
    } else if (time <= 4.5) {
      // Dip and rise: 0.4A to 0.2A to 0.3A
      double progress = (time - 4.0) / 0.5;
      baseValue = 0.4 - (progress * 0.2) + (sin(progress * pi * 2) * 0.1);
    } else {
      // Final drop: 0.3A to 0.1A
      double progress = (time - 4.5) / 0.5;
      baseValue = 0.3 - (progress * 0.2);
    }

    // Add some realistic noise
    double noise = (random.nextDouble() - 0.5) * 0.02;
    baseValue += noise;

    // Ensure values stay within bounds
    return baseValue.clamp(0.0, maxCurrent);
  }

  void startLiveAnimation() {
    if (_timer != null) return;

    isPlaying.value = true;
    currentTime.value = 0.0;
    currentValue.value = 0.0;

    // Clear any existing data and start with first real data point
    chartData.clear();
    chartData.add(const FCPChartData(x: 0.0, y: 0.0));

    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      currentTime.value += 0.1;

      if (currentTime.value >= maxTime) {
        stopLiveAnimation();
        return;
      }

      // Update current value based on time
      final random = Random(42);
      currentValue.value = _calculateCurrentAtTime(currentTime.value, random);

      // Add new data point
      chartData.add(FCPChartData(x: currentTime.value, y: currentValue.value));
    });
  }

  void stopLiveAnimation() {
    _timer?.cancel();
    _timer = null;
    isPlaying.value = false;
  }

  void resetChart() {
    stopLiveAnimation();
    currentTime.value = 0.0;
    currentValue.value = 0.0;
    _initializeChartData(); // Reset to initial state with proper axis ranges
  }

  void toggleAnimation() {
    if (isPlaying.value) {
      stopLiveAnimation();
    } else {
      startLiveAnimation();
    }
  }

  // Get chart configuration
  FCPLineChartConfig get chartConfig => FCPLineChartConfig(
    lineColor: const Color(0xFF1B5E20), // Dark green
    lineWidth: 3,
    showDots: false,
    isCurved: true,
  );

  FCPGridData get gridData => FCPGridData(
    show: true,
    drawVerticalLine: true,
    drawHorizontalLine: true,
    horizontalInterval: 0.5, // Every 0.5 A
    verticalInterval: 1.0, // Every 1 hour
    getDrawingHorizontalLine: (value) =>
        FCPLine(color: Colors.grey.withOpacity(0.4), strokeWidth: 1),
    getDrawingVerticalLine: (value) =>
        FCPLine(color: Colors.grey.withOpacity(0.4), strokeWidth: 1),
  );

  FCPTitlesData get titlesData => FCPTitlesData(
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
  );

  FCPBorderData get borderData => FCPBorderData(
    show: true,
    border: Border.all(
      color: const Color(0xFF1976D2), // Blue border
      width: 2,
    ),
  );
}
