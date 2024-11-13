import 'package:get/get.dart';

import 'controller.dart';

class UserDetailsBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(() => UsersController());
  }
}
