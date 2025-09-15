import 'package:flutter_component_plus_example/app/controllers/table_examples_controller.dart';
import 'package:get/get.dart';
import 'components_controller.dart';

class ComponentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComponentsController>(() => ComponentsController());
    Get.lazyPut<TableExamplesController>(() => TableExamplesController());
  }
}
