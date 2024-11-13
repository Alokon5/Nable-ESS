// ignore_for_file: unused_local_variable

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/leaveModels/leaveListModel.dart';

import '../../../data/models/allUserDocList.dart';
import '../../../data/models/dateTime.dart';
import '../../../data/models/designationModel/designationModel.dart';
import '../../../data/models/leaveModels/leaveTypeModel.dart';
import '../../../data/models/userDetailsModel.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/storage_provider.dart';
import '../videos/controller.dart';

class ManagersDocController extends GetxController {
  StorageProvider storageProvider = StorageProvider();
  APIsProvider apIsProvider = APIsProvider();

  var user = <UserModel>[].obs;

  // var documents = <Document>[].obs;
  var documents = <AllDocList>[].obs;

  var desgnationList = <DesignationModel>[].obs;
  var joinedDate = ''.obs;
  var designationName = "".obs;
  var docIndex = ''.obs;
  var currentIndex = 0.obs;

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

  var leaveType = "".obs;
  var token = "".obs;
  //widget
  var selecteLeaveType = 1.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var userDetails = await storageProvider.readUserModel();
    token.value = userDetails.token.toString();
    user.assign(userDetails);

    // await updateDetails();
    getFirstUser();
  }

  var uploadingState = "Loading...".obs;

  // Current Month Attendance Details

  // Current Month Leave Approved Details

  // logOut

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
      String truncatedName = fileName.substring(0, maxLength);
      return "${truncatedName}.pdf";
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

  Future uploadDocumentViaUserId(id, userId) async {
    printInfo(info: "user id =====${id},Document id========${userId}");
    if (pdfPath.value != '') {
      if (uploadDocFormKey.currentState!.validate()) {
        pdfUploading.value = true;
        uploadingState.value = "Loading...";
        var uploadingStatus = await apIsProvider.uploadDocuments(
            user[0].token, pdfPath, documentNameController.text, id);
        if (uploadingStatus == true) {
          await getDocument(userId);

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

  Future updateDocument(id, userId) async {
    if (pdfPath.value != '') {
      printInfo(
          info:
              "user id -=-=-=-=-=- after updatign--===========${id},and user id =====${userId}");
      if (uploadDocFormKey.currentState!.validate()) {
        uploadingState.value = "Loading...";
        pdfUploading.value = true;
        var uploadingStatus = await apIsProvider.updateDocuments(
            user[0].token, pdfPath, documentNameController.text, int.parse(id));
        pdfUploading.value = false;
        if (uploadingStatus == true) {
          await getDocument(userId);
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

  Future updateDocumentOfThis(id, userId) async {
    if (pdfPath.value != '') {
      printInfo(
          info:
              "user id -=-=-=-=-=- after updatign--===========${id},and user id =====${userId}");
      if (uploadDocFormKey.currentState!.validate()) {
        uploadingState.value = "Loading...";
        pdfUploading.value = true;
        var uploadingStatus = await apIsProvider.updateDocuments(
            user[0].token, pdfPath, documentNameController.text, id);
        pdfUploading.value = false;
        if (uploadingStatus == true) {
          await getDocument(userId);
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

  Future deleteDocument(id, userId) async {
    printInfo(
        info:
            "This is delete functions========================${id},user Id ========= ${userId}");
    pdfUploading.value = true;
    var uploadingStatus = await apIsProvider.deleteDocuments(user[0].token, id);

    printInfo(
        info: "response is true or not=================${uploadingStatus}");
    if (uploadingStatus == true) {
      await getDocument(userId);
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
    printInfo(
        info:
            "user Id-=-=-=-=-=-=${user[0].id},token-=-=updateDetails-=-=-=-=-${user[0].token}");
    var document = await apIsProvider.fetchDocument(user[0].token, user[0].id);

    documents.assignAll(document.toList());

    printInfo(info: "length of document -=-=-=-=--===${documents.length}");

    // firstNameController.text = userDetails.user!.firstName.toString();
    // lastNameController.text = userDetails.user!.lastName.toString();
    // addressController.text = userDetails.user!.address.toString();

    // phoneNumberController.text = userDetails.user!.phoneNumber.toString();
    // // getDesignationNameViaId(userDetails.user!.designation!.toInt());
    // var dateJoin =
    //     await dateTimeFormator(userDetails.user!.joinedDate.toString());

    // joinedDate.value = dateJoin.date.toString();

    // isLoading.value = false;
    // printInfo(info: 'document=======${documents.length}');

    // print("check in ------${userDetails.checkIn!.length}");
    // print("userDetails ------${userDetails.user!.joinedDate}");
    // print("userDetails of first name ------${userDetails.user!.firstName}");
  }

  getDocument(userId) async {
    uploadingState.value = "Loading...";
    // printInfo(
    //     info:
    //         "This is get Document Function User Id ==============${userId} backend door value==${token}");
    var document = await apIsProvider.fetchDocument(token.toString(), userId);

    documents.assignAll(document);
    if (documents.length == 0) {
      uploadingState.value = "No Document!";
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

  getFirstUser() {
    documents.clear();
    final staffListController = Get.put(StaffVideocontroller());
    var index = staffListController.selectedListTile.value = 0;

    if (staffListController.staffsListed.length != 0) {
      staffListController.selectedListTile.value = 0;
      staffListController.staffName.value =
          staffListController.staffsListed[index].firstName.toString();

      staffListController.staffProfilePhoto.value =
          staffListController.staffsListed[index].profileImage.toString();

      staffListController.staffEmail.value =
          staffListController.staffsListed[index].email.toString();
      staffListController.staffId.value =
          staffListController.staffsListed[index].id.toString();
      getDocument(staffListController.staffsListed[index].id);
    }
  }
}
