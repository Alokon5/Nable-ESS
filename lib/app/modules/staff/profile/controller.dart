// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/leaveModels/lateEarlyModel.dart';
import 'package:nable_ess/app/data/models/leaveModels/leaveListModel.dart';
import 'package:nable_ess/app/data/models/staff_salary_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/allUserDocList.dart';
import '../../../data/models/dateTime.dart';
import '../../../data/models/designationModel/designationModel.dart';
import '../../../data/models/leaveModels/leaveTypeModel.dart';
import '../../../data/models/userDetailsModel.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/storage_provider.dart';
import '../../../routes/route.dart';

class StaffProfileController extends GetxController {
  StorageProvider storageProvider = StorageProvider();
  APIsProvider apIsProvider = APIsProvider();
  var salaryList = <StaffSalaryModel>[].obs;
  var lateEarlyListNew = <LateEarlyModel>[].obs;
  var user = <UserModel>[].obs;
  var checkInList = <CheckIn>[].obs;
  var chekOutList = <CheckOut>[].obs;
  var lateEarlyList = <LateEary>[].obs;
  var lateEarlyListManger = <LateEarlyModel>[].obs;
  // var documents = <Document>[].obs;
  var documents = <AllDocList>[].obs;
  var desgnationList = <DesignationModel>[].obs;
  var joinedDate = ''.obs;
  var designationName = "".obs;
  var docIndex = ''.obs;
  var errorMessage = ''.obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController documentNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final editProfileStaffFormKey = GlobalKey<FormState>();
  final uploadDocFormKey = GlobalKey<FormState>();
  final lateEarlyFormKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var leaveTypeList = <LeaveTypeModel>[].obs;
  var leaveList = <LeaveListModel>[].obs;
  RxString attendance = '0'.obs;
  RxString leaveApproved = '0'.obs;
  var documentData = 'Loading...'.obs;

  TextEditingController leaveTitleController = TextEditingController();
  TextEditingController leaveDescriptionController = TextEditingController();
  TextEditingController dateFromController = TextEditingController();
  TextEditingController dateToController = TextEditingController();

  TextEditingController lateEarlyDateController = TextEditingController();
  TextEditingController lateEarlyTimeController = TextEditingController();
  TextEditingController lateEarlyReasonController = TextEditingController();
  TextEditingController lateEarlyDropdownController = TextEditingController();

  var leaveType = "".obs;
  //widget
  var selecteLeaveType = 1.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var userDetails = await storageProvider.readUserModel();
    user.assign(userDetails);
    await getLeaveTypeList();
    await getLeaveList();
    await getDesignation();
    await updateDetails();
    await getCurrentMonthAttendence();
    await getCurrentMonthLeaveApproved();
    await getDocument();
    await fetchSalaryData();
   await fetchLateEarlyData();
   await fetchLateEarlyDataManger();
  }


requestDeclineApi(id) async {
    isLoading.value = true;
    var status = await apIsProvider.requestLateDeclineApi(user[0].token, id);
    if (status == true) {
       await fetchLateEarlyData();
      // await getRequestedLeave();
      await updateSeenStatus(id);
      isLoading.value = false;
      Get.snackbar("Declined", "Successfull declined request");
      // print("list of requested----${list}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

requestApprovelApi(id) async {
    isLoading.value = true;
    var status = await apIsProvider.requestLateApprovelApi(user[0].token, id);
    if (status == true) {
      await fetchLateEarlyData();
      await updateSeenStatus(id);
      isLoading.value = false;
      Get.snackbar("Approved", "Successfull approved request");
      // print("list of requested----${list}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  updateSeenStatus(id) async {
    
    isLoading.value = true;

    var status = await apIsProvider.seenLateApi(user[0].token, id);
    if (status == true) {
      await fetchLateEarlyData();
      isLoading.value = false;
      // Get.snackbar("Approved", "Successfull approved request");
      // print("list of requested----${list}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  // updateLateSeenStatus(id) async {
  //   isLoading.value = true;

  //   var status = await apIsProvider.seenLateApi(user[0].token, id);
  //   if (status == true) {
  //     await fetchLateEarlyData();
  //     isLoading.value = false;
  //     // Get.snackbar("Approved", "Successfull approved request");
  //     // print("list of requested----${list}");
  //   } else {
  //     isLoading.value = false;
  //   }
  //   isLoading.value = false;
  // }

  //late early controller
 Future<void> fetchLateEarlyData() async {
  print(" of late ealry");
   var token = user.isNotEmpty ? user[0].token : '';
    try {
      isLoading(true); // Set loading to true while fetching data
      final data = await apIsProvider.getLateEarlyData(token); 
      // Call the API provider function

      if (data.isEmpty) {
        errorMessage.value = "No data found";  // If the returned data is empty
      } else {
        lateEarlyListNew.value = data; // Update the observable list with the fetched data
        errorMessage.value = ""; // Clear any previous error message
      }
    } catch (e) {
      // Handle any errors during the fetch operation
      errorMessage.value = "Error: $e"; // Set error message
    } finally {
      isLoading(false); // Set loading to false once the data is fetched or an error occurs
    }
  }

  Future<void> fetchLateEarlyDataManger() async {
   var token = user.isNotEmpty ? user[0].token : '';
    try {
      isLoading(true); // Set loading to true while fetching data
      final data = await apIsProvider.getLateEarlyDataManger(token); // Call the API provider function

      if (data.isEmpty) {
        errorMessage.value = "No data found";  // If the returned data is empty
      } else {
        lateEarlyListManger.value = data; // Update the observable list with the fetched data
        errorMessage.value = ""; // Clear any previous error message
      }
    } catch (e) {
      // Handle any errors during the fetch operation
      errorMessage.value = "Error: $e"; // Set error message
    } finally {
      isLoading(false); // Set loading to false once the data is fetched or an error occurs
    }
  }


  getDocument() async {
    documentData.value = "Loading...";
    // printInfo(
    //     info:
    //         "This is get Document Function User Id ==============${userId} backend door value==${token}");
    var document = await apIsProvider.fetchDocument(user[0].token, user[0].id);

    documents.assignAll(document);
    if (documents.length == 0) {
      documentData.value = "No Document!";
    }
  }

  Future getLeaveList() async {
    print(" of late ealry");
    var list = await apIsProvider.getLeaveList(user[0].token);
    print(list);
    if (list!.length.toInt() != 0) {
      leaveList.assignAll(list);
      leaveList.sort((a, b) => b.fromDate!.compareTo(a.fromDate!));
      await getCurrentMonthLeaveApproved();
      print(list[0].leaveType!.id);
    } else {}
  }




  var lateEarlyLoading = false.obs;
 posteLateEarlyData() async {
  print("this controller value");
  print(lateEarlyDropdownController.text);
  printInfo(info: "here is calling");
  // print(selectedImage.value!.path);
  lateEarlyLoading.value = true;

  // Convert the 12-hour format time in lateEarlyTimeController to 24-hour format
  String time12Hour = lateEarlyTimeController.text; // Example: "02:30 PM"
  String time24Hour = convertTo24HourFormat(time12Hour);

  var status = await apIsProvider.postLateEarlyData(
    user[0].token,
    lateEarlyDropdownController.text,
    lateEarlyDateController.text,
    time24Hour, // Send the 24-hour format time here
    lateEarlyReasonController.text,
    selectedImage.value // Send image path if available
    // p
  );

  if (status == true) {
    lateEarlyDateController.clear();
    lateEarlyTimeController.clear();
    lateEarlyReasonController.clear();
    lateEarlyDropdownController.clear();
    lateEarlyLoading.value = false;
    selectedImage.value = null;
    updateDetails();
    Get.back();
  } else {
    lateEarlyLoading.value = false;
  }
}

// Helper function to convert 12-hour time to 24-hour format
String convertTo24HourFormat(String time12Hour) {
  final regex = RegExp(r'(\d+):(\d+)\s*(AM|PM)');
  final match = regex.firstMatch(time12Hour);

  if (match != null) {
    int hour = int.parse(match.group(1)!);
    int minute = int.parse(match.group(2)!);
    String amPm = match.group(3)!;

    if (amPm == 'PM' && hour != 12) {
      hour += 12;
    } else if (amPm == 'AM' && hour == 12) {
      hour = 0;
    }

    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
  } else {
    print("Invalid time format");
    return time12Hour; // Return original time if format is invalid
  }
}


  Future getLeaveTypeList() async {
    var list = await apIsProvider.getLeaveTypeList(user[0].token);
    leaveTypeList.clear();
    if (list.length.toInt() != 0) {
      for (var item in list) {
        leaveTypeList.add(LeaveTypeModel.fromJson(item));
      }
    }
  }

  // Current Month Attendance Details
  Future getCurrentMonthAttendence() async {
    List tempList = [];
    var currentMonth = DateFormat('MM').format(DateTime.now()).toString();
    var currentMonthAttendanceList = checkInList.where((element) {
      return DateFormat('MM').format(DateTime.parse(element.createdAt!)) ==
          currentMonth;
    });
    print(checkInList.length);
    attendance.value = currentMonthAttendanceList.length.toString();
  }

  // Current Month Leave Approved Details
  Future getCurrentMonthLeaveApproved() async {
    List tempList = [];
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
    print("leaveApproved.value -=-=-=-=-=-=-=-=-=-=-=- ${leaveApproved.value}");
  }

  Color getColorForLeaveStatus(String leaveStatus) {
    if (leaveStatus == "Approved") {
      return Colors.green;
    } else if (leaveStatus == "Pending") {
      return Colors.blue;
    } else if (leaveStatus == "Declined") {
      return Colors.red;
    } else {
      return Colors.black; // Default color
    }
  }

  // logOut
  void logOut() async {
    var logoutBool = await apIsProvider.logoutApi(user[0].token);
    if (logoutBool == true) {
      final GetStorage storage = GetStorage();
      await storage.erase(); // Clear all stored values in Get storage
      print('Storage cleared');
      Get.toNamed(AppRoutes.splashScreen);
    } else {
      EasyLoading.showError("Failed to log out !");
    }
  }

  var selectedGender = "Male".obs;

  void openSystemFile(String filePath, context) async {
    try {
      if (await canLaunch(filePath)) {
        await launch(filePath, forceWebView: false, forceSafariVC: false);
      } else {
        // If launching fails, attempt to read and display the content
        String fileContent = await readSystemFileContent(
          filePath,
        );
        showFileContentDialog(fileContent, context);
      }
    } catch (e) {
      print('Error opening system file: $e');
    }
  }

  Future<String> readSystemFileContent(String filePath) async {
    try {
      File file = File(filePath);
      String content = await file.readAsString(encoding: utf8);
      return content;
    } catch (e) {
      print('Error reading system file content: $e');
      return 'Unable to read file content.';
    }
  }

  void showFileContentDialog(String content, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('File Content'),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  final ImagePicker _imagePicker = ImagePicker();
  Rxn<XFile?> selectedImage = Rxn<XFile?>();

  String? imagePath;
  var imagePathVar = ''.obs;
  var imageName = ''.obs;

  pickImageFromGallery() async {
    final pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);

    selectedImage.value = pickedImage;
    if (pickedImage != null) {
      imagePath = pickedImage.path;
      imagePathVar.value = pickedImage.path;
      imageName.value = pickedImage.name.toString();
    }
  }

  var pdfPath = ''.obs;
  var pdfName = ''.obs;
  var pdfUploading = false.obs;
  Future<void> pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        String fileName = (result.files.single.name);
        printInfo(
            info:
                'file name ------${fileName} length of name ::::::${fileName.length}');
        pdfName.value = truncateFileName(fileName, 14);

        pdfPath.value = result.files.single.path.toString();
      } else {
        EasyLoading.showSuccess("File Not found");
      }
    } on PlatformException catch (e) {
      print('Error picking PDF: $e');
    }
  }

  String truncateFileName(String fileName, int maxLength) {
    if (fileName.length <= maxLength) {
      return fileName; // Return the original file name if it's already within the limit
    } else {
      // Extract the first 10 characters
      // String truncatedName = fileName.substring(0, maxLength);
      // return "${truncatedName}.pdf";

      String fileNameWithoutExtension = fileName.split('.').first;

      // Extract the file extension
      String fileExtension = fileName.split('.').last;

      // Calculate the remaining characters for the name (after considering the extension)
      int remainingCharacters = maxLength -
          (fileExtension.length + 1); // +1 for the dot before the extension

      // Truncate the name, leaving enough space for the extension
      String truncatedName =
          fileNameWithoutExtension.substring(0, remainingCharacters);

      // Combine the truncated name with the extension
      return "$truncatedName.$fileExtension";
    }
  }

  Future uploadDocument() async {
    if (pdfPath.value != '') {
      if (uploadDocFormKey.currentState!.validate()) {
        pdfUploading.value = true;
        var uploadingStatus = await apIsProvider.uploadDocuments(
            user[0].token, pdfPath, documentNameController.text, user[0].id);
        if (uploadingStatus == true) {
          await updateDetails();
          pdfName.value = '';
          pdfPath.value = '';
          documentNameController.text = '';
          pdfUploading.value = false;
          Get.back();
        } else {
          pdfUploading.value = false;
        }
      }
    } else {
      EasyLoading.showSuccess("Please select a pdf file");
    }
  }

  Future updateDocument(id) async {
    if (pdfPath.value != '') {
      if (uploadDocFormKey.currentState!.validate()) {
        pdfUploading.value = true;
        var uploadingStatus = await apIsProvider.updateDocuments(
            user[0].token, pdfPath, documentNameController.text, id);
        if (uploadingStatus == true) {
          await updateDetails();
          pdfName.value = '';
          pdfPath.value = '';
          documentNameController.text = '';
          pdfUploading.value = false;
          Get.back();
        } else {
          pdfUploading.value = false;
        }
      }
    } else {
      EasyLoading.showSuccess("Please select a pdf file");
    }
  }

  Future deleteDocument(id) async {
    pdfUploading.value = true;
    var uploadingStatus = await apIsProvider.deleteDocuments(user[0].token, id);
    if (uploadingStatus == true) {
      await updateDetails();
      pdfName.value = '';
      pdfPath.value = '';
      documentNameController.text = '';
      pdfUploading.value = false;
      Get.back();
    } else {
      pdfUploading.value = false;
    }
  }

  final List<String> menuItems = ['View', 'Delete', 'Update'];

  // Function to handle menu item selection
  void handleMenuItemClick(String item) {
    // Perform actions based on the selected menu item
    if (item == 'View') {
      // Handle the "View" action
      print('View clicked');
    } else if (item == 'Delete') {
      // Handle the "Delete" action
      print('Delete clicked');
    } else if (item == 'Update') {
      // Handle the "Update" action
      print('Update clicked');
    }
  }

  Future getDesignation() async {
    var status = await apIsProvider.getDesignationList(user[0].token);
    if (status!.length.toInt() != 0) {
      desgnationList.assignAll(status);
    }
  }

  getDesignationNameViaId(id) {
    var obj = desgnationList.where((p0) => p0.id == id).first;
    print("object -=-=-=-=-${obj.name}");
    designationName.value = obj.name.toString();
  }

  updateDetails() async {
    isLoading.value = true;
    // checkInList.clear();

    var userDetails =
        await apIsProvider.fetchUserDetails(user[0].token, user[0].id);
    checkInList.assignAll(userDetails.checkIn!.toList());
    chekOutList.assignAll(userDetails.checkOut!.toList());
    // documents.assignAll(userDetails.documents!.toList());
    lateEarlyList.assignAll(userDetails.lateEary!.toList());
    firstNameController.text = userDetails.user!.firstName.toString();
    lastNameController.text = userDetails.user!.lastName.toString();
    addressController.text = userDetails.user!.address.toString();
    selectedGender.value = userDetails.user!.gender.toString();
    phoneNumberController.text = userDetails.user!.phoneNumber.toString();
    getDesignationNameViaId(userDetails.user!.designation!.toInt());
    var dateJoin =
        await dateTimeFormator(userDetails.user!.joinedDate.toString());

    joinedDate.value = dateJoin.date.toString();

    isLoading.value = false;
    apIsProvider.printInfo(info: 'document=======${documents.length}');
    printInfo(
        info:
            'late Early :::::::::::::::::::::::::::::=======${lateEarlyList.length}');
    // print("check in ------${userDetails.checkIn!.length}");
    // print("userDetails ------${userDetails.user!.joinedDate}");
    // print("userDetails of first name ------${userDetails.user!.firstName}");
  }

 DateTimeModel dateTimeFormator(String? dateTimeStr) {
  if (dateTimeStr == null || dateTimeStr.isEmpty) {
    print("Error: dateTimeStr is null or empty.");
    return DateTimeModel(date: "Invalid Date", time: "Invalid Time");
  }

  try {
    // Parse the input string into a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeStr);

    // Format the time and date
    String formattedTime = DateFormat('h:mm a').format(dateTime);
    String date = DateFormat('dd-MMM-yyyy').format(dateTime);

    // Log for debugging
    print("Formatted Date: $date");
    print("Formatted Time: $formattedTime");

    // Return the formatted result as a DateTimeModel
    return DateTimeModel(date: date, time: formattedTime);
  } catch (e) {
    print("Error parsing dateTimeStr: $e");
    return DateTimeModel(date: "Invalid Date", time: "Invalid Time");
  }
}


  // Is on time or late history checkin checkout data
  bool isOnTimeCheckIn(DateTime checkInTime) {
    DateTime onTimeThreshold =
        DateTime(checkInTime.year, checkInTime.month, checkInTime.day, 9, 31);
    return checkInTime.isBefore(onTimeThreshold);
  }

  // Is on time or late history checkin checkout data
  bool isOnTimeCheckOut(DateTime checkInTime) {
    DateTime onTimeThreshold =
        DateTime(checkInTime.year, checkInTime.month, checkInTime.day, 18, 00);
    return checkInTime.isAfter(onTimeThreshold);
  }

  // Staff Profile Edit Function
  editStaffProfile() async {
    isLoading.value = true;
    var status = await apIsProvider.editProfile(
        imagePath,
        user[0].id,
        user[0].token,
        firstNameController.text,
        lastNameController.text,
        selectedGender,
        phoneNumberController.text,
        addressController.text);
    print("status-------${status}");
    if (status == true) {
      onInit();
      Get.snackbar("Successfully", "Profile updated successfully");
    } else {
      Get.snackbar("Faild", "Profile updated faild");
    }

    isLoading.value = false;
  }


  //salary controller 
  Future<void> fetchSalaryData() async {
     print("salary is runnig");

    var token = user.isNotEmpty ? user[0].token : '';

    // if (token.isEmpt) {
    //   errorMessage.value = 'No token found. Please login again.';
    //   isLoading(false);
    //   return;
    // }

    try {
    // isLoading(true);
      var fetchedData = await apIsProvider.getSalaryList(token);
   print("controller ${token}");
     print(fetchedData);
      if (fetchedData.isNotEmpty) {
        salaryList.value = fetchedData;  
        print("Salary list updated: "); 
      } else {
        print("No salary data found.");
        errorMessage.value = 'No salary data found';
      }
    } catch (e) {
      print("Error fetching salary data: $e");
      errorMessage.value = 'Error: $e'; 
    } finally {
      isLoading(false);  
    }
  }


  void applyForLeave() async {
  try {
    isLoading.value = true;

    File? attachment = selectedImage.value != null ? File(selectedImage.value!.path) : null;

    var applyStatus = await apIsProvider.applyLeave(
      user[0].token,
      leaveTitleController.text,
      leaveDescriptionController.text,
      dateFromController.text,
      dateToController.text,
      selecteLeaveType,
      attachment,
    );

    if (applyStatus == true) {
      // Show success message and navigate to leave history
      Get.snackbar("Success", "Requested for leave");
      getLeaveList();
      Get.offNamed(AppRoutes.leaveHistoryStaff);

      // Clear input fields only after a successful API call
      leaveTitleController.clear();
      leaveDescriptionController.clear();
      dateFromController.clear();
      dateToController.clear();
      selectedImage.value = null; // Clear selected image
    } else {
      Get.snackbar("Error", "Failed to apply for leave. Please try again.");
    }
  } catch (e) {
    print("Error in applyForLeave: $e");
    Get.snackbar("Error", "An unexpected error occurred.");
  } finally {
    isLoading.value = false; // Ensure loading state is reset
  }
}

}
