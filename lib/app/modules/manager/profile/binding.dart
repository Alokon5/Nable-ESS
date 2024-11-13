import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/profile/controller.dart';

class ProfileManagerBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ProfileManagerController());
  }
}
