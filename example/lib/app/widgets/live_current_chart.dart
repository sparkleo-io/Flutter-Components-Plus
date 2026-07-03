import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import 'package:get/get.dart';
import '../controllers/live_chart_controller.dart';

class LiveCurrentChart extends StatelessWidget {
  const LiveCurrentChart({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LiveChartController>();
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Current (in Ampere)',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                Row(
                  children: [
                    // Current value display
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B5E20).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${controller.currentValue.value.toStringAsFixed(2)} A',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5E20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Time display
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${controller.currentTime.value.toStringAsFixed(1)}h',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Chart
            FCPChart.line.withData(
              data: controller.chartData,
              height: 300,
              backgroundColor: Colors.white,
              customConfig: controller.chartConfig,
              customGridData: controller.gridData,
              customTitlesData: controller.titlesData,
              customBorderData: controller.borderData,
            ),

            const SizedBox(height: 16),

            // Control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: controller.toggleAnimation,
                  icon: Icon(
                    controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                  label: Text(
                    controller.isPlaying.value ? 'Pause' : 'Play',
                    style: const TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B5E20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: controller.resetChart,
                  icon: const Icon(Icons.refresh, color: Colors.white),
                  label: const Text(
                    'Reset',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Status indicator
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: controller.isPlaying.value
                    ? Colors.green.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: controller.isPlaying.value
                      ? Colors.green
                      : Colors.grey,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    controller.isPlaying.value
                        ? Icons.fiber_manual_record
                        : Icons.stop,
                    color: controller.isPlaying.value
                        ? Colors.green
                        : Colors.grey,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    controller.isPlaying.value
                        ? 'Live data streaming...'
                        : 'Chart ready - Press Play to start',
                    style: TextStyle(
                      color: controller.isPlaying.value
                          ? Colors.green
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
