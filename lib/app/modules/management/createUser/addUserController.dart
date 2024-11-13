import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/providers/apis_provider.dart';

class CreateUserController extends GetxController {
  // ignore: unused_field
  APIsProvider _apIsProvider = APIsProvider();

  final createUserFormKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  var dateOfBirth = "".obs;
  var gender = "".obs;
  var department = "".obs;

  var role = "".obs;

  var isLoading = false.obs;
  void setLoading(bool value) {
    isLoading.value = value;
  }

  RxString selectedDate = ''.obs;
  void updateSelectedDate(String date) {
    selectedDate.value = date;
  }

  var selectedDepartments = "department 1".obs;
  List<DropdownMenuItem<String>> get departmentItems => [
        DropdownMenuItem<String>(
          value: "department 1",
          child: Text("Department 1"),
        ),
        DropdownMenuItem<String>(
          value: "department 2",
          child: Text("Department 2"),
        ),
        DropdownMenuItem<String>(
          value: "department 3",
          child: Text("Department 3"),
        ),
      ];

  // Gender list
  var selectedGender = "Male".obs;
  List<DropdownMenuItem<String>> get genderItems => [
        DropdownMenuItem<String>(
          value: "Male",
          child: Text("Male"),
        ),
        DropdownMenuItem<String>(
          value: "Female",
          child: Text("Female"),
        ),
      ];

  // Roles list
  var selectedRole = "manager".obs;
  List<DropdownMenuItem<String>> get roleItems => [
        DropdownMenuItem<String>(
          value: "manager",
          child: Text("Manager"),
        ),
        DropdownMenuItem<String>(
          value: "staff",
          child: Text("Staff"),
        ),
      ];

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