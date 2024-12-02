import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/base/controller.dart';
import 'package:nable_ess/app/modules/management/documents/allSalary.dart';
import 'package:nable_ess/app/modules/management/documents/document.dart';
import 'package:nable_ess/app/modules/management/documents/lateEarly/lateEarly.dart';
import 'package:nable_ess/app/modules/management/profile/controller.dart';
import 'package:nable_ess/app/modules/management/profile/widgets/view/manage_leave_management.dart';
import 'package:badges/badges.dart' as badges;
import 'package:nable_ess/app/routes/route.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';

class DocumentsScreen extends StatelessWidget {
  DocumentsScreen({super.key});

  final profileManageMent = Get.find<ProfileManagementController>();

  @override
  Widget build(BuildContext context) {
    profileManageMent.onInit();
    print(
        "profileManageMent.user[0].displayName---${profileManageMent.firstName.text}");
    return Scaffold(
      // floatingActionButton: InkWell(
      //     onTap: () {
      //       profileManageMent.getDocument();
      //     },
      //     child: CircleAvatar(
      //       radius: 25.r,
      //     )),
      body: SafeArea(
        child: Obx(() {
          return profileManageMent.user.length != 0
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
                                    "${profileManageMent.user[0].displayName.toString()}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 24.h),
                              child: InkWell(
                                onTap: () =>
                                    Get.toNamed(AppRoutes.profileManagement),
                                child: profileManageMent.user[0].photoUrl ==
                                            null ||
                                        profileManageMent.user[0].photoUrl == ""
                                    ? CircleAvatar(
                                        backgroundImage: AssetImage(
                                            ImageConstant.maleProfile),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            APIsProvider.mediaBaseUrl +
                                                profileManageMent
                                                    .user[0].photoUrl!),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 10.w),
                      //   child: Align(
                      //     alignment: Alignment.topLeft,
                      //     child: Image(
                      //       height: 100.h,
                      //       width: 100.w,
                      //       image: AssetImage(ImageConstant.Logo),
                      //       fit: BoxFit.contain,
                      //     ),
                      //   ),
                      // ),
                      Divider(),
                      //createUser
                      // Padding(
                      //   padding: EdgeInsets.only(top: 23.h, bottom: 8.h),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       CardField(
                      //         category: "Create Manager",
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
                      // Divider(),
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
                          padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
                          child: profileManageMent
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
                                          await profileManageMent
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
                                                        profileManageMent
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
                                          await profileManageMent
                                              .getAllPresentUsers();
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
                                                        profileManageMent
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
                                          await profileManageMent
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
                                                        profileManageMent
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
                      // Padding(
                      //   padding: EdgeInsets.only(left: 24.w),
                      //   child: Align(
                      //     alignment: Alignment.topLeft,
                      //     child: Text("Recent Activity",
                      //         style: Theme.of(context).textTheme.titleMedium),
                      //   ),
                      // ),
                      Obx(() {
                        return profileManageMent.isLoading.value != true
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await profileManageMent
                                                .getAllRequestedLeave();
                                            Get.to(() =>
                                                RequiestedLeaveManagement());
                                          },
                                          child: Card(
                                            color: ColorConstant
                                                .complimentaryLight,
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.r)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                badges.Badge(
                                                  // badgeContent: Text("${profileManageMent
                                                  //         .newRequestList
                                                  //         .length}"),
                                                  position:
                                                      BadgePosition.topEnd(
                                                          top: 2.h, end: 2.h),
                                                  showBadge: profileManageMent
                                                          .newRequestList
                                                          .isNotEmpty,
                                                  child: Container(
                                                    width: 150.w,
                                                    height: 140.h,
                                                    child: Center(
                                                        child: Text("Leave",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(LateEarlyAllUsers());
                                          },
                                          child: Card(
                                            color: ColorConstant
                                                .complimentaryLight,
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.r)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                badges.Badge(
                                                  //  badgeContent: Text("${profileManageMent
                                                  //         .newRequestLateList
                                                  //         .length}"),
                                                  position:
                                                      BadgePosition.topEnd(
                                                          top: 2.h, end: 2.h),
                                                  showBadge: profileManageMent
                                                          .newRequestLateList
                                                          .length != 0
                                                  ,
                                                  child: Container(
                                                    width: 150.w,
                                                    height: 140.h,
                                                    child: Center(
                                                        child: Text("Late/Early",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium)),
                                                  ),
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
                                            Get.to(() => DocumentUsers());
                                          },
                                          child: Card(
                                            color: ColorConstant
                                                .complimentaryLight,
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.r)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 150.w,
                                                  height: 140.h,
                                                  child: Center(
                                                      child: Text("Document",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Get.to(()=>AllSalaryPage());
                                          
                                          },
                                          child: Card(
                                            color: ColorConstant
                                                .complimentaryLight,
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        25.r)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 150.w,
                                                  height: 140.h,
                                                  child: Center(
                                                      child: Text("Roaster",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                color: ColorConstant.primaryDark,
                              ));
                      })

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
