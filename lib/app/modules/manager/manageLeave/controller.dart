import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/leaveModels/leaveListModel.dart';
import 'package:nable_ess/app/data/models/leaveModels/leaveTypeModel.dart';
import 'package:nable_ess/app/data/models/requiestedLeaveModel/requiestedLeaveModel.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';

import '../../../data/models/dateTime.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/storage_provider.dart';

class LeaveController extends GetxController {
  APIsProvider apIsProvider = APIsProvider();

  var user = <UserModel>[].obs;
  var leaveTypeList = <LeaveTypeModel>[].obs;
  var leaveList = <LeaveListModel>[].obs;
  var requestedLeave = <RequestedLeaveModel>[].obs;
  // var filtered = <RequestedLeaveModel>[].obs;

  @override
  void onInit() async {
    isLoading.value = false;
    StorageProvider storageProvider = StorageProvider();

    var userDetails = await storageProvider.readUserModel();
    user.assign(userDetails);
    await getLeaveTypeList();
    await getLeaveList();
    await getRequestedLeave();
    super.onInit();
  }

//variables
  var isLoading = false.obs;
  var leaveFormKey = GlobalKey<FormState>();

  var leaveTitle = TextEditingController();
  var leaveDescription = TextEditingController();
  var dateFrom = TextEditingController();
  var dateTo = TextEditingController();

  var leaveType = "".obs;
  //widget
  var selecteLeaveType = 1.obs;

//methods

  getLeaveList() async {
    print("getLeaveList");
    var list = await apIsProvider.getLeaveList(user[0].token);
    if (list!.length.toInt() != 0) {
      leaveList.assignAll(list);
      leaveList.sort((a, b) => b.fromDate!.compareTo(a.fromDate!));
      print("leaveList -----${leaveList}");
    } else {}
  }

  requestApprovelApi(id) async {
    isLoading.value = true;
    var status = await apIsProvider.requestApprovelApi(user[0].token, id);
    if (status == true) {
      await getRequestedLeave();
      await updateSeenStatus(id);
      isLoading.value = false;
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
      await getRequestedLeave();
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
      await getRequestedLeave();
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
      await getRequestedLeave();
      await updateSeenStatus(id);
      isLoading.value = false;
      Get.snackbar("Declined", "Successfull declined request");
      // print("list of requested----${list}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  requestDeclineApiFrLeaveDetails(id) async {
    isLoading.value = true;
    var status = await apIsProvider.requestDeclineApi(user[0].token, id);
    if (status == true) {
      await getRequestedLeave();
      Get.back();
      isLoading.value = false;
      Get.snackbar("Declined", "Successfull declined request");
      // print("list of requested----${list}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  getRequestedLeave() async {
    var list = await apIsProvider.getRequestedLeave(user[0].token);

    if (list!.length.toInt() != 0) {
      requestedLeave.assignAll(list);
      for (int i = 0; i < requestedLeave.length; i++) {
        if (requestedLeave[i].seen == false) {
          var object = requestedLeave.removeAt(i);
          requestedLeave.insert(0, object);
        } else if (requestedLeave[i].status == "Pending") {
          var object = requestedLeave.removeAt(i);
          requestedLeave.insert(0, object);
        }
      }
      // print("list of requested----${list}");
    } else {}
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

  void applyForLeave() async {
    isLoading.value = true;
    var applyStatus = await apIsProvider.applyLeave(
        user[0].token,
        leaveTitle.text,
        leaveDescription.text,
        dateFrom.text,
        dateTo.text,
        selecteLeaveType);
    print(applyStatus);
    if (applyStatus == true) {
      leaveTitle.clear();
      leaveDescription.clear();
      dateFrom.clear();
      dateTo.clear();
      isLoading.value = false;
      Get.snackbar("Success", "Requested for leave");
    }

    isLoading.value = false;
  }
}
