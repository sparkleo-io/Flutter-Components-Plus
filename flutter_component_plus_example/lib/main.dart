import 'package:flutter/material.dart';
import 'package:flutter_component_plus_example/app/controllers/live_chart_controller.dart';
import 'package:flutter_component_plus_example/ble_leo_example_controller.dart';
import 'package:get/get.dart';
import 'app/app.dart';

void main() {
  Get.put(LiveChartController());
  Get.put(BleLeoExampleController());
  runApp(const App());
}
