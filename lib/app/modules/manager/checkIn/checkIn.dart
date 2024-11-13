import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/modules/manager/home/controller.dart';
import 'package:nable_ess/app/modules/manager/profile/profileManager.dart';

import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';
import '../../staff/home/widgets/history.dart';

class CheckInView extends StatelessWidget {
  CheckInView({super.key});
  var homeManagerController = Get.put(HomeManagerController());
  @override
  Widget build(BuildContext context) {
    // homeManagerController.getUserDetails();
    return Scaffold(
      // floatingActionButton: Obx(() {
      //   return Container(
      //       height: 60.h,
      //       width: double.infinity,
      //       child: Center(
      //           child: Text("${homeManagerController.chekOutList.length}")));
      // }),
      body: SafeArea(
        child: Obx(() {
          return homeManagerController.user.length != 0
              ? Column(
                  children: [
                    Container(
                      color: ColorConstant.complimentaryBackground,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 24.w),
                                  child: homeManagerController.user.length != 0
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              homeManagerController
                                                      .setupMessage.value +
                                                  " " +
                                                  homeManagerController.fullName
                                                      .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Text(
                                              DateFormat('dd MMM yyyy').format(
                                                  homeManagerController
                                                      .currentDate.value),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall,
                                            ),
                                          ],
                                        )
                                      : CircularProgressIndicator(
                                          color: ColorConstant.primary,
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 24.h),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => ProfileManager());
                                    },
                                    child: homeManagerController
                                                    .profileImage.value ==
                                                null ||
                                            homeManagerController
                                                    .profileImage ==
                                                ''
                                        ? CircleAvatar(
                                            child: homeManagerController
                                                            .selectedGender ==
                                                        "Male" ||
                                                    homeManagerController
                                                            .selectedGender ==
                                                        "male"
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
                                                    homeManagerController
                                                        .profileImage.value),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Image(
                          height: 100.h,
                          width: 100.w,
                          image: AssetImage(ImageConstant.Logo),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, bottom: 2.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          homeManagerController.isLoading.value == false
                              ? InkWell(
                                  onTap: () async {
                                    if (homeManagerController
                                            .isChekInDateToday ==
                                        false) {
                                      await GetStorage().read("isGranted") !=
                                              true
                                          ? homeManagerController
                                              .checkLocationPermissionStatus()
                                          : homeManagerController
                                              .getCurrentLatLong();
                                      // if (GetStorage().read("checkIn") ==
                                      //         false ||
                                      //     GetStorage().read("checkIn") ==
                                      //         null) {
                                      //   await GetStorage()
                                      //               .read("isGranted") !=
                                      //           true
                                      //       ? homeManagerController
                                      //           .checkLocationPermissionStatus()
                                      //       : homeManagerController
                                      //           .getCurrentLatLong();
                                      // } else {
                                      //   EasyLoading.showError(
                                      //       "You have already Checked In");
                                      // }
                                    } else {
                                      EasyLoading.showError(
                                          "You have reached your check in limit. Try next day. Thank you !");
                                    }
                                  },
                                  child: Card(
                                    color: homeManagerController
                                                .isChekInDateToday ==
                                            true
                                        ? Colors.white60
                                        : Colors.white,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.r)),
                                    child: Container(
                                      height: 84.h,
                                      width: 149.w,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 9.h),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8.w),
                                                  child: SizedBox(
                                                      height: 24.h,
                                                      child: Image(
                                                          image: AssetImage(
                                                              ImageConstant
                                                                  .CheckIn))),
                                                ),
                                                Text("Check In",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            color: ColorConstant
                                                                .grey)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 7.h),
                                            // child: Text(
                                            //   GetStorage().read("checkIn") ==
                                            //           true
                                            //       ? homeManagerController
                                            //           .currentTimeInOut.value
                                            //       : "9:30 AM",
                                            //   style: Theme.of(context)
                                            //       .textTheme
                                            //       .titleSmall,
                                            // ),
                                            child: homeManagerController
                                                        .isChekInDateToday ==
                                                    false
                                                ? Text(
                                                    "${homeManagerController.formatTime().toString()}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  )
                                                : Text(
                                                    "${homeManagerController.checkInTimeNewStr}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w),
                                            child: Text(
                                              homeManagerController
                                                          .isChekInDateToday !=
                                                      false
                                                  ? homeManagerController
                                                      .checkInPunctualityNewStr
                                                      .toString()
                                                  : "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color:
                                                          ColorConstant.grey),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                  backgroundColor: ColorConstant.primaryDark,
                                )),
                          InkWell(
                            onTap: () {
                              if (homeManagerController.isChekOutDateToday ==
                                  false) {
                                checkOutDialog(context, homeManagerController);
                                // if (GetStorage().read("checkIn") == true ||
                                //     GetStorage().read("checkIn") != null) {
                                //   checkOutDialog(
                                //       context, homeManagerController);
                                // } else {
                                //   EasyLoading.showError(
                                //       "First you need to do Check In and try again !");
                                // }
                              } else {
                                EasyLoading.showError(
                                    "You have reached your check out limit. Try next day. Thank you !");
                              }
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: Container(
                                height: 84.h,
                                width: 149.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 9.h),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w),
                                            child: SizedBox(
                                                height: 24.h,
                                                child: Image(
                                                    image: AssetImage(
                                                        ImageConstant
                                                            .CheckOut))),
                                          ),
                                          Text("Check Out",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color:
                                                          ColorConstant.grey)),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 7.h),
                                      child: homeManagerController
                                                  .isChekOutDateToday ==
                                              false
                                          ? Text(
                                              "${homeManagerController.formatTime().toString()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            )
                                          : Text(
                                              "${homeManagerController.checkOutTimeNewStr}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Text(
                                        homeManagerController
                                                    .isChekOutDateToday !=
                                                false
                                            ? homeManagerController
                                                .checkOutPunctualityNewStr
                                                .toString()
                                            : "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(
                                                color: ColorConstant.grey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: homeManagerController.checkInList.length != 0
                          ? ListView.builder(
                              itemCount:
                                  homeManagerController.checkInList.length,
                              itemBuilder: (context, index) {
                                var checkInlength =
                                    homeManagerController.checkInList.length;
                                var checkOutLength =
                                    homeManagerController.chekOutList.length;
                                homeManagerController.checkInList.length;
                                var checkInDateTime = (checkInlength - 1) >=
                                        index
                                    ? homeManagerController.dateTimeFormator(
                                        homeManagerController
                                            .checkInList[index].createdAt)
                                    : null;
                                var checkOutDateTime = (checkOutLength - 1) >=
                                        index
                                    ? homeManagerController.dateTimeFormator(
                                        homeManagerController
                                            .chekOutList[index].createdAt)
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
                                        ? homeManagerController
                                            .checkInList[index].punctuality
                                        : "No Data",
                                    // homeManagerController.isOnTimeCheckIn(
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
                                        ? homeManagerController
                                            .chekOutList[index].punctuality
                                        : "No Data"
                                    // homeManagerController.isOnTimeCheckOut(
                                    //         DateTime(0, 1, 1, 18, 00))
                                    //     ? "On Time"
                                    //     : "Early Left",
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
                            ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: ColorConstant.primaryDark,
                ));
        }),
      ),
    );
  }

  checkOutDialog(context, HomeManagerController homeManagerController) async {
    await Get.dialog(
      AlertDialog(
        title: Text('Confirm CheckOut',
            style: Theme.of(context).textTheme.bodyLarge),
        content: Text('Are you sure you want to CheckOut?',
            style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          TextButton(
            child: Text('Cancel', style: Theme.of(context).textTheme.bodySmall),
            onPressed: () {
              Get.back(); // Close the dialog
            },
          ),
          ElevatedButton(
            child:
                Text('CheckOut', style: Theme.of(context).textTheme.bodySmall),
            onPressed: () {
              if (homeManagerController.isChekInDateToday == true) {
                homeManagerController.checkOutHit();
                // homeManagerController.updateCurrentTime();
                Get.back();
              } else if (homeManagerController.isChekInDateToday == false) {
                EasyLoading.showError(
                    "First you need to do Check In and try again thank you ! ");
              } else {
                EasyLoading.showError("You have already Checked Out");
              }
            },
          ),
        ],
      ),
    );
  }
}
