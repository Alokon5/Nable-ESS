import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/modules/manager/mediaPlayer/playStaffVideos.dart';
import 'package:nable_ess/app/modules/staff/home/controller.dart';

import '../../../data/providers/apis_provider.dart';

import '../profile/view.dart';

// ignore: must_be_immutable
class HomeStaff extends StatelessWidget {
  HomeStaff({super.key});
  final StaffHomeController staffHomeController =
      Get.put(StaffHomeController());

  @override
  Widget build(BuildContext context) {
    // print(
    //     "staffHomeController.user.length---=-=-=-${staffHomeController.user.length}");
    staffHomeController.onInit();
    return Scaffold(
      // floatingActionButton: Text("${staffHomeController.videoList.length}"),
      body: SafeArea(
        child: Obx(
          () {
            // staffHomeController.chekOutList
            //     .sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            return staffHomeController.user.length != 0
                ? Column(
                    children: [
                      Container(
                        color: ColorConstant.complimentaryBackground,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 24.w),
                                    child: staffHomeController.user.length != 0
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                staffHomeController
                                                        .setupMessage.value +
                                                    " " +
                                                    staffHomeController
                                                        .user[0].displayName
                                                        .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              Text(
                                                DateFormat('dd MMM yyyy')
                                                    .format(staffHomeController
                                                        .currentDate.value),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelSmall,
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            height: 15.h,
                                            width: 15.w,
                                            child: CircularProgressIndicator(
                                              color: ColorConstant.primary,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => StaffProfile());
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 24.h),
                                      child: staffHomeController
                                                      .user[0].photoUrl ==
                                                  null ||
                                              staffHomeController
                                                      .user[0].photoUrl ==
                                                  ""
                                          ? CircleAvatar(
                                              child: staffHomeController
                                                          .selectedGender ==
                                                      "Male"
                                                  ? Image(
                                                      image: AssetImage(
                                                          ImageConstant
                                                              .maleProfile),
                                                    )
                                                  : Image(
                                                      image: AssetImage(
                                                          ImageConstant
                                                              .femaleProfile),
                                                    ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                  APIsProvider.mediaBaseUrl +
                                                      staffHomeController
                                                          .user[0].photoUrl
                                                          .toString()),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Recent Activity",
                                style: Theme.of(context).textTheme.titleMedium),
                          ],
                        ),
                      ),
                      Obx(() {
                        return staffHomeController.videoList.length != 0
                            ? Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            // var staffCntrl = await Get.put(
                                            //     StaffController());
                                            // staffCntrl.index.value = 1;

                                            Get.to(() => StaffShortsMainScreen(
                                                  allVideoList:
                                                      staffHomeController
                                                          .videoList,
                                                  index: 0,
                                                ));
                                          },
                                          child: Card(
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.r)),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                                SizedBox(
                                                  width: 140.w,
                                                ),
                                                Container(
                                                  child: Image(
                                                    height: 100.h,
                                                    image: NetworkImage(
                                                      APIsProvider
                                                              .mediaBaseUrl +
                                                          staffHomeController
                                                              .videoList[0]
                                                              .thumbnail
                                                              .toString(),
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 7.h,
                                                ),
                                                Container(
                                                  width: 100.w,
                                                  child: Center(
                                                    child: Text(
                                                      "${staffHomeController.videoList[0].title} ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 12.h,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        staffHomeController.videoList.length >=
                                                2
                                            ? InkWell(
                                                onTap: () async {
                                                  // var staffCntrl =
                                                  //     await Get.put(
                                                  //         StaffController());
                                                  // staffCntrl.index.value = 1;
                                                  Get.to(() =>
                                                      StaffShortsMainScreen(
                                                        index: 1,
                                                        allVideoList:
                                                            staffHomeController
                                                                .videoList,
                                                      ));
                                                },
                                                child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.r)),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 12.h,
                                                      ),
                                                      SizedBox(
                                                        width: 140.w,
                                                      ),
                                                      Container(
                                                        child: Image(
                                                          height: 100.h,
                                                          image: NetworkImage(
                                                            APIsProvider
                                                                    .mediaBaseUrl +
                                                                staffHomeController
                                                                    .videoList[
                                                                        1]
                                                                    .thumbnail
                                                                    .toString(),
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 7.h,
                                                      ),
                                                      Container(
                                                        width: 100.w,
                                                        child: Center(
                                                          child: Text(
                                                            "${staffHomeController.videoList[1].title} ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 12.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        staffHomeController.videoList.length >=
                                                3
                                            ? InkWell(
                                                onTap: () async {
                                                  // var staffCntrl =
                                                  //     await Get.put(
                                                  //         StaffController());
                                                  // staffCntrl.index.value = 1;

                                                  Get.to(() =>
                                                      StaffShortsMainScreen(
                                                        index: 2,
                                                        allVideoList:
                                                            staffHomeController
                                                                .videoList,
                                                      ));
                                                },
                                                child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.r)),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 12.h,
                                                      ),
                                                      SizedBox(
                                                        width: 140.w,
                                                      ),
                                                      Container(
                                                        child: Image(
                                                          height: 100.h,
                                                          image: NetworkImage(
                                                            APIsProvider
                                                                    .mediaBaseUrl +
                                                                staffHomeController
                                                                    .videoList[
                                                                        2]
                                                                    .thumbnail
                                                                    .toString(),
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 7.h,
                                                      ),
                                                      Container(
                                                        width: 100.w,
                                                        child: Center(
                                                          child: Text(
                                                            "${staffHomeController.videoList[2].title} ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 12.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                        staffHomeController.videoList.length >=
                                                4
                                            ? InkWell(
                                                onTap: () async {
                                                  // var staffCntrl =
                                                  //     await Get.put(
                                                  //         StaffController());
                                                  // staffCntrl.index.value = 1;

                                                  Get.to(() =>
                                                      StaffShortsMainScreen(
                                                        index: 3,
                                                        allVideoList:
                                                            staffHomeController
                                                                .videoList,
                                                      ));
                                                },
                                                child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.r)),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 12.h,
                                                      ),
                                                      SizedBox(
                                                        width: 140.w,
                                                      ),
                                                      Container(
                                                        child: Image(
                                                          height: 100.h,
                                                          image: NetworkImage(
                                                            APIsProvider
                                                                    .mediaBaseUrl +
                                                                staffHomeController
                                                                    .videoList[
                                                                        3]
                                                                    .thumbnail
                                                                    .toString(),
                                                          ),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 7.h,
                                                      ),
                                                      Container(
                                                        width: 100.w,
                                                        child: Center(
                                                          child: Text(
                                                            "${staffHomeController.videoList[3].title} ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 12.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Center(
                                child: Text(
                                "No Data Found !",
                                textAlign: TextAlign.center,
                              ));
                      })
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: ColorConstant.primaryDark,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
