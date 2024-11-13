import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/base/controller.dart';
import 'package:nable_ess/app/modules/management/home/controller.dart';
import 'package:nable_ess/app/modules/management/profile/controller.dart';

class ManagementBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProfileManagementController());
    Get.put(HomeManagementController());
    Get.put(ManagementController());
    //  Get.lazyPut(() => HomeManagementController());
  }
}
