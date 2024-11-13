import 'package:get/get.dart';
import 'package:nable_ess/app/modules/addUser/addUserController.dart';

class AdduserBinding implements Bindings{


  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AdduserController());
  }
}