import 'package:get/get.dart';
import 'controller.dart';

// Manages dependencies auth
class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}
