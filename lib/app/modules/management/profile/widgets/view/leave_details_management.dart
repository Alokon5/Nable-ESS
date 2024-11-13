// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/modules/management/profile/controller.dart';

import '../../../../../core/values/colors.dart';
import '../../../../../data/models/requiestedLeaveModel/requiestedLeaveModel.dart';

class LeaveDetailsManagement extends StatelessWidget {
  final RequestedLeaveModel? object;
  LeaveDetailsManagement({super.key, this.object});
  ProfileManagementController profileManagementController =
      Get.put(ProfileManagementController());

  @override
  Widget build(BuildContext context) {
    print("object.title -=p=-=-=-==-- ${object!.title}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Show Details Of Leave",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    // height: 450.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xeFFF0F4F9),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 14.h, bottom: 12.h),
                          child: Center(
                            child: object!.createdBy!.profileImage == null
                                ? CircleAvatar(
                                    backgroundColor: ColorConstant.backgroud,
                                    radius: 28.5.r,
                                    child: Image(
                                      image:
                                          AssetImage(ImageConstant.maleProfile),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: ColorConstant.backgroud,
                                    radius: 28.5.r,
                                    backgroundImage: NetworkImage(object!
                                        .createdBy!.profileImage
                                        .toString()),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            "${object!.createdBy!.firstName} ${object!.createdBy!.lastName}",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h, top: 2.h),
                          child: Text(
                            "${object!.createdBy!.email}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        object!.createdBy!.phoneNumber != null
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 0.h, top: 0.h),
                                child: Text(
                                  "${object!.createdBy!.phoneNumber}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              )
                            : SizedBox(),
                        Divider(
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22.w, vertical: 19.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Title:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "${object!.title}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "From Date:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "${object!.fromDate}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22.w, vertical: 19.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "To Date:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "${object!.toDate}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Leave Type:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "${object!.leaveType!.name}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 19.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              child: Row(
                                children: [
                                  Text(
                                    "Description:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 5.h),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              // height: 90.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0.h),
                                child: Text(
                                  "${object!.description}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 5.h),
                          child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "Status: ${object!.status}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: getColorForLeaveStatus(
                                            object!.status.toString()),
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        object!.status == "Pending"
                            ? SizedBox(
                                width: double.infinity,
                                child: Obx(() {
                                  return profileManagementController
                                              .isLoading.value ==
                                          false
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                profileManagementController
                                                    .requestApprovelApiFrLeaveDetails(
                                                        object!.id);
                                              },
                                              child: Container(
                                                height: 30.h,
                                                width: 70.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: Colors.green),
                                                child: Center(
                                                  child: Text(
                                                    "Approve",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30.w,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                profileManagementController
                                                    .requestDeclineApiFrLeaveDetails(
                                                        object!.id);
                                              },
                                              child: Container(
                                                height: 30.h,
                                                width: 70.w,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: Colors.orange[900]),
                                                child: Center(
                                                  child: Text(
                                                    "Decline".toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(
                                          color: ColorConstant.primaryDark,
                                        ));
                                }),
                              )
                            : const SizedBox(),
                        SizedBox(
                          height: 30.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
