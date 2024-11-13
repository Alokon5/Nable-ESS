import 'package:get/get.dart';

import 'controller.dart';

class StaffHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(StaffHomeController());
  }
}
