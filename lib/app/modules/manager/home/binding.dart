import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/profile/controller.dart';
import 'package:nable_ess/app/modules/manager/videos/controller.dart';

import 'controller.dart';

class HomeManagerBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(StaffVideocontroller());
    Get.put(HomeManagerController());
    Get.put(ProfileManagerController());
  }
}
