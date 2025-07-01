import 'package:get/get.dart';

class MainController extends GetxController {
  var selectedTabIndex = 1.obs;

  void updateTabIndex(int index) {
    selectedTabIndex.value = index;
  }
}