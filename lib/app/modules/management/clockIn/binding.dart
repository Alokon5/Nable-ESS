import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/clockIn/controller.dart';

class ClockInBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ClockInController());
  }
}
