import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/manageLeave/controller.dart';

class LeaveBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LeaveController());
   
    //  Get.lazyPut(() => HomeManagementController());
  }
}