import 'package:example/app/controllers/table_examples_controller.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TableExamplesController>(() => TableExamplesController());
  }
}
