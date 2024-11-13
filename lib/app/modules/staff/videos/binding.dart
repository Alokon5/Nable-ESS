import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/usersDetails/widgets/videos_container.dart';

class VideoControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(VideoContainer());
    //  Get.lazyPut(() => HomeManagementController());
  }
}
