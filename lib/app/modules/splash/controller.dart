import 'dart:async';

import 'package:get/get.dart';
import 'package:nable_ess/app/data/models/user_model.dart';
import 'package:nable_ess/app/data/providers/storage_provider.dart';

import '../../routes/route.dart';

class SplashController extends GetxController {
  late Timer _timer;
  var deviceUser = StorageProvider();

  @override
  void onInit() {
    super.onInit();
    _splashTime();
  }

  void _splashTime() async {
    UserModel user = await deviceUser.readUserModel();

    print("userType --=--=-${user.role}");

    _timer = Timer(const Duration(seconds: 3), () async {
      print("${user.token}  ${user.token}");
      if (user.token != null) {
        if (user.role == "Management") {
          Get.toNamed(AppRoutes.managementBaseScreen);
          Get.delete<SplashController>();
        } else if (user.role == "Manager") {
          print("this is manager");
          Get.toNamed(AppRoutes.homeManager);
           Get.delete<SplashController>();
        } else if (user.role == "Staff") {
          print("this is staff");
          Get.toNamed(AppRoutes.staffBase);
           Get.delete<SplashController>();
        }
      } else {
        Get.offAllNamed(AppRoutes.loginScreen);
         Get.delete<SplashController>();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }
}
