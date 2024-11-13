import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/videos/controller.dart';

import '../home/controller.dart';
import 'controller.dart';

class ManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(HomeManagerController());
    Get.put(ManagerController());
    Get.put(StaffVideocontroller());
    //  Get.lazyPut(() => HomeManagementController());
  }
}
