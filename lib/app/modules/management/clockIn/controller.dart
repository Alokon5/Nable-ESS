import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/allEmployeesModel.dart';
import 'package:nable_ess/app/data/models/dateTime.dart';
import 'package:nable_ess/app/data/models/userDetailsModel.dart';
import 'package:nable_ess/app/data/models/user_model.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/data/providers/storage_provider.dart';

import '../../../data/models/workDetailModel/datePairModel.dart';
import '../../../data/models/workDetailModel/timeDifference.dart';
import '../../../data/models/workDetailModel/workDetailTime.dart';

class ClockInController extends GetxController {
  StorageProvider storageProvider = StorageProvider();
  APIsProvider apIsProvider = APIsProvider();
  var user = <UserModel>[].obs;
  var allEmployeesList = <Datum>[].obs;
  var isLoading = false.obs;
  var checkInList = <CheckIn>[].obs;
  var chekOutList = <CheckOut>[].obs;
  var testEffective = 0.obs;
//  var User? userDetails;
  var singleUserData = User().obs;
  User? userDetailsSingleUser;
  var checkInDateTimeList = <DateTimeModel>[].obs;
  var checkOutDateTimeList = <DateTimeModel>[].obs;
  var workHoursDetailsList = <WorkTimeModel>[].obs;
  var workFilteredHorsMinList = <WorkTimeModel>[].obs;
  var filterDateList = [].obs;

  var startDateFilter = TextEditingController();
  var endDateFilter = TextEditingController();
  var totalWorkHrsMins = "".obs;

  var noOfAbsent = 0.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getCurrentAndDateBefore27Days();
    await getUserDetails();
    await getAllEmployees();
  }

  getUserDetails() async {
    var userDetails = await storageProvider.readUserModel();
    user.assign(userDetails);
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
    }

    isLoading.value = false;
  }

  dateTimeFormator(dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);

    String formattedTime = DateFormat('h:mm a').format(dateTime);
    String date = "${DateFormat('dd-MMM-yyyy').format(dateTime)}";
    DateTimeModel formatedDateTime =
        DateTimeModel(date: date, time: formattedTime);
    return formatedDateTime;
  }

  TimeDifference calculateTotalTimeDifference(
      String startTime, String endTime) {
    final startDateTime = DateFormat("h:mm a").parse(startTime);
    final endDateTime = DateFormat("h:mm a").parse(endTime);

    final difference = endDateTime.difference(startDateTime);

    final totalMinutes = difference.inMinutes;
    final totalHours = totalMinutes ~/ 60;
    final remainingMinutes = totalMinutes % 60;

    return TimeDifference(totalHours, remainingMinutes);
  }

  getHrsMinsTotal() {
    int hrs = 0;
    int mins = 0;

    for (int i = 0; i < workFilteredHorsMinList.length; i++) {
      var totolWorkHrs = workFilteredHorsMinList[i].workHrsInDay!.toInt();
      var totolWorkMins = workFilteredHorsMinList[i].workMinInDay!.toInt();
      hrs = hrs + totolWorkHrs;
      mins = mins + totolWorkMins;
    }
    final totalHours = mins ~/ 60;
    final remainingMinutes = mins % 60;
    final grandTotalHrs = hrs + totalHours;

    final grandTotalMins = remainingMinutes;
    totalWorkHrsMins.value = "${grandTotalHrs}h ${grandTotalMins}m";

    // printInfo(
    //     info:
    //         "filter list length --=-=-=-=--${workFilteredHorsMinList.length},and all workhrslist ${workHoursDetailsList.length}");
    // printInfo(info: "total hrs --=-=-=-=--${hrs}");
    // printInfo(info: "total mins --=-=-=-=--${mins}");
    // printInfo(
    //     info:
    //         "total And Hours --=-=-=-=--${totalHours},minutes===${remainingMinutes}");
  }

  List<String> generateDateList(String startDateStr, String endDateStr) {
    print("sstar---$startDateStr,end----${endDateStr}");
    final startDate = DateTime.parse(startDateStr);
    final endDate = DateTime.parse(endDateStr);

    List<String> formattedDates = [];

    for (DateTime date = startDate;
        date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
        date = date.add(Duration(days: 1))) {
      final formattedDate = DateFormat('dd-MMM-yyyy').format(date);
      formattedDates.add(formattedDate);
    }
    filterDateList.assignAll(formattedDates);
    getFilterWorkData();

    printInfo(
        info:
            "dates between ------------------------${formattedDates.toList()}");

    return formattedDates;
  }

  getFilterWorkData() {
    noOfAbsent.value = 0;
    workFilteredHorsMinList.clear();
    printInfo(
        info: "filter listlength --this one---------${filterDateList.length}");
    if (filterDateList.length != 0) {
      for (int i = 0; i < filterDateList.length; i++) {
        var object = workHoursDetailsList
            .where((p0) => p0.date == filterDateList[i].toString())
            .toList();
        if (object.length != 0) {
          workFilteredHorsMinList.add(object[0]);
          printInfo(
              info:
                  "didNotMatch-calenderData------${filterDateList[i].toString()},object Data------${object.length != 0 ? object[0].checkOutTime : "Invalid Object"},uperlistObjectData --------${workHoursDetailsList[0].checkOutTime},checkIntime-------${workHoursDetailsList[0].checkInTime}");
        } else {
          noOfAbsent.value = noOfAbsent.value + 1;
        }
      }

      getHrsMinsTotal();

      // if(workHoursDetailsList.length >=filterDateList.length){

      // }
      // bool found = workHoursDetailsList.contains(filterDateList[0].toString());
      // printInfo(
      //     info:
      //         "filter via ${filterDateList[0]}value found or not ------${workHoursDetailsList.contains(filterDateList[0].toString())}");
      //  printInfo(info: "filter via ${filterDateList[0]}value found or not ------${workHoursDetailsList.contains(filterDateList[0])}");

    } else {
      EasyLoading.showError("Invalid data to filter !");
    }
  }

  DatePair getCurrentAndDateBefore27Days() {
    final now = DateTime.now();
    final dateBefore27Days = now.subtract(Duration(days: 27));

    final currentDateFormatted = DateFormat('yyyy-MM-dd').format(now);
    final dateBefore27DaysFormatted =
        DateFormat('yyyy-MM-dd').format(dateBefore27Days);
    startDateFilter.text = dateBefore27DaysFormatted;
    endDateFilter.text = currentDateFormatted;
    generateDateList(startDateFilter.text, endDateFilter.text);
    return DatePair(currentDateFormatted, dateBefore27DaysFormatted);
  }

  singleUserDataF(id) async {
    isLoading.value = true;
    var status = await apIsProvider.fetchUserDetails(user[0].token, id);

    if (status != null) {
      checkInList.assignAll(status.checkIn!.toList());
      chekOutList.assignAll(status.checkOut!.toList());
      checkInDateTimeList.clear();
      checkOutDateTimeList.clear();
      for (int i = 0; i < checkInList.length; i++) {
        DateTimeModel dateTime = dateTimeFormator(checkInList[i].createdAt);

        checkInDateTimeList
            .add(DateTimeModel(date: dateTime.date, time: dateTime.time));
      }
      for (int i = 0; i < chekOutList.length; i++) {
        DateTimeModel dateTime = dateTimeFormator(chekOutList[i].createdAt);

        checkOutDateTimeList
            .add(DateTimeModel(date: dateTime.date, time: dateTime.time));
      }
      workHoursDetailsList.clear();
      // printInfo(
      //     info:
      //         "cheInTimeDate------${checkInDateTimeList[0].date.toString()},checoutlistDateTime---=-=--=-=${checkOutDateTimeList[0].date.toString()}");
      for (int i = 0; i < checkOutDateTimeList.length; i++) {
        var object = checkInDateTimeList
            .where((p0) => p0.date == checkOutDateTimeList[i].date)
            .toList();
        if (object.length != 0) {
          var hoursMinutesObj = calculateTotalTimeDifference(
              object[0].time.toString(),
              checkOutDateTimeList[i].time.toString());
          workHoursDetailsList.add(WorkTimeModel(
            date: object[0].date,
            checkInTime: object[0].time,
            checkOutTime: checkOutDateTimeList[i].time,
            totalhrsminDay:
                "${hoursMinutesObj.hours}hrs.${hoursMinutesObj.minutes}min.",
            workHrsInDay: hoursMinutesObj.hours.toInt(),
            workMinInDay: hoursMinutesObj.minutes.toInt(),
          ));
        }

        // printInfo(
        //     info:
        //         "cheInTimeDate------${checkInDateTimeList[i].date.toString()},inTime-=-=----${checkInDateTimeList[i].time.toString()},checoutlistDateTime---=-=--=-=${checkOutDateTimeList[i].date.toString()},time=${checkOutDateTimeList[i].time.toString()}");
      }
      await generateDateList(startDateFilter.text, endDateFilter.text);

      var singleUserDataTemp = status.user;
      var one = User(
          status: singleUserDataTemp!.status,
          userType: singleUserDataTemp.userType,
          address: singleUserDataTemp.address,
          designation: singleUserDataTemp.designation,
          email: singleUserDataTemp.email,
          firstName: singleUserDataTemp.firstName,
          gender: singleUserDataTemp.gender,
          id: singleUserDataTemp.id,
          joinedDate: singleUserDataTemp.joinedDate,
          lastName: singleUserDataTemp.lastName,
          manager: singleUserDataTemp.manager,
          phoneNumber: singleUserDataTemp.phoneNumber,
          profileImage: singleUserDataTemp.profileImage);
      singleUserData.value = one;
      isLoading.value = false;
      // return one;
    } else {
      isLoading.value = false;
      // return null;
    }
    isLoading.value = false;
  }
}
