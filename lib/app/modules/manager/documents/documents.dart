import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/documents/document.dart';
import 'package:nable_ess/app/modules/manager/documents/lateEarlyForm.dart';
import 'package:nable_ess/app/modules/manager/documents/salary.dart';
import 'package:nable_ess/app/modules/manager/documents/selectUser.dart';

import 'package:nable_ess/app/modules/manager/profile/controller.dart';
import 'package:nable_ess/app/modules/manager/profile/profileManager.dart';
import 'package:nable_ess/app/routes/route.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../widgets/text_form.dart';
import '../videos/controller.dart';
import 'document.dart';
import 'lateEarlyScreenM.dart';

class DocumentsScreen extends StatelessWidget {
  DocumentsScreen({super.key});

  final profileManageMent = Get.put(ProfileManagerController());
  // final staffListController = Get.put(StaffVideocontroller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                onTap: () {
                                  Get.to(() => ProfileManager());
                                  // Navigator.push(context, MaterialPageRoute(
                                  //   builder: (context) {
                                  //     return ProfileManager();
                                  //   },
                                  // ));
                                },
                                // Get.toNamed(AppRoutes.profileManagement),
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
                                            // await profileManageMent
                                            //     .getRequestedLeave();
                                            // Get.to(() =>
                                            //     RequiestedLeaveManagement());
                                            Get.toNamed(AppRoutes.leaveBase);
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
                                                Badge.count(
  count: profileManageMent.newlyRequestedList.length,
  isLabelVisible: profileManageMent.newlyRequestedList.isNotEmpty,
  alignment: Alignment.topRight,
  child: Container(
    width: 150.w,
    height: 140.h,
    child: Center(
      child: Text("Leave", style: Theme.of(context).textTheme.titleMedium),
    ),
  ),
),

                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => LateEarlyScreenM());
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
                                                      child: Text("Late/Early",
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
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Get.to(
                                            //     () => DocumentUsersManager());
                                            Get.to(() => SelectUsers());

                                            // Get.dialog(
                                            //   showUploadDialog(
                                            //       staffListController),
                                            // );
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
                                            Get.to(() => SalaryScreen());
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
                                                      child: Text("Salary",
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

  // Widget showUploadDialog(
  //   StaffVideocontroller StaffVideocontroller,
  // ) {
  //   return AlertDialog(
  //     title: Text('Select a staff'),
  //     // Add the rest of your AlertDialog content here...
  //     actions: <Widget>[
  //       Obx(() {
  //         return SizedBox(
  //           height: 200.h,
  //           width: double.infinity,
  //           child: Column(
  //             children: [
  //               Text("My Document ${staffListController.staffsListed.length}"),
  //               Expanded(
  //                 child: Container(
  //                   width: double.infinity,
  //                   height: 200.h,
  //                   color: Colors.amber,
  //                   child: ListView.builder(
  //                     itemCount: staffListController.staffsListed.length,
  //                     itemBuilder: (context, index) => ListTile(
  //                       leading: CircleAvatar(),
  //                       title: Text("{object.firstName}"),
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         );
  //       })
  //       // Your dialog content here...
  //     ],
  //   );
  // }
}
