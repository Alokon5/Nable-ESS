// ignore_for_file: unused_local_variable, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/userDetailsModel.dart';
import 'package:nable_ess/app/routes/route.dart';

import '../../../data/models/dateTime.dart';
import '../../../data/models/designationModel/designationModel.dart';
import '../../../data/models/leaveModels/leaveListModel.dart';
import '../../../data/models/requiestedLeaveModel/requiestedLeaveModel.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/storage_provider.dart';

class ProfileManagerController extends GetxController {
  StorageProvider storageProvider = StorageProvider();

  APIsProvider apIsProvider = APIsProvider();

  var user = <UserModel>[].obs;
  var checkInList = <CheckIn>[].obs;
  var chekOutList = <CheckOut>[].obs;
  var desgnationList = <DesignationModel>[].obs;
  var documents = <Document>[].obs;
  var leaveList = <LeaveListModel>[].obs;
  var requestedLeave = <RequestedLeaveModel>[].obs;
  var newlyRequestedList = <RequestedLeaveModel>[].obs;
  User? aboutUser;
  RxString attendance = '0'.obs;
  var firstNameCotroller = TextEditingController();
  var lastNameCotroller = TextEditingController();
  var addressCotroller = TextEditingController();
  var phoneNumberCotroller = TextEditingController();
  final edtiProfileFormKey = GlobalKey<FormState>();
  var leaveApproved = "0".obs;
  var profileImage = "".obs;
  var showBadge = false.obs;
  var lateEarlyFormKey = GlobalKey<FormState>();
  var lateEresonController = TextEditingController();
  var lEdateController = TextEditingController();
  var lEtimeController = TextEditingController();
  List<DropdownMenuItem<String>> leaveTypeList = [
    DropdownMenuItem<String>(
      value: "d",
      child: Text("ds"),
    )
  ];

  var isLoading = false.obs;
  var editLoading = false.obs;

  void onInit() async {
    // TODO: implement onInit
    print("this is on init running");

    isLoading.value = false;
    await fetchUserDetails();

    print("userDetails json ${user.toJson().toString()}");
    await updateDetails();
    await getDesignation();
    await getCurrentMothAttendence();
    await getLeaveList();
    await getRequestedLeave();

    super.onInit();
  }

  Future fetchUserDetails() async {
    isLoading.value = true;
    var userModel = await storageProvider.readUserModel();
    user.assign(userModel);
    isLoading.value = false;
  }

  getRequestedLeave() async {
    newlyRequestedList.clear();
    var list = await apIsProvider.getRequestedLeave(user[0].token);

    if (list!.length.toInt() != 0) {
      requestedLeave.assignAll(list);
      for (int i = 0; i < requestedLeave.length; i++) {
        if (requestedLeave[i].seen == false) {
          var object = requestedLeave.removeAt(i);
          requestedLeave.insert(0, object);
          newlyRequestedList.add(object);
          print("showBadge--=-=---=-${showBadge}");
        }
      }
      // print("list of requested----${list}");
    } else {}
  }

  void logOut() async {
    var logoutBool = await apIsProvider.logoutApi(user[0].token);
    if (logoutBool == true) {
      final GetStorage storage = GetStorage();
      await storage.erase();
      // Clear all stored values in Get storage
      print('Storage cleared');
      Get.toNamed(AppRoutes.splashScreen);
    } else {
      EasyLoading.showError("Failed to log out !");
    }
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

  updateDetails() async {
    isLoading.value = true;

    var userDetails =
        await apIsProvider.fetchUserDetails(user[0].token, user[0].id);
    aboutUser = userDetails.user;
    checkInList.assignAll(userDetails.checkIn!.toList());
    chekOutList.assignAll(userDetails.checkOut!.toList());

    firstNameCotroller.text = userDetails.user!.firstName.toString();
    lastNameCotroller.text = userDetails.user!.lastName.toString();
    addressCotroller.text = userDetails.user!.address.toString();
    selectedGender.value = userDetails.user!.gender.toString();
    phoneNumberCotroller.text = userDetails.user!.phoneNumber.toString();
    profileImage.value = userDetails.user!.profileImage.toString();

    // Sort CheckIn and CheckOut
    checkInList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    chekOutList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    isLoading.value = false;

    print("userDetails ------${aboutUser!.toJson()}");
    print("userDetails of first name ------${userDetails.user!.firstName}");
  }

  Future getCurrentMothAttendence() async {
    var currentMonth = DateFormat('MM').format(DateTime.now()).toString();
    var currentMonthAttendanceList = checkInList.where((element) {
      return DateFormat('MM').format(DateTime.parse(element.createdAt!)) ==
          currentMonth;
    });
    print(checkInList.length);
    attendance.value = currentMonthAttendanceList.length.toString();
  }

  dateTimeFormator(dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);

    String formattedTime = DateFormat('h:mm a').format(dateTime);

    String date =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    print("date -=--=-$date");
    print("time -=--=-$formattedTime");
    DateTimeModel formatedDateTime =
        DateTimeModel(date: date, time: formattedTime);
    return formatedDateTime;
  }

  var selectedGender = "Male".obs;

  final ImagePicker _imagePicker = ImagePicker();
  Rxn<XFile?> selectedImage = Rxn<XFile?>();

  String? imagePath;

  pickImageFromGallery() async {
    print("yha hua print");
    // ignore: unused_local_variable
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    // print("picked Image --=-=-=-=-${pickedImage!.path}");
    selectedImage.value = pickedImage;
    imagePath = pickedImage!.path;
  }

  editManagerProfile() async {
    editLoading.value = true;
    var status = await apIsProvider.editProfile(
        imagePath,
        user[0].id,
        user[0].token,
        firstNameCotroller.text,
        lastNameCotroller.text,
        selectedGender,
        phoneNumberCotroller.text,
        addressCotroller.text);
    print("status-------${status}");
    if (status == true) {
      await updateDetails();
      await fetchUserDetails();
      editLoading.value = false;

      Get.snackbar("Successfully", "Profile updated successfully");
    } else {
      Get.snackbar("Faild", "Profile updated faild");
      editLoading.value = false;
    }

    editLoading.value = false;
  }

  getLeaveList() async {
    print("getLeaveList");
    var list = await apIsProvider.getLeaveList(user[0].token);
    if (list!.length.toInt() != 0) {
      leaveList.assignAll(list);
      await getCurrentMonthLeaveApproved();
      print("leaveList -----${leaveList}");
    } else {}
  }

  Future getCurrentMonthLeaveApproved() async {
    var currentMonthLeaveApprovedList =
        leaveList.where((element) => element.status == "Approved");
    // leaveApproved.value = currentMonthLeaveApprovedList.length.toString();

    var currentMonth = DateFormat('MM').format(DateTime.now()).toString();
    var currentMonthleaveList = currentMonthLeaveApprovedList.where((element) {
      return DateFormat('MM').format(DateTime.parse(element.created_date!)) ==
          currentMonth;
    });
    // currentMonthLeaveApprovedList.length;
    leaveApproved.value = currentMonthleaveList.length.toString();

    print(
        "leaveApproved.value -=-=-=-=-=-=-=-=-=-=-=- ${currentMonthLeaveApprovedList.length}");
  }

  // Future<void> _selectTime(BuildContext context) async {
  //   TimeOfDay picked = await showTimePicker(
  //     context: context,
  //     initialTime: _selectedTime,
  //   );
  //   if (picked != null && picked != _selectedTime) {
  //     setState(() {
  //       _selectedTime = picked;
  //     });
  //   }
  // }

  String extractMonth(String date) {
    DateTime parsedDate = DateTime.parse(date);
    int month = parsedDate.month;
    return month.toString();
  }
}
