import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/profile/controller.dart';

class ProfileManagementBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ProfileManagementController());
  }
}
