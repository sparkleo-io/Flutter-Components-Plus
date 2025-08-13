import 'package:get/get.dart';
import 'components_controller.dart';

class ComponentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComponentsController>(() => ComponentsController());
  }
}
