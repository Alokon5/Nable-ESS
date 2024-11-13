import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/home/controller.dart';

class HomeManagementBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(HomeManagementController());
  }
}
