import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/staff/documents/lateEarlyForm.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';

import '../../manager/profile/controller.dart';
import '../../staff/profile/controller.dart';
import '../profile/controller.dart';
import 'lateEarlyForm.dart';

class LateEarlyScreenM extends StatelessWidget {
  LateEarlyScreenM({super.key});

  final profileStaffController = Get.put(StaffProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => LateEarlyFormM());
        },
        icon: Icon(Icons.upload_file_rounded),
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
          "Late/Early History",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Obx(
        () {
          // var data = profileStaffController.lateEarlyList;
          return profileStaffController.lateEarlyList.length != 0
              ? ListView.builder(
                  itemCount: profileStaffController.lateEarlyList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 10.h),
                          child: InkWell(
                            onTap: () {
                              // Get.to(
                              //   ShowLeaveHistoryData(),
                              //   arguments:
                              //       staffProfileController.leaveList[index],
                              // );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color(0xefff0f4f9)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: SizedBox(
                                          height: 50.h,
                                          child: profileStaffController
                                                          .user[0].photoUrl ==
                                                      null ||
                                                  profileStaffController
                                                          .user[0].photoUrl ==
                                                      ""
                                              ? Image(
                                                  image: AssetImage(
                                                      ImageConstant
                                                          .maleProfile),
                                                )
                                              : CircleAvatar(
                                                  radius: 25.r,
                                                  backgroundColor:
                                                      ColorConstant.backgroud,
                                                  backgroundImage: NetworkImage(
                                                      APIsProvider
                                                              .mediaBaseUrl +
                                                          profileStaffController
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
                                                  "Late/Early",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 20.w),
                                                  child: Text(
                                                    "Date: ${profileStaffController.lateEarlyList[index].date.toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(),
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
                                                  padding: EdgeInsets.only(
                                                      right: 9.w),
                                                  child: Text(
                                                    "Time: ${profileStaffController.lateEarlyList[index].time.toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                      child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 10.h),
                                    child: Text(
                                      "Description : ${profileStaffController.lateEarlyList[index].description}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Expanded(
                        //     child: SizedBox(
                        //   child: Text("data"),
                        // ))
                        // Expanded(
                        //     child: Text(profileStaffController
                        //         .lateEarlyList[index].description
                        //         .toString()))
                        // Text("${profileStaffController.lateEarlyList.length}")
                        // Container(
                        //   child: Text("data"),
                        // )
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
        },
      ),
    );
  }
}
