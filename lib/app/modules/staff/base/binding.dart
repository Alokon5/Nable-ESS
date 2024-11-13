import 'package:get/get.dart';
import 'package:nable_ess/app/modules/staff/base/controller.dart';
import 'package:nable_ess/app/modules/staff/home/controller.dart';
import 'package:nable_ess/app/modules/staff/profile/controller.dart';

class StaffBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(StaffHomeController());
    Get.put(StaffProfileController());
    Get.put(StaffController());
    //  Get.lazyPut(() => HomeManagementController());
  }
}
