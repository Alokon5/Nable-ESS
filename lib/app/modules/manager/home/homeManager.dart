import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/manager/base/controller.dart';
import 'package:nable_ess/app/modules/manager/mediaPlayer/playStaffVideos.dart';
import 'package:nable_ess/app/modules/manager/profile/profileManager.dart';

import 'controller.dart';

// ignore: must_be_immutable
class HomeManager extends StatelessWidget {
  HomeManager({super.key});

  var homeManagerController = Get.put(HomeManagerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: InkWell(
      //   onTap: () {
      //     homeManagerController.onInit();
      //   },
      //   child: Text("test meee")),
      body: SafeArea(
        child: Obx(() {
          return homeManagerController.user.length != 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: ColorConstant.complimentaryBackground,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 24.w),
                                    child:
                                        homeManagerController.user.length != 0
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    homeManagerController
                                                            .setupMessage
                                                            .value +
                                                        " " +
                                                        homeManagerController
                                                            .fullName
                                                            .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                  Text(
                                                    DateFormat('dd MMM yyyy')
                                                        .format(
                                                            homeManagerController
                                                                .currentDate
                                                                .value),
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
                            // Padding(
                            //   padding: EdgeInsets.only(top: 3.h, bottom: 2.h),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       homeManagerController.isLoading.value == false
                            //           ? InkWell(
                            //               onTap: () async {
                            //                 print(
                            //                     "check In ${GetStorage().read("checkIn")}");

                            //                 if (GetStorage().read("checkIn") ==
                            //                         false ||
                            //                     GetStorage().read("checkIn") ==
                            //                         null) {
                            //                   homeManagerController
                            //                       .checkLocationPermissionStatus();
                            //                 } else {
                            //                   print(
                            //                       "homeManagerController.user[0].checkIn---${GetStorage().read("checkIn")}");

                            //                   EasyLoading.showError(
                            //                       "You have already Checked In");
                            //                 }
                            //               },
                            //               child: Card(
                            //                 color: GetStorage().read("checkIn") ==
                            //                         true
                            //                     ? Colors.white60
                            //                     : Colors.white,
                            //                 elevation: 3,
                            //                 shape: RoundedRectangleBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(20.r)),
                            //                 child: Container(
                            //                   height: 84.h,
                            //                   width: 149.w,
                            //                   child: Column(
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.start,
                            //                     children: [
                            //                       Padding(
                            //                         padding:
                            //                             EdgeInsets.only(top: 9.h),
                            //                         child: Row(
                            //                           children: [
                            //                             Padding(
                            //                               padding: EdgeInsets
                            //                                   .symmetric(
                            //                                       horizontal:
                            //                                           8.w),
                            //                               child: SizedBox(
                            //                                   height: 24.h,
                            //                                   child: Image(
                            //                                       image: AssetImage(
                            //                                           ImageConstant
                            //                                               .CheckIn))),
                            //                             ),
                            //                             Text("Check In",
                            //                                 style: Theme.of(
                            //                                         context)
                            //                                     .textTheme
                            //                                     .labelSmall!
                            //                                     .copyWith(
                            //                                         color:
                            //                                             ColorConstant
                            //                                                 .grey)),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                       Padding(
                            //                         padding: EdgeInsets.symmetric(
                            //                             horizontal: 10.w,
                            //                             vertical: 7.h),
                            //                         child: Text(
                            //                           GetStorage().read(
                            //                                       "checkIn") ==
                            //                                   true
                            //                               ? homeManagerController
                            //                                   .currentTimeInOut
                            //                                   .value
                            //                               : "9:30 AM",
                            //                           style: Theme.of(context)
                            //                               .textTheme
                            //                               .titleSmall,
                            //                         ),
                            //                       ),
                            //                       Padding(
                            //                         padding: EdgeInsets.symmetric(
                            //                             horizontal: 10.w),
                            //                         child: Text(
                            //                           homeManagerController
                            //                                   .isOnTimeCheckIn(
                            //                                       DateTime(0, 1,
                            //                                           1, 9, 31))
                            //                               ? "On Time"
                            //                               : "Late",
                            //                           style: Theme.of(context)
                            //                               .textTheme
                            //                               .labelSmall!
                            //                               .copyWith(
                            //                                   color: ColorConstant
                            //                                       .grey),
                            //                         ),
                            //                       )
                            //                     ],
                            //                   ),
                            //                 ),
                            //               ),
                            //             )
                            //           : Center(
                            //               child: CircularProgressIndicator(
                            //               backgroundColor:
                            //                   ColorConstant.primaryDark,
                            //             )),
                            //       InkWell(
                            //         onTap: () {
                            //           if (GetStorage().read("checkIn") == true ||
                            //               GetStorage().read("checkIn") != null) {
                            //             checkOutDialog(
                            //                 context, homeManagerController);
                            //           } else {
                            //             EasyLoading.showError(
                            //                 "First you need to do Check In and try again !");
                            //           }
                            //         },
                            //         child: Card(
                            //           elevation: 3,
                            //           shape: RoundedRectangleBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(20.r)),
                            //           child: Container(
                            //             height: 84.h,
                            //             width: 149.w,
                            //             child: Column(
                            //               crossAxisAlignment:
                            //                   CrossAxisAlignment.start,
                            //               children: [
                            //                 Padding(
                            //                   padding: EdgeInsets.only(top: 9.h),
                            //                   child: Row(
                            //                     children: [
                            //                       Padding(
                            //                         padding: EdgeInsets.symmetric(
                            //                             horizontal: 8.w),
                            //                         child: SizedBox(
                            //                             height: 24.h,
                            //                             child: Image(
                            //                                 image: AssetImage(
                            //                                     ImageConstant
                            //                                         .CheckOut))),
                            //                       ),
                            //                       Text("Check Out",
                            //                           style: Theme.of(context)
                            //                               .textTheme
                            //                               .labelSmall!
                            //                               .copyWith(
                            //                                   color: ColorConstant
                            //                                       .grey)),
                            //                     ],
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding: EdgeInsets.symmetric(
                            //                       horizontal: 10.w,
                            //                       vertical: 7.h),
                            //                   child: Text(
                            //                     GetStorage().read("checkIn") ==
                            //                             false
                            //                         ? homeManagerController
                            //                             .currentTimeInOut.value
                            //                         : "06:00 PM",
                            //                     style: Theme.of(context)
                            //                         .textTheme
                            //                         .titleSmall,
                            //                   ),
                            //                 ),
                            //                 Padding(
                            //                   padding: EdgeInsets.symmetric(
                            //                       horizontal: 10.w),
                            //                   child: Text(
                            //                     homeManagerController
                            //                             .isOnTimeCheckOut(
                            //                                 DateTime(
                            //                                     0, 1, 1, 18, 00))
                            //                         ? "On Time"
                            //                         : "Before Time",
                            //                     style: Theme.of(context)
                            //                         .textTheme
                            //                         .labelSmall!
                            //                         .copyWith(
                            //                             color:
                            //                                 ColorConstant.grey),
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: EdgeInsets.only(top: 3.h, bottom: 2.h),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     children: [
                            //       CardField(
                            //         category: "Create Staff",
                            //         image: ImageConstant.Intern,
                            //         controller: TextEditingController(),
                            //         onPressed: () {
                            //           Get.toNamed(AppRoutes.managerForm);
                            //         },
                            //       ),
                            //       // CardField(
                            //       //   category: "More Features",
                            //       //   image: ImageConstant.Features,
                            //       //   controller: TextEditingController(),
                            //       //   onPressed: () {},
                            //       // ),

                            //       Padding(
                            //         padding:
                            //             EdgeInsets.only(top: 3.h, bottom: 2.h),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           children: [
                            //             CardField(
                            //               category: "VLog",
                            //               image: ImageConstant.vLogIcon3,
                            //               controller: TextEditingController(),
                            //               onPressed: () {
                            //                 Get.toNamed(AppRoutes.uploadTask);
                            //               },
                            //             ),
                            //           ],
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
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
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: homeManagerController
                                      .isLoadingForEmployeeDetails.value ==
                                  false
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14.r)),
                                      child: InkWell(
                                        onTap: () async {
                                          await homeManagerController
                                              .getAllUsers();
                                          var managementBaseController =
                                              await Get.find<
                                                  ManagerController>();
                                          managementBaseController.index.value =
                                              1;
                                        },
                                        child: Container(
                                          height: 50.h,
                                          width: 100.w,
                                          // color: cardColor,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10.h),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 2.h),
                                                      child: Text(
                                                          "Staffs".toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall),
                                                    ),
                                                    Text(
                                                        homeManagerController
                                                            .totalUser.value
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14.r)),
                                      child: InkWell(
                                        onTap: () async {
                                          await homeManagerController
                                              .getAllPresentUsers();
                                          var managementBaseController =
                                              await Get.find<
                                                  ManagerController>();
                                          managementBaseController.index.value =
                                              1;
                                          // Get.to(() => UsersScreen());
                                        },
                                        child: Container(
                                          height: 50.h,
                                          width: 100.w,
                                          // color: cardColor,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10.h),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 2.h),
                                                      child: Text(
                                                          "Checked In"
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall),
                                                    ),
                                                    Text(
                                                        homeManagerController
                                                            .totalPresent.value
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14.r)),
                                      child: InkWell(
                                        onTap: () async {
                                          await homeManagerController
                                              .getAllAbsentUsers();
                                          var managementBaseController =
                                              await Get.find<
                                                  ManagerController>();
                                          managementBaseController.index.value =
                                              1;
                                        },
                                        child: SizedBox(
                                          height: 50.h,
                                          width: 100.w,
                                          // color: cardColor,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10.h),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 2.h),
                                                      child: Text(
                                                          "Not In".toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall),
                                                    ),
                                                    Text(
                                                        homeManagerController
                                                            .totalAbsents.value
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                  color: ColorConstant.primaryDark,
                                )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Recent Activity",
                                style: Theme.of(context).textTheme.titleMedium),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(color: ColorConstant.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(
                      //     child: homeManagerController.yourVideoList.length != 0
                      //         ? ListView.builder(
                      //             itemCount:
                      //                 homeManagerController.yourVideoList.length,
                      //             // physics: NeverScrollableScrollPhysics(),

                      //             itemBuilder: (context, index) {
                      //               return Padding(
                      //                 padding: EdgeInsets.symmetric(
                      //                     horizontal: 14.w, vertical: 2.h),
                      //                 child: Obx(() {
                      //                   return homeManagerController
                      //                               .yourVideoList.length !=
                      //                           0
                      //                       ? InkWell(
                      //                           onTap: () async {
                      //                             // Get.to(() => PlayVideos(
                      //                             //       comeIn: index,
                      //                             //     ));
                      //                             Get.to(
                      //                                 () => StaffShortsMainScreen(
                      //                                       index: index,
                      //                                       allVideoList:
                      //                                           homeManagerController
                      //                                               .yourVideoList,
                      //                                     ));
                      //                           },
                      //                           child: VideoCardListing(
                      //                             text_name: homeManagerController
                      //                                 .yourVideoList[index].title
                      //                                 .toString(),
                      //                             text_desc: homeManagerController
                      //                                 .yourVideoList[index]
                      //                                 .description
                      //                                 .toString(),
                      //                             text_thumb:
                      //                                 homeManagerController
                      //                                     .yourVideoList[index]
                      //                                     .thumbnail
                      //                                     .toString(),
                      //                             date: homeManagerController
                      //                                 .yourVideoList[index]
                      //                                 .createdAt,
                      //                             videoUrl: homeManagerController
                      //                                 .yourVideoList[index].video,
                      //                           ),
                      //                         )
                      //                       : Card(
                      //                           elevation: 3,
                      //                           child: Container(
                      //                             height: 110.h,
                      //                             width: double.infinity,
                      //                             decoration: BoxDecoration(
                      //                                 color: Colors.grey),
                      //                           ),
                      //                         );
                      //                 }),
                      //               );
                      //             },
                      //           )
                      //         : Center(child: Text("No Video"))),

                      Obx(() {
                        return homeManagerController.yourVideoList.length != 0
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
                                            // var baseManagerCntrl =
                                            //     await Get.put(
                                            //         ManagerController());
                                            // baseManagerCntrl.index.value = 2;
                                            Get.to(() => StaffShortsMainScreen(
                                                  index: 0,
                                                  allVideoList:
                                                      homeManagerController
                                                          .yourVideoList,
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
                                                          homeManagerController
                                                              .yourVideoList[0]
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
                                                      "${homeManagerController.yourVideoList[0].title} ",
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
                                        homeManagerController
                                                    .yourVideoList.length >=
                                                2
                                            ? InkWell(
                                                onTap: () async {
                                                  // var baseManagerCntrl =
                                                  //     await Get.put(
                                                  //         ManagerController());
                                                  // baseManagerCntrl.index.value =
                                                  //     2;

                                                  Get.to(() =>
                                                      StaffShortsMainScreen(
                                                        index: 1,
                                                        allVideoList:
                                                            homeManagerController
                                                                .yourVideoList,
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
                                                                homeManagerController
                                                                    .yourVideoList[
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
                                                            "${homeManagerController.yourVideoList[1].title} ",
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
                                        homeManagerController
                                                    .yourVideoList.length >=
                                                3
                                            ? InkWell(
                                                onTap: () async {
                                                  // var baseManagerCntrl =
                                                  //     await Get.put(
                                                  //         ManagerController());
                                                  // baseManagerCntrl.index.value =
                                                  //     2;

                                                  Get.to(() =>
                                                      StaffShortsMainScreen(
                                                        index: 2,
                                                        allVideoList:
                                                            homeManagerController
                                                                .yourVideoList,
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
                                                                homeManagerController
                                                                    .yourVideoList[
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
                                                            "${homeManagerController.yourVideoList[2].title} ",
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
                                        homeManagerController
                                                    .yourVideoList.length >=
                                                4
                                            ? InkWell(
                                                onTap: () async {
                                                  // var baseManagerCntrl =
                                                  //     await Get.put(
                                                  //         ManagerController());
                                                  // baseManagerCntrl.index.value =
                                                  //     2;

                                                  Get.to(() =>
                                                      StaffShortsMainScreen(
                                                        index: 3,
                                                        allVideoList:
                                                            homeManagerController
                                                                .yourVideoList,
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
                                                                homeManagerController
                                                                    .yourVideoList[
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
                                                            "${homeManagerController.yourVideoList[3].title} ",
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
                                "No data found !",
                                textAlign: TextAlign.center,
                              ));
                      })
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: ColorConstant.primaryDark,
                ));
        }),
      ),
    );
  }
}
