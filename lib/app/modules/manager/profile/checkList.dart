// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/home/homeManager.dart';
import 'package:nable_ess/app/modules/manager/profile/controller.dart';

import '../../../core/values/images.dart';
import '../../staff/home/widgets/history.dart';

class CheckList extends StatelessWidget {
  CheckList({super.key});
  var profileController = Get.find<ProfileManagerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: InkWell(
      //   onTap: () async {
      //    var dateTime = await profileController. dateTimeFormator ("2023-07-04T12:15:47.926628Z");
      //    print("date -=-=-=-=-${dateTime.date}");
      //    print("time -=-=-=-=-${dateTime.time}");

      //   },
      //   child: Text("test meeeeeeee")),
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Check List",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: profileController.chekOutList.length != 0
          ? Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: ListView.builder(
                itemCount: profileController.checkInList.length,
                itemBuilder: (context, index) {
                  var checkInlength = profileController.checkInList.length;
                  var checkOutLength = profileController.chekOutList.length;
                  profileController.checkInList.length;
                  var checkInDateTime = (checkInlength - 1) >= index
                      ? profileController.dateTimeFormator(
                          profileController.checkInList[index].createdAt)
                      : null;
                  var checkOutDateTime = (checkOutLength - 1) >= index
                      ? profileController.dateTimeFormator(
                          profileController.chekOutList[index].createdAt)
                      : null;
                  return CheckInOutHistory(
                      title: "Check In",
                      iconImage: ImageConstant.CheckIn,
                      checkInDate: checkInDateTime != null
                          ? checkInDateTime.date.toString()
                          : "No Data",
                      checkInTime: checkInDateTime != null
                          ? checkInDateTime.time.toString()
                          : "No Data",
                      statusCheckIn: checkInDateTime != null
                          ? profileController.checkInList[index].punctuality
                          : "No Data",
                      // profileController.isOnTimeCheckIn(
                      //         DateTime(0, 1, 1, 9, 31))
                      //     ? "On Time"
                      //     : "Late",
                      iconImageOut: ImageConstant.CheckOut,
                      checkOutDate: checkOutDateTime != null
                          ? checkOutDateTime.date.toString()
                          : "No Data",
                      checkOutTime: checkOutDateTime != null
                          ? checkOutDateTime.time.toString()
                          : "No Data",
                      statusCheckOut: checkOutDateTime != null
                          ? profileController.chekOutList[index].punctuality
                          : "No Data"
                      // profileController.isOnTimeCheckOut(
                      //         DateTime(0, 1, 1, 18, 00))
                      //     ? "On Time"
                      //     : "Early Left",
                      );
                },
              ),
            )
          : Center(child: Text("No Data Found")),
    );
  }
}
