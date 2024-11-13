import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/modules/management/base/controller.dart';
import 'package:nable_ess/app/modules/management/home/controller.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/modules/management/profile/profile.dart';

import '../../../core/mediaPlayer/playShortVideos.dart';
import '../../../data/providers/apis_provider.dart';

// ignore: must_be_immutable
class HomeManagement extends StatelessWidget {
  HomeManagement({super.key});
  var homeManagementController = Get.put(HomeManagementController());
  bool isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    homeManagementController.getEmplyeesDetails();
    homeManagementController.onInit();
    return Scaffold(
      // floatingActionButton: InkWell(
      //   onTap: () {
      //     var userObject = homeManagementController.allEmployeesList
      //         .where((p0) =>
      //             p0.id!.toInt() ==
      //             homeManagementController.allVideos[2].user!.toInt())
      //         .first
      //         .firstName
      //         .toString();
      //     printInfo(info: " user Name -=----------------------$userObject");
      //   },
      //   child: CircleAvatar(),
      // ),
      body: SafeArea(
        child: Obx(() {
          return homeManagementController.user.length != 0
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 24.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${homeManagementController.setupMessage.value} ${homeManagementController.user[0].displayName.toString()}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    DateFormat('dd MMM yyyy').format(
                                        homeManagementController
                                            .currentDate.value),
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 24.h),
                              child: InkWell(
                                onTap: () =>
                                    // Get.toNamed(AppRoutes.profileManagement),
                                    Get.to(() => ProfileManagement()),
                                child:
                                    homeManagementController.user[0].photoUrl ==
                                                null ||
                                            homeManagementController
                                                    .user[0].photoUrl ==
                                                ""
                                        ? CircleAvatar(
                                            backgroundImage: AssetImage(
                                                ImageConstant.maleProfile),
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                APIsProvider.mediaBaseUrl +
                                                    homeManagementController
                                                        .user[0].photoUrl!),
                                          ),
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
                      //createUser
                      // Padding(
                      //   padding: EdgeInsets.only(top: 23.h, bottom: 8.h),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       CardField(
                      //         category: "Create Reporting Officer",
                      //         image: ImageConstant.Intern,
                      //         onPressed: () {
                      //           Get.to(CreateManagerForm(),
                      //               transition: Transition.leftToRight);
                      //         },
                      //       ),
                      //       CardField(
                      //         category: "Create Staff",
                      //         image: ImageConstant.Intern,
                      //         onPressed: () {
                      //           Get.to(StaffForm(),
                      //               transition: Transition.leftToRight);
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Divider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        // child: Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 24, vertical: 2.h),
                        //   child: Text(
                        //     "Emplyees Details",
                        //     style: Theme.of(context).textTheme.titleMedium,
                        //   ),
                        // ),
                      ),
                      Obx(
                        () => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: homeManagementController
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
                                          await homeManagementController
                                              .getAllEmployeesList();
                                          var managementBaseController =
                                              await Get.find<
                                                  ManagementController>();
                                          managementBaseController.index.value =
                                              2;
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
                                                          "Employees"
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall),
                                                    ),
                                                    Text(
                                                        homeManagementController
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
                                          await homeManagementController
                                              .getAllPresentUsers();
                                          var managementBaseController =
                                              await Get.find<
                                                  ManagementController>();
                                          managementBaseController.index.value =
                                              2;
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
                                                        homeManagementController
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
                                          await homeManagementController
                                              .getAllAbsentUsers();
                                          var managementBaseController =
                                              await Get.find<
                                                  ManagementController>();
                                          managementBaseController.index.value =
                                              2;
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
                                                        homeManagementController
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
                      Divider(),
                      Padding(
                        padding: EdgeInsets.only(left: 24.w),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Recent Activity",
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                      ),
                      Obx(() {
                        return homeManagementController.allVideos.length != 0
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
                                          onTap: () {
                                            Get.to(() => ShortsMainScreen(
                                                  anVideoObject:
                                                      homeManagementController
                                                          .allVideos[0],
                                                  allVideoList:
                                                      homeManagementController
                                                          .allVideos,
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
                                                          homeManagementController
                                                              .allVideos[0]
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
                                                      "${homeManagementController.allVideos[0].title} ",
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
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => ShortsMainScreen(
                                                  allVideoList:
                                                      homeManagementController
                                                          .allVideos,
                                                  index: 1,
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
                                                          homeManagementController
                                                              .allVideos[1]
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
                                                      "${homeManagementController.allVideos[1].title} ",
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
                                        )
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
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => ShortsMainScreen(
                                                  allVideoList:
                                                      homeManagementController
                                                          .allVideos,
                                                  index: 2,
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
                                                          homeManagementController
                                                              .allVideos[2]
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
                                                      "${homeManagementController.allVideos[2].title} ",
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
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => ShortsMainScreen(
                                                  allVideoList:
                                                      homeManagementController
                                                          .allVideos,
                                                  index: 3,
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
                                                          homeManagementController
                                                              .allVideos[3]
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
                                                      "${homeManagementController.allVideos[3].title} ",
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
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                color: ColorConstant.primaryDark,
                              ));
                      })
                      // Obx(() {
                      //   // return Expanded(child: Container(color: ColorConstant.backgroud,));
                      //   return Expanded(
                      //       child: ListView.builder(
                      //     itemCount: 2,
                      //     physics: NeverScrollableScrollPhysics(),
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: EdgeInsets.symmetric(
                      //             horizontal: 14.w, vertical: 3.h),
                      //         child: InkWell(
                      //           onTap: () async {
                      //             // Get.to(AllVideos(
                      //             //   videoObj:
                      //             //       homeManagementController.allVideos[index],
                      //             // ));
                      //             print(homeManagementController.allVideos[index]
                      //                 .toJson());
                      //             Get.to(() => ShortsMainScreen(
                      //                   anVideoObject: homeManagementController
                      //                       .allVideos[index],
                      //                   allVideoList:
                      //                       homeManagementController.allVideos,
                      //                   index: index,
                      //                 ));
                      //           },
                      //           // child: VideoCardListing(
                      //           //   text_name: homeManagementController
                      //           //       .allVideos[index].title
                      //           //       .toString(),
                      //           //   text_desc: homeManagementController
                      //           //       .allVideos[index].description,
                      //           //   userName: homeManagementController
                      //           //               .allVideos[index].id !=
                      //           //           null
                      //           //       ? homeManagementController.getUserName(
                      //           //           homeManagementController
                      //           //               .allVideos[index].id,
                      //           //           index)
                      //           //       : "User Name",
                      //           //   text_thumb: homeManagementController
                      //           //       .allVideos[index].thumbnail
                      //           //       .toString(),
                      //           //   videoUrl: homeManagementController
                      //           //       .allVideos[index].video,
                      //           //   date: homeManagementController
                      //           //       .allVideos[index].createdAt,
                      //           // ),
                      //           child: Row(
                      //             children: [
                      //               Padding(
                      //                 padding: EdgeInsets.symmetric(
                      //                     horizontal: 10.w, vertical: 10.h),
                      //                 child: Card(
                      //                   elevation: 2,
                      //                   shape: RoundedRectangleBorder(
                      //                       borderRadius:
                      //                           BorderRadius.circular(25.r)),
                      //                   child: Column(
                      //                     children: [
                      //                       Padding(
                      //                         padding: const EdgeInsets.all(8.0),
                      //                         child: SizedBox(
                      //                           width: double.infinity,
                      //                           child: homeManagementController
                      //                                           .allVideos[index]
                      //                                           .thumbnail ==
                      //                                       null ||
                      //                                   homeManagementController
                      //                                           .allVideos[index]
                      //                                           .thumbnail ==
                      //                                       ""
                      //                               ? CircleAvatar(
                      //                                   radius: 35.r,
                      //                                   child: Image(
                      //                                       image: AssetImage(
                      //                                           ImageConstant
                      //                                               .maleProfile)),
                      //                                 )
                      //                               : CircleAvatar(
                      //                                   radius: 40.r,
                      //                                   backgroundColor:
                      //                                       Colors.white,
                      //                                   // backgroundImage: NetworkImage(
                      //                                   //     APIsProvider.mediaBaseUrl +
                      //                                   //         userDetailsController
                      //                                   //             .allEmployeesList[
                      //                                   //                 index]
                      //                                   //             .profileImage
                      //                                   //             .toString(),
                      //                                   //     scale: 50.r),
                      //                                   child: Image(
                      //                                     image: NetworkImage(
                      //                                       APIsProvider
                      //                                               .mediaBaseUrl +
                      //                                           homeManagementController
                      //                                               .allVideos[
                      //                                                   index]
                      //                                               .thumbnail
                      //                                               .toString(),
                      //                                     ),
                      //                                     fit: BoxFit.fill,
                      //                                   )),
                      //                         ),
                      //                       ),
                      //                       Expanded(
                      //                         child: Card(
                      //                           elevation: 1,
                      //                           child: Container(
                      //                             width: double.infinity,
                      //                             decoration: BoxDecoration(
                      //                                 // border: Border.all(),
                      //                                 ),
                      //                             child: Center(
                      //                               child: Text(
                      //                                 "${homeManagementController.allVideos[index].title} ",
                      //                                 style: Theme.of(context)
                      //                                     .textTheme
                      //                                     .bodySmall,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       // Expanded(
                      //                       //   child: Card(
                      //                       //     elevation: 0,
                      //                       //     child: Container(
                      //                       //       width: double.infinity,
                      //                       //       decoration: BoxDecoration(
                      //                       //           // border: Border.all(),
                      //                       //           ),
                      //                       //       child: Center(
                      //                       //         child: Text(
                      //                       //           "${userDetailsController.allEmployeesList[index].status}",
                      //                       //           style: Theme.of(context)
                      //                       //               .textTheme
                      //                       //               .bodySmall,
                      //                       //         ),
                      //                       //       ),
                      //                       //     ),
                      //                       //   ),
                      //                       // ),
                      //                       SizedBox(
                      //                         height: 8.h,
                      //                       )
                      //                     ],
                      //                   ),
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ));
                      // })
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
