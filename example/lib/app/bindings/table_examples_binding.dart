import 'package:get/get.dart';
import '../controllers/table_examples_controller.dart';

class TableExamplesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TableExamplesController>(() => TableExamplesController());
  }
}
