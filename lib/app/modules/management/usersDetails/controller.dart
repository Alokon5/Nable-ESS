import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/allVideosModel/allVideoModel.dart';
import 'package:video_player/video_player.dart';

import '../../../data/models/allEmployeesModel.dart';
import '../../../data/models/dateTime.dart';
import '../../../data/models/designationModel/designationModel.dart';
import '../../../data/models/userDetailsModel.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/storage_provider.dart';

class UsersController extends GetxController with SingleGetTickerProviderMixin {
  StorageProvider storageProvider = StorageProvider();
  APIsProvider apIsProvider = APIsProvider();

  var isLoading = false.obs;
  var userType = 0.obs;
  var user = <UserModel>[].obs;

  var allEmployeesList = <Datum>[].obs;
  User? userDetails;

  var userVideos = <Video>[].obs;

  var allVideos = <AllVideosData>[].obs;
  var desgnationList = <DesignationModel>[].obs;
  var selectedUserFileter = "All".obs;
  var addButtonEnabled = false.obs;

  User? employeeDetails;
  late TabController managerProfileTab;
  late VideoPlayerController playVideosController;

  // late TabController tabController =TabController(length: 2, vsync: this );
  final List<Tab> profileTab = [
    const Tab(
      child: SizedBox(
        // width: 100,
        child: SizedBox(
          // width: 100,
          child: Text('Videos',
              style: TextStyle(
                  color: Color.fromARGB(255, 6, 1, 1),
                  fontWeight: FontWeight.w500)),
        ),
      ),
    ),
    const Tab(
      child: Text(
        'Staffs',
        style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.w500),
      ),
    ),
  ];
  addButtonTrueFalse() {
    if (addButtonEnabled.value == true) {
      addButtonEnabled.value = false;
    } else {
      addButtonEnabled.value = true;
    }
  }

  dateTimeFormator(dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    // print(dateTimeStr);

    String formattedTime = DateFormat('h:mm a').format(dateTime);
    String date = "${DateFormat('dd-MMM-yyyy').format(dateTime)}";
    // print("date -=--=-$date");
    // print("time -=--=-$formattedTime");
    var formatedDateTime = DateTimeModel(date: date, time: formattedTime);
    return formatedDateTime;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    isLoading.value = false;
    var userDetails = await storageProvider.readUserModel();
    user.assign(userDetails);
    managerProfileTab = TabController(length: profileTab.length, vsync: this);
    await getDesignation();
    await fetchUsers();
    await getAllVideos();
    // tabController = TabController(length: 2, vsync: this);
  }

  fetchUsers() async {
    if (selectedUserFileter.value == "All") {
      await getAllEmployees();
    } else if (selectedUserFileter.value == "Manager") {
      await getAllManagers();
    } else {
      await getAllStaffs();
    }
  }

  getAllEmployees() async {
    isLoading.value = true;
    var employees = await apIsProvider.fetchAllEmployees(user[0].token);

    AllEmployeesModel? employeeo;
    print("employeee -------${employees!.data!.length}");
    if (employees.data!.length == 0) {
      EasyLoading.showError(
        "Employees not found",
      );
    } else {
      employeeo = employees;
      allEmployeesList.assignAll(employeeo.data!);

      // print("allEmployeesList[0].email------${allEmployeesList[0].email}");
    }

    isLoading.value = false;
  }

  getDesignationNameViaId(id) {
    var obj = desgnationList.where((p0) => p0.id == id).first;
    print("object -=-=-=-=-${obj.name}");
    return obj.name;
  }

  Future getDesignation() async {
    var status = await apIsProvider.getDesignationList(user[0].token);
    if (status!.length.toInt() != 0) {
      desgnationList.assignAll(status);
    }
  }

  getAllManagers() async {
    isLoading.value = true;
    var employees = await apIsProvider.fetchAllManagers(user[0].token);

    AllEmployeesModel? employeeo;

    if (employees.data!.length == 0) {
      EasyLoading.showSuccess(
        "Employees not found",
      );
    } else {
      employeeo = employees;
      allEmployeesList.assignAll(employeeo.data!);

      // print("allEmployeesList[0].email------${allEmployeesList[0].email}");
    }

    isLoading.value = false;
  }

  getAllStaffs() async {
    isLoading.value = true;
    var employees =
        await apIsProvider.fetchAllStaffForManageMent(user[0].token);

    AllEmployeesModel? employeeo;

    if (employees.data!.length.toInt() == 0) {
      isLoading.value = false;
      EasyLoading.showError(
        "Employees not found",
      );
    } else {
      employeeo = employees;
      allEmployeesList.assignAll(employeeo.data!);
      isLoading.value = false;

      // print("allEmployeesList[0].email------${allEmployeesList[0].email}");
    }

    isLoading.value = false;
  }

  getUserDetails(id) async {
    isLoading.value = true;
    var status = await apIsProvider.fetchUserDetails(user[0].token, id);
    print("status-------=-=--${status.user!.email}");
    userDetails = status.user;
    userVideos.assignAll(status.video!.toList());

    userVideos.sort(((a, b) => b.id!.compareTo(a.id!)));
    allVideos.sort(((a, b) => b.id!.compareTo(a.id!)));
    print("videoList-=-=-${userVideos.length}");

    if (status != null) {
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  getAllVideos() async {
    isLoading.value = true;
    var status = await apIsProvider.fetchAllVideos(user[0].token);

    allVideos.assignAll(status!.data!.toList());
    allVideos.sort(
      (a, b) => a.id!.compareTo(b.id!),
    );
    print("All Videos-=-=-${allVideos.length}");

    if (status != null) {
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  getStaffViaId(id) async {
    isLoading.value = true;
    var status = await apIsProvider.fetchStaffsViaManagerId(user[0].token, id);

    AllEmployeesModel? employeeo;

    if (status.data!.length.toInt() == 0) {
      isLoading.value = false;
      allEmployeesList.assignAll([]);
      EasyLoading.showError(
        "Staff not found",
      );
    } else {
      employeeo = status;
      allEmployeesList.assignAll(employeeo.data!);
      isLoading.value = false;

      // print("allEmployeesList[0].email------${allEmployeesList[0].email}");
    }

    isLoading.value = false;
  }

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
}
