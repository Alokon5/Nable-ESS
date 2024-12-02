import 'package:get/get.dart';

class LateEalryController extends GetxController {
  // To track the selected tab index
  var selectedIndex = 0.obs;

  // Change the tab index and notify observers
  void changeTabIndex(int index) {
    if (selectedIndex.value != index) {
      print("Tab changed to: $index"); // Debug print to track tab changes
      selectedIndex.value = index;
    }
  }
}
