// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/authentication/widgets/view/otp_verification.dart';
import 'package:nable_ess/app/modules/authentication/widgets/view/reset_password_view.dart';

import '../../data/models/user_model.dart';
import '../../data/providers/firebase_provider.dart';
import '../../data/providers/storage_provider.dart';
import '../../routes/route.dart';

class AuthController extends GetxController {
  // ignore: unused_field
  final FirebaseProvider _firebaseProvider = FirebaseProvider();
  final APIsProvider _apIsProvider = APIsProvider();
  // ignore: unused_field
  final StorageProvider _storage = StorageProvider();

  final login2FormKey = GlobalKey<FormState>();

  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final otpEditingController = TextEditingController();
  var user = <UserModel>[].obs;

  RxString role = "Management".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // Setter Getter
  var isLoading = false.obs;
  void setLoading(bool value) {
    isLoading.value = value;
  }

  RxBool isPasswordVisible = false.obs;
  void changePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void clearAllEditingController() {
    emailEditingController.clear();
    passwordEditingController.clear();
  }

  Future<bool> _loginAsManagement() async {
    print(emailEditingController.text.trim());

    var success = await _apIsProvider.loginAsManagement(
        emailEditingController.text.trim(),
        passwordEditingController.text.trim());
    if (success) {
      StorageProvider storageProvider = StorageProvider();
      UserModel user = await storageProvider.readUserModel();

      if (user.role == "Management") {
        Get.offNamed((AppRoutes.managementBaseScreen));
        Get.delete<AuthController>();
      } else if (user.role == "Manager") {
        print("this is manager");
        Get.offNamed(AppRoutes.homeManager);
        Get.delete<AuthController>();
      } else if (user.role == "Staff") {
        print("this is staff");
        Get.offNamed(AppRoutes.staffBase);
        Get.delete<AuthController>();
      }

      return true;
    } else {
      return false;
    }
  }

  void login() async {
    isLoading.value = true;
    if (login2FormKey.currentState!.validate()) {
      var status = await _loginAsManagement();

      isLoading.value = false;
    }
  }

  // Reset Password functions
  Future<bool> forgotEmailRequest() async {
    isLoading.value = true;
    print(emailEditingController.text.trim());

    var success = await _apIsProvider
        .forgotEmailRequest(emailEditingController.text.trim());

    if (success!) {
      isLoading.value = false;
      EasyLoading.showSuccess(
        "OTP Send Successful",
      );
      Get.to(() => otpVerification(
            email: emailEditingController.text.trim(),
          ));
      return true;
    } else {
      EasyLoading.showSuccess(
        "OTP not Send",
      );
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> forgotOtpVerification() async {
    print(emailEditingController.text.trim());
    print(otpEditingController.text.trim());

    var success = await _apIsProvider.forgotOtpVerification(
        emailEditingController.text.trim(), otpEditingController.text.trim());

    if (success!) {
      Get.off(
        () => PasswordResetScreen(email: emailEditingController.text.trim()),
      );
      return true;
    } else {
      EasyLoading.showSuccess(
        "OTP Invalid",
      );
      return false;
    }
  }

  Future<bool> forgotAsConfirmPassword(email) async {
    print(email);
    print(passwordEditingController.text.trim());

    var success = await _apIsProvider.forgotConfirmPassword(
        emailEditingController.text.trim(),
        passwordEditingController.text.trim());

    String password = passwordEditingController.text.trim();
    String confirmPassword = confirmPasswordEditingController.text.trim();

    if (success) {
      if (password == confirmPassword) {
        Get.offNamed(AppRoutes.splashScreen);
      } else {
        EasyLoading.showSuccess("Password not Same");
      }
      return true;
    } else {
      EasyLoading.showSuccess(
        "Password not Change",
      );
      return false;
    }
  }
}
