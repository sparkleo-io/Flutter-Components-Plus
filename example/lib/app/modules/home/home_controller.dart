import 'package:get/get.dart';

class HomeController extends GetxController {
  final _selectedTabIndex = 0.obs;
  final _isLoading = false.obs;

  int get selectedTabIndex => _selectedTabIndex.value;
  bool get isLoading => _isLoading.value;

  void changeTab(int index) {
    _selectedTabIndex.value = index;
  }

  void startLoading() async {
    _isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    _isLoading.value = false;
  }
}
