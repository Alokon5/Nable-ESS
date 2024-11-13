import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/allEmployeesModel.dart';
import 'package:nable_ess/app/data/models/userDetailsModel.dart';
import 'package:nable_ess/app/modules/management/usersDetails/controller.dart';

import '../../../data/models/allUserDocList.dart';
import '../../../data/models/dateTime.dart';
import '../../../data/models/requiestedLeaveModel/requiestedLeaveModel.dart';
import '../../../data/models/userBasedDoc.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/storage_provider.dart';
import '../../../routes/route.dart';

class ProfileManagementController extends GetxController {
  // Gender list
  var selectedGender = "Male".obs;

  StorageProvider storageProvider = StorageProvider();
  APIsProvider apIsProvider = APIsProvider();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController gender = TextEditingController();

  RxInt totalUser = 0.obs;
  RxInt totalPresent = 0.obs;
  RxInt totalAbsents = 0.obs;

  var requestedLeave = <RequestedLeaveModel>[].obs;
  var documentList = <AllDocList>[].obs;
  var tempDoc = <AllDocList>[].obs;
  var matchedDocList = <AllDocList>[].obs;
  var finalDocList = <UserBasedDocModel>[].obs;
  var LateEarlyData = <LateEary>[].obs;

  var user = <UserModel>[].obs;
  var allEmployeesList = <Datum>[].obs;
  UserModel? userModel;
  var newRequestList = <RequestedLeaveModel>[].obs;

  var isLoading = false.obs;
  void setIsLoading(bool value) {
    isLoading.value = value;
  }

  var fullName = "".obs;
  var profileImage = "".obs;
  void onInit() async {
    // TODO: implement onInit
    setIsLoading(true);
    await fetchUserDetails();
    await getDocument();
    isLoading.value = false;
    super.onInit();
    await getAllEmployees();
    await getEmplyeesDetails();
    setIsLoading(false);
    await getAllRequestedLeave();
    await updateDetails();
  }

  Future fetchUserDetails() async {
    setIsLoading(true);
    userModel = await storageProvider.readUserModel();
    user.assign(userModel!);
    // print("user[0].displayName----------${user[0].displayName}");
    setIsLoading(false);
  }

  getEmplyeesDetails() async {
    SetisLoadingForEmployeeDetails(true);
    // printInfo(info: "employeee details");
    try {
      final res = await apIsProvider.fetchAllEmployees(user[0].token);
      final list = res!.data!;
      printInfo(info: "employee length -=--=--=--${list.length}");
      totalUser.value = list.length;
      final presentEmplyeeList = list.where(
        (element) => element.status == "In Office",
      );
      totalPresent.value = presentEmplyeeList.length;
      totalAbsents.value = totalUser.value - totalPresent.value;
      SetisLoadingForEmployeeDetails(false);
    } catch (e) {
      // print(e);
      SetisLoadingForEmployeeDetails(false);
    }
  }

  getAllEmployees() async {
    var status = await apIsProvider.fetchAllEmployees(user[0].token);
    if (status != null) {
      allEmployeesList.assignAll(status.data!.toList());
    } else {}
  }

  RxBool isLoadingForEmployeeDetails = false.obs;
  void SetisLoadingForEmployeeDetails(bool value) {
    isLoadingForEmployeeDetails.value = value;
  }

  requestApprovelApi(id) async {
    isLoading.value = true;
    var status = await apIsProvider.requestApprovelApi(user[0].token, id);
    if (status == true) {
      await getAllRequestedLeave();
      await updateSeenStatus(id);
      isLoading.value = false;
      // Get.back();
      Get.snackbar("Approved", "Successfull approved request");
      // print("list of requested----${list}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  requestApprovelApiFrLeaveDetails(id) async {
    isLoading.value = true;
    var status = await apIsProvider.requestApprovelApi(user[0].token, id);
    if (status == true) {
      await getAllRequestedLeave();
      Get.back();
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

    var status = await apIsProvider.seenApi(user[0].token, id);
    if (status == true) {
      await getAllRequestedLeave();
      isLoading.value = false;
      // Get.snackbar("Approved", "Successfull approved request");
      // print("list of requested----${list}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  requestDeclineApi(id) async {
    isLoading.value = true;
    var status = await apIsProvider.requestDeclineApi(user[0].token, id);
    if (status == true) {
      print("status-----$status");
      await getAllRequestedLeave();
      await updateSeenStatus(id);
      isLoading.value = false;
      Get.snackbar("Declined", "Successfull declined request");
      // Get.back();
      // print("list of requested----${list}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  requestDeclineApiFrLeaveDetails(id) async {
    isLoading.value = true;
    var status = await apIsProvider.requestDeclineApi(user[0].token, id);
    print(status);
    if (status == true) {
      await getAllRequestedLeave();
      Get.back();
      isLoading.value = false;
      Get.snackbar("Declined", "Successfull declined request");
      // print("list of requested----${list}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  getDocument() async {
    // documentList.clear();
    var list = await apIsProvider.getDocList(user[0].token);

    if (list.length.toInt() != 0) {
      tempDoc.assignAll(list);

      Set<int> uniqueIds = Set<int>();

      matchedDocList.clear();
      documentList.clear();

      tempDoc.forEach((doc) {
        printInfo(info: "document==========${doc}");
        if (doc.user != null) {
          var id = doc.user!.id;
          if (!uniqueIds.contains(id)) {
            uniqueIds.add(id!.toInt());
            documentList.add(doc);
          } else {
            matchedDocList.add(doc);
            // printInfo(
            //     info: "!uniqueIds.contains(id)=======${!uniqueIds.contains(id)}");
            // printInfo(info: "matched ID object =======${doc}");
          }
        }
      });

      // documentList.assignAll(uniqueUsersDoc);
      createDoc();
      // print("list of requested----${list}");

      // printInfo(info: 'length of documents-=-=-=-=-=---${documentList.length}');
    } else {}
  }

  createDoc() {
    finalDocList.clear();
    for (int i = 0; i < documentList.length; i++) {
      // printInfo(
      //     info: "document object details -=-=-=---${documentList[i].toJson()}");
      List<DocList> tempList = [];
      var docObj = DocList(
          id: documentList[i].id,
          docName: documentList[i].documentName,
          documentUrl: documentList[i].document,
          createdAt: documentList[i].createdAt.toString());
      var userDetails = UserBasedDocModel(
        userFirstName: documentList[i].user!.firstName,
        userLastName: documentList[i].user!.lastName,
        id: documentList[i].user!.id,
        createdAt: documentList[i].createdAt.toString(),
        profileImage: documentList[i].user!.profileImage,
        docList: tempList,
      );

      tempList.add(docObj);

      finalDocList.add(userDetails);
    }

    // printInfo(
    //     info:
    //         "length of document hksofhsdfhf sfhsfhsfh--=-=-=---${finalDocList[0].docList![0].documentUrl}");
    madeDoc();
  }

  madeDoc() {
    int i = 0;
    for (i; i < finalDocList.length; i++) {
      int j = 0;
      for (j; j < matchedDocList.length; j++) {
        if (finalDocList[i].id == matchedDocList[j].user!.id) {
          finalDocList[i].docList!.add(DocList(
              id: matchedDocList[j].id,
              docName: matchedDocList[j].documentName,
              documentUrl: matchedDocList[j].document,
              createdAt: matchedDocList[j].createdAt.toString()));
        }
      }
    }
  }

  getAllRequestedLeave() async {
    newRequestList.clear();
    var list = await apIsProvider.getAllRequestedLeave(user[0].token);

    if (list!.length.toInt() != 0) {
      requestedLeave.assignAll(list);
      for (int i = 0; i < requestedLeave.length; i++) {
        if (requestedLeave[i].seen == false) {
          var object = requestedLeave.removeAt(i);
          requestedLeave.insert(0, object);
          newRequestList.add(object);
        } else if (requestedLeave[i].status == "Pending") {
          var object = requestedLeave.removeAt(i);
          requestedLeave.insert(0, object);
        }
      }
      // print("list of requested----${list}");
    } else {}
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

  // Future<void> getUserDetails() async {
  //   userModel = await storageProvider.readUserModel();
  //   // firstName.text = user[0].firstName!;
  //   // firstName.text = userModel!.firstName!.toString();
  //   // lastName.text = userModel!.lastName!.toString();
  // }

  updateDetails() async {
    isLoading.value = true;

    var userDetails =
        await apIsProvider.fetchUserDetails(user[0].token, user[0].id);

    firstName.text = userDetails.user!.firstName.toString();
    lastName.text = userDetails.user!.lastName.toString();
    selectedGender.value = userDetails.user!.gender.toString();
    fullName.value =
        "${userDetails.user!.firstName.toString()} ${userDetails.user!.lastName.toString()}";
    profileImage.value = userDetails.user!.profileImage.toString();

    isLoading.value = false;

    print("userDetails of first name ------${userDetails.user!.firstName}");
  }

  // List<DropdownMenuItem<String>> get genderItems => [
  //       DropdownMenuItem<String>(
  //         value: "Male",
  //         child: Text("Male"),
  //       ),
  //       DropdownMenuItem<String>(
  //         value: "Female",
  //         child: Text("Female"),
  //       ),
  //     ];
  // getLateEarlyData()async{
  //   var listLateEarly = await apIsProvider.
  // }

  final ImagePicker _imagePicker = ImagePicker();
  Rxn<XFile?> selectedImage = Rxn<XFile?>();
  var selectedImagePath = ''.obs;

  Future<void> pickImageFromGallery() async {
    // ignore: unused_local_variable
    final pickedImage = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);
    selectedImagePath.value = pickedImage!.path;
  }

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

  dateTimeFormator(dateTimeStr) {
    if (dateTimeStr != null) {
      DateTime dateTime = DateTime.parse(dateTimeStr == null
          ? "2023-07-04T15:32:01.593995Z"
          : dateTimeStr.toString());
      // print(dateTimeStr);

      String formattedTime = DateFormat('h:mm a').format(dateTime);
      String date = "${DateFormat('dd-MMM-yyyy').format(dateTime)}";
      // print("date -=--=-$date");
      // print("time -=--=-$formattedTime");
      var formatedDateTime = DateTimeModel(date: date, time: formattedTime);
      return formatedDateTime;
    } else {
      return DateTimeModel(date: "No Date", time: "No Time");
    }
  }

  void editProfile() async {
    isLoading.value = true;
    var userModel = await storageProvider.readUserModel();
    final success = await apIsProvider.editProfile(
        selectedImagePath.isEmpty
            ? selectedImage.value
            : selectedImagePath.value,
        userModel.id,
        userModel.token,
        firstName.text == '' ? userModel.firstName : firstName.text,
        lastName.text == '' ? userModel.lastName : lastName.text,
        gender.text,
        '',
        "");
    if (success) {
      await fetchUserDetails();
      await updateDetails();
      onInit();
      Get.snackbar("Successful", "Profile updated successfully");
      isLoading.value = false;
    } else {
      isLoading.value = false;
      Get.snackbar("Faild", "Faild to Update profile!");
    }
    isLoading.value = false;
  }
}
