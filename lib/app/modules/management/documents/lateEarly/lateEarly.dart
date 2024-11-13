import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/profile/controller.dart';

import '../../../../core/values/colors.dart';
import '../../../../core/values/images.dart';
import '../../../../data/providers/apis_provider.dart';

class LateEarlyAllUsers extends StatelessWidget {
  LateEarlyAllUsers({super.key});
  final profileStaffController = Get.put(ProfileManagementController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(
      () {
        // var data = profileStaffController.LateEarlyData;
        return profileStaffController.LateEarlyData.length != 0
            ? ListView.builder(
                itemCount: profileStaffController.LateEarlyData.length,
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.w),
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
                                                    ImageConstant.maleProfile),
                                              )
                                            : CircleAvatar(
                                                radius: 25.r,
                                                backgroundColor:
                                                    ColorConstant.backgroud,
                                                backgroundImage: NetworkImage(
                                                    APIsProvider.mediaBaseUrl +
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
                                                padding:
                                                    EdgeInsets.only(left: 20.w),
                                                child: Text(
                                                  "Date: ${profileStaffController.LateEarlyData[index].date.toString()}",
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
                                                padding:
                                                    EdgeInsets.only(right: 9.w),
                                                child: Text(
                                                  "Time: ${profileStaffController.LateEarlyData[index].time.toString()}",
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
                                    "Description : ${profileStaffController.LateEarlyData[index].description}",
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
                      //         .LateEarlyData[index].description
                      //         .toString()))
                      // Text("${profileStaffController.LateEarlyData.length}")
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
    ));
  }
}
