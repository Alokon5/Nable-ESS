import 'package:get/get.dart';
import 'controller.dart';

class LeaveBaseViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LeaveBaseViewController());
    //  Get.lazyPut(() => HomeManagementController());
  }
}
