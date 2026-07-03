import 'package:flutter/material.dart';
import 'package:example/app/controllers/live_chart_controller.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';
import 'package:get/get.dart';
import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FCPPdfDownloadService.instance.initialize();
  Get.put(LiveChartController());
  runApp(const App());
}
