import 'package:flutter/material.dart';
import 'package:example/app/controllers/live_chart_controller.dart';
import 'package:get/get.dart';
import 'app/app.dart';

void main() {
  Get.put(LiveChartController());
  runApp(const App());
}
