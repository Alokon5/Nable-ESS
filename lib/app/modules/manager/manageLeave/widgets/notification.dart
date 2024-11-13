// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/manageLeave/widgets/leaveDetails.dart';

import '../../../../core/values/colors.dart';
import '../../../../core/values/images.dart';
import '../controller.dart';

class LeaveNotification extends StatelessWidget {
  LeaveNotification({super.key});

  LeaveController leaveController = Get.find<LeaveController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black87,
        ),
        centerTitle: true,
        title: Text(
          "Requested Leaves",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Obx(() {
        return leaveController.isLoading.value == false
            ? Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    reverse: false,
                    itemCount: leaveController.requestedLeave.length,
                    itemBuilder: (context, index) {
                      var fromDateTime = leaveController.dateTimeFormator(
                          leaveController.requestedLeave[index].fromDate);
                      var toDateTime = leaveController.dateTimeFormator(
                          leaveController.requestedLeave[index].toDate
                              .toString());
                      var status = leaveController.requestedLeave[index].status;
                      var leaveTypeStatus =
                          leaveController.requestedLeave[index].leaveType;
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              leaveController.updateSeenStatus(
                                  leaveController.requestedLeave[index].id);

                              Get.to(LeaveDetails(
                                object: leaveController.requestedLeave[index],
                              ));
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 10.h),
                              child: Container(
                                height: 120.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: Color(0xefff0f4f9)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
                                      child: SizedBox(
                                        height: 50.h,
                                        child: leaveController
                                                    .requestedLeave[index]
                                                    .createdBy!
                                                    .profileImage ==
                                                null
                                            ? Image(
                                                image: AssetImage(
                                                    ImageConstant.maleProfile),
                                              )
                                            : CircleAvatar(
                                                radius: 25.r,
                                                backgroundColor:
                                                    ColorConstant.backgroud,
                                                backgroundImage: NetworkImage(
                                                    leaveController
                                                        .requestedLeave[index]
                                                        .createdBy!
                                                        .profileImage
                                                        .toString()),
                                              ),
                                      ),
                                    ),
                                    Column(
                                      // crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${leaveController.requestedLeave[index].createdBy!.firstName}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                              ),
                                              Text(
                                                "${status.toString()}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color:
                                                            getColorForLeaveStatus(
                                                                status
                                                                    .toString())),
                                              ),
                                              SizedBox(
                                                width: 40.w,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: ColorConstant
                                                        .secondaryLight,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.r)),
                                                child: leaveController
                                                            .requestedLeave[
                                                                index]
                                                            .seen ==
                                                        false
                                                    ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w,
                                                                vertical: 3.h),
                                                        child: Text(
                                                          "New",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 2.h, left: 5.w),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(right: 9.w),
                                                child: Text(
                                                  "From: ${fromDateTime.date.toString()}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ),
                                              Text("|",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 9.w),
                                                child: Text(
                                                    "To: ${toDateTime.date.toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.w, vertical: 5.h),
                                          child: Text(
                                              "Leave Type: ${leaveTypeStatus != null ? leaveTypeStatus.name : "Leave Type"}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        status.toString() == "Pending"
                                            ? Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      leaveController
                                                          .requestApprovelApi(
                                                              leaveController
                                                                  .requestedLeave[
                                                                      index]
                                                                  .id);
                                                    },
                                                    child: Container(
                                                      height: 24.h,
                                                      width: 60.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors.green),
                                                      child: Center(
                                                        child: Text(
                                                          "Approve",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 30.w,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      leaveController
                                                          .requestDeclineApi(
                                                              leaveController
                                                                  .requestedLeave[
                                                                      index]
                                                                  .id);
                                                    },
                                                    child: Container(
                                                      height: 24.h,
                                                      width: 60.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors
                                                              .orange[900]),
                                                      child: Center(
                                                        child: Text(
                                                          "Decline".toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : SizedBox(),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )),
                  SizedBox(
                    height: 15.h,
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                color: ColorConstant.button,
              ));
      }),
    );
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
}
