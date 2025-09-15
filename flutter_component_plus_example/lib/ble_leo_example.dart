import 'package:flutter/material.dart';
import 'package:flutter_component_plus_example/ble_leo_example_controller.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import 'package:get/get.dart';

class BleLeoExample extends StatelessWidget {
  const BleLeoExample({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BleLeoExampleController>();
    return Scaffold(
      body: Center(
        child: Obx(
          () => Column(
            spacing: 20,
            children: [
              const Text('BLE Leo Example'),
              FCPButton.small.primary(
                text: 'Initialize BLE',
                onPressed: controller.initializeBLE,
              ),
              FCPButton.small.primary(
                text: 'Start Scan',
                isDisabled:
                    !controller.isInitialized.value &&
                    controller.isScanning.value,
                isLoading: controller.isScanning.value,
                onPressed: controller.startScan,
              ),
              ElevatedButton.icon(
                onPressed:
                    controller.isInitialized.value &&
                        !controller.isScanning.value
                    ? controller.startScan
                    : null,
                icon: const Icon(Icons.search),
                label: const Text('Start Scan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
