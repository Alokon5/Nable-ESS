import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/videos/controller.dart';

class StaffControllerBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(StaffVideocontroller());
  }
}
