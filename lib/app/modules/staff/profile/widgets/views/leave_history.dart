// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/modules/staff/profile/widgets/views/show_leave_history_data.dart';
import 'package:nable_ess/app/modules/staff/profile/widgets/views/staff_leave_form.dart';

import '../../../../../core/values/colors.dart';
import '../../../../../data/providers/apis_provider.dart';
import '../../controller.dart';

class StaffLeaveHistory extends StatelessWidget {
  StaffLeaveHistory({super.key});

  var staffProfileController = Get.put(StaffProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => StaffLeaveForm());
        },
        icon: Icon(Icons.upload_file_rounded,color: ColorConstant.buttonText,),
        label: Text(
          'Apply',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
        backgroundColor: ColorConstant.button,
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black87,
        ),
        title: Text(
          "Leave Request History",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Obx(() {
        return staffProfileController.leaveList.length != 0
            ? ListView.builder(
                itemCount: staffProfileController.leaveList.length,
                itemBuilder: (context, index) {
                  var fromDateTime = staffProfileController.dateTimeFormator(
                      staffProfileController.leaveList[index].fromDate);
                  var toDateTime = staffProfileController.dateTimeFormator(
                      staffProfileController.leaveList[index].toDate);
                  var status = staffProfileController.leaveList[index].status;
                  var leaveTypeStatus =
                      staffProfileController.leaveList[index].leaveType;
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 10.h),
                        child: InkWell(
                          onTap: () {
                            Get.to(
                              ShowLeaveHistoryData(),
                              arguments:
                                  staffProfileController.leaveList[index],
                            );
                          },
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
                                    child: staffProfileController
                                                    .user[0].photoUrl ==
                                                null ||
                                            staffProfileController
                                                    .user[0].photoUrl ==
                                                ""
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
                                                    staffProfileController
                                                        .user[0].photoUrl
                                                        .toString()),
                                          ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 10.h, left: 5.w),
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
                                                    color: staffProfileController
                                                        .getColorForLeaveStatus(
                                                            status.toString()),
                                                  ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 7.h, left: 5.w),
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
              )
            : Center(
                child: Text(
                  "No Data found",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorConstant.grey),
                ),
              );
      }),
    );
  }
}
