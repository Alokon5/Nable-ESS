// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:nable_ess/app/data/models/allEmployeesModel.dart';
import 'package:nable_ess/app/data/models/designationModel/designationModel.dart';

import 'package:nable_ess/app/data/models/user_model.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/data/providers/storage_provider.dart';
import 'package:nable_ess/app/modules/management/usersDetails/controller.dart';
import 'package:video_player/video_player.dart';

import '../../../data/models/allVideosModel/allVideoModel.dart';
import '../../../data/models/userDetailsModel.dart';

class HomeManagementController extends GetxController {
  StorageProvider storageProvider = StorageProvider();
  APIsProvider apIsProvider = APIsProvider();

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  late VideoPlayerController videoController;

  // initializeVideo(url) async {
  //   videoController = VideoPlayerController.networkUrl(url);
  //   videoController.initialize();
  //   videoController.play();
  // }
  var pageBuilderIndex = 0.obs;

  var role = ''.obs;
  RxInt totalUser = 0.obs;
  RxInt totalPresent = 0.obs;
  RxInt totalAbsents = 0.obs;
  var gender = ''.obs;
  var department = ''.obs;

  var isLoading = false.obs;
  var userType = 0.obs;
  var user = <UserModel>[].obs;
  var selecteMangerID = 1.obs;
  var userDetails = <UserDetailsModel>[].obs;
  // var userVideos = <Video>[].obs;
  var videoList = <Video>[].obs;
  var allVideos = <AllVideosData>[].obs;
  var desgnationList = <DesignationModel>[].obs;
  var selectedDesignation = 3.obs;
  var videoLength = "".obs;
  var allMagngerList = <Datum>[].obs;
  var allEmployeesList = <Datum>[].obs;
  late VideoPlayerController playVideosController;

  final createManagerFormKey = GlobalKey<FormState>();
  final createStaffFormKey = GlobalKey<FormState>();

  User? employeeDetails;
  RxString selectedDate = ''.obs;
  void updateSelectedDate(String date) {
    selectedDate.value = date;
  }

  RxBool isLoadingForEmployeeDetails = false.obs;
  void SetisLoadingForEmployeeDetails(bool value) {
    isLoadingForEmployeeDetails.value = value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoController.dispose();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    isLoading.value = false;
    _scheduleSetup();
    _updateDateAutomatically();
    var userDetails = await storageProvider.readUserModel();
    print(userDetails.photoUrl);
    user.assign(userDetails);
    await getAllEmployees();
    await getAllVideos();
    await getEmplyeesDetails();
    await getDesignation();
    await getAllMnager();
  }

  getAllEmployees() async {
    var status = await apIsProvider.fetchAllEmployees(user[0].token);
    if (status != null) {
      allEmployeesList.assignAll(status.data!.toList());
    } else {}
  }

  getUserName(id, index) {
    var userName = allEmployeesList
        .where((p0) => p0.id!.toInt() == allVideos[index].user!.toInt())
        .first;
    var fullName = "${userName.firstName} ${userName.lastName}";
    return fullName;
  }

  getAllVideos() async {
    isLoading.value = true;
    var status = await apIsProvider.fetchAllVideos(user[0].token);

    allVideos.assignAll(status!.data!.toList());
    allVideos.sort((a, b) => b.id!.compareTo(a.id!));
    videoList.sort((a, b) => b.id!.compareTo(a.id!));
    print("All Videos-=-=-${allVideos.length}");

    if (status != null) {
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  // Department List
  var selectedDepartments = "department 1".obs;
  List<DropdownMenuItem<String>> get departmentItems => const [
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
  List<DropdownMenuItem<String>> get genderItems => const [
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
  var selectedRole = "Manager".obs;
  List<DropdownMenuItem<String>> get roleItems => const [
        DropdownMenuItem<String>(
          value: "Manager",
          child: Text("Manager"),
        ),
        DropdownMenuItem<String>(
          value: "Staff",
          child: Text("Staff"),
        ),
      ];

  Future getDesignation() async {
    var status = await apIsProvider.getDesignationList(user[0].token);
    if (status!.length.toInt() != 0) {
      desgnationList.assignAll(status);
      selectedDesignation.value = desgnationList[0].id!.toInt();

      print("designationList --=---=-$desgnationList");
    }
  }

  void creatManager() async {
    isLoading.value = true;
    var status = await apIsProvider.createNewManager(
        email.text,
        password.text,
        firstName.text,
        lastName.text,
        selectedGender,
        selectedDate,
        selectedRole,
        selectedDepartments,
        selectedDesignation.toInt(),
        addressController.text,
        mobileNumberController.text);
    if (status) {
      email.clear();
      password.clear();
      firstName.clear();
      lastName.clear();
      mobileNumberController.clear();
      await getEmplyeesDetails();
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  void createStaff() async {
    isLoading.value = true;
    var status = await apIsProvider.createNewStaff(
        email.text,
        password.text,
        firstName.text,
        lastName.text,
        addressController.text,
        mobileNumberController.text,
        selectedGender,
        selectedRole,
        selecteMangerID,
        selectedDesignation.toInt());
    if (status) {
      email.clear();
      password.clear();
      firstName.clear();
      lastName.clear();
      mobileNumberController.clear();
      addressController.clear();
      await getEmplyeesDetails();
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  getAllMnager() async {
    isLoading.value = true;
    var employees = await apIsProvider.fetchAllManagers(user[0].token);

    AllEmployeesModel? employeeo;

    if (employees.data!.length == 0) {
      EasyLoading.showSuccess(
        "Employees not found",
      );
    } else {
      employeeo = employees;
      allMagngerList.assignAll(employeeo.data!);

      // print("allEmployeesList[0].email------${allEmployeesList[0].email}");
    }

    isLoading.value = false;
  }

  getEmplyeesDetails() async {
    SetisLoadingForEmployeeDetails(true);
    printInfo(info: "employeee details");
    try {
      final res = await apIsProvider.fetchAllEmployees(user[0].token);
      final list = res!.data!;
      printInfo(info: "employee length -=--=--=--${list.length}");
      totalUser.value = list.length;
      final presentEmplyeeList = list.where(
        (element) => element.status == "In Office",
      );
      print("presentEmplyeeList-----${presentEmplyeeList.length}");
      totalPresent.value = presentEmplyeeList.length;
      totalAbsents.value = totalUser.value - totalPresent.value;
      SetisLoadingForEmployeeDetails(false);
    } catch (e) {
      print(e);
      SetisLoadingForEmployeeDetails(false);
    }
  }

  getAllPresentUsers() async {
    SetisLoadingForEmployeeDetails(true);
    var userDetailsController = await Get.put(UsersController());
    printInfo(info: "employeee details");
    try {
      final res = await apIsProvider.fetchAllEmployees(user[0].token);
      final list = res!.data!;
      printInfo(info: "employee length -=--=--=--${list.length}");
      totalUser.value = list.length;
      final presentEmplyeeList = list.where(
        (element) => element.status == "In Office",
      );
      userDetailsController.allEmployeesList.assignAll(presentEmplyeeList);

      SetisLoadingForEmployeeDetails(false);
    } catch (e) {
      print(e);
      SetisLoadingForEmployeeDetails(false);
    }
  }

  getAllAbsentUsers() async {
    SetisLoadingForEmployeeDetails(true);
    var userDetailsController = await Get.put(UsersController());
    printInfo(info: "employeee details");
    try {
      final res = await apIsProvider.fetchAllEmployees(user[0].token);
      final list = res!.data!;
      printInfo(info: "employee length -=--=--=--${list.length}");
      totalUser.value = list.length;
      final presentEmplyeeList = list.where(
        (element) => element.status == "Not In Office",
      );
      userDetailsController.allEmployeesList.assignAll(presentEmplyeeList);

      SetisLoadingForEmployeeDetails(false);
    } catch (e) {
      print(e);
      SetisLoadingForEmployeeDetails(false);
    }
  }

  getAllEmployeesList() async {
    var userDetailsController = await Get.put(UsersController());
    var status = await apIsProvider.fetchAllEmployees(user[0].token);
    if (status != null) {
      userDetailsController.allEmployeesList.assignAll(status.data!.toList());
    } else {}
  }

  void fetchUserDetails(id) async {
    isLoading.value = true;
    var userDetails = await apIsProvider.fetchUserDetails(user[0].token, id);

    isLoading.value = false;
  }

  // SetUp Morning, Afternoon and Evening.
  RxString setupMessage = ''.obs;
  void _scheduleSetup() {
    DateTime now = DateTime.now();
    if (_isMorning(now)) {
      setupMessage.value = 'Good Morning, ';
    } else if (_isAfternoon(now)) {
      setupMessage.value = 'Good Afternoon, ';
    } else {
      setupMessage.value = 'Good Evening, ';
    }
  }

  bool _isMorning(DateTime time) {
    return time.hour >= 6 && time.hour < 12;
  }

  bool _isAfternoon(DateTime time) {
    return time.hour >= 12 && time.hour < 17;
  }

  // SetUp Date
  Rx<DateTime> currentDate = DateTime.now().obs;
  void _updateDateAutomatically() {
    // Periodically update the date (e.g., every second)
    Future.delayed(Duration(seconds: 1), () {
      currentDate.value = DateTime.now();
      _updateDateAutomatically();
    });
  }
}
