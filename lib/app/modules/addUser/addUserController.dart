// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/providers/firebase_provider.dart';
import 'package:nable_ess/app/data/providers/storage_provider.dart';

class AdduserController extends GetxController {
  final FirebaseProvider _firebaseProvider = FirebaseProvider();
  final StorageProvider _storage = StorageProvider();

  final loginFormKey = GlobalKey<FormState>();

  final userName = TextEditingController();
  final userEmail = TextEditingController();
  final userPassword = TextEditingController();

  var role = "".obs;

  var isLoading = false.obs;
  void setLoading(bool value) {
    isLoading.value = value;
  }

  //  void createUser() async {
  //   // if (loginFormKey.currentState!.validate()) {
  //     setLoading(true);
  //     var success = await _firebaseProvider.createCredentialWithEmail(
  //       userEmail.text.trim(),userName.text,userPassword.text.trim(),role,
  //         );
  //     if (success) {
  //       Get.snackbar("Succcess","Created account");
  //       // UserModel _userModel = await _storage.readUserModel();
  //       // var isVerfied = _userModel.emailVerified ?? false;
  //       // print(_userModel.email);
  //       // clearAllEditingController();
  //       // Get.toNamed(AppRoutes.managementBaseScreen);
  //       setLoading(false);
  //     } else {
  //       setLoading(false);
  //     }
  // }
}
  

// }