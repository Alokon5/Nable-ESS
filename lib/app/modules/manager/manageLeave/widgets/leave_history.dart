// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/modules/manager/manageLeave/controller.dart';
import 'package:nable_ess/app/modules/manager/manageLeave/widgets/historyDetails.dart';

import '../../../../core/values/images.dart';
import '../../../../data/providers/apis_provider.dart';

class History extends StatelessWidget {
  History({super.key});
  // var leaveController = Get.put(LeaveController());
  var leaveController = Get.find<LeaveController>();
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
          "Your Leaves history",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Obx(() {
        return leaveController.leaveList.length != 0
            ? Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemCount: leaveController.leaveList.length,
                    itemBuilder: (context, index) {
                      var fromDateTime = leaveController.dateTimeFormator(
                          leaveController.leaveList[index].fromDate);
                      var toDateTime = leaveController.dateTimeFormator(
                          leaveController.leaveList[index].toDate.toString());
                      var status = leaveController.leaveList[index].status;
                      var leaveTypeStatus =
                          leaveController.leaveList[index].leaveType;
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => HistoryDetails(
                                  object: leaveController.leaveList[index]));
                              print(
                                  "leaveController.leaveList[index]------${leaveController.leaveList[index].toJson()}");
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 10.h),
                              child: Container(
                                height: 78.h,
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
                                                        .user[0].photoUrl ==
                                                    null ||
                                                leaveController
                                                        .user[0].photoUrl ==
                                                    ''
                                            ? Image(
                                                image: AssetImage(
                                                    ImageConstant.maleProfile),
                                              )
                                            : CircleAvatar(
                                                radius: 25.r,
                                                backgroundColor:
                                                    ColorConstant.backgroud,
                                                backgroundImage: NetworkImage(
                                                    APIsProvider.mediaBaseUrl +
                                                        leaveController
                                                            .user[0].photoUrl
                                                            .toString()),
                                              ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.h, left: 5.w),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "Leave Request",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20.w),
                                                child: Text(
                                                  "Status: ${status.toString()}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                          color: getColorForLeaveStatus(
                                                              status
                                                                  .toString())),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 7.h, left: 5.w),
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
                                              "Leave Type: ${leaveTypeStatus!.name}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
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
            : Center(child: Text("Empty"));
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
