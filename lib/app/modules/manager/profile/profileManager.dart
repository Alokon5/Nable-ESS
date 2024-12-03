// ignore_for_file: must_be_immutable

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/manager/profile/controller.dart';
import 'package:nable_ess/app/routes/route.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';

class ProfileManager extends StatelessWidget {
  ProfileManager({super.key});
  var profileController = Get.put(ProfileManagerController());
  // var profileController = Get.find<ProfileManagerController>();

  @override
  Widget build(BuildContext context) {
    // profileController.onInit();
    // print(
    //     "profileController profile Image--------${profileController.profileImage.toString()}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black87,
        ),
        centerTitle: true,
        title: Text(
          "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      // floatingActionButton: InkWell(
      //   onTap: () {
      //     profileController.getCurrentMonthLeaveApproved();
      //   },
      //   child: Text("data")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Obx(() {
              return profileController.user.length != 0
                  ? Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                children: [
                                  Container(
                                    height: 263.0.h,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 221.h,
                                          width: double.infinity,
                                          color: Color(0xeFFF0F4F9),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 59.h),
                                                child: Text(
                                                  "${profileController.firstNameCotroller.text} ${profileController.lastNameCotroller.text}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 11.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    profileController.aboutUser!
                                                                .designation !=
                                                            null
                                                        ? Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.w),
                                                            child: Text(
                                                              // "${profileController.aboutUser!.designation}",
                                                              "${profileController.aboutUser!.designation != null ? profileController.getDesignationNameViaId(profileController.aboutUser!.designation) : ""}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    profileController.aboutUser!
                                                                .designation !=
                                                            null
                                                        ? Text(
                                                            "|",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          )
                                                        : SizedBox(),
                                                    profileController.aboutUser!
                                                                .userType !=
                                                            null
                                                        ? Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.w),
                                                            child: Text(
                                                              "${profileController.aboutUser!.userType}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    profileController.aboutUser!
                                                                .userType !=
                                                            null
                                                        ? Text(
                                                            "|",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          )
                                                        : SizedBox(),
                                                    profileController.aboutUser!
                                                                .joinedDate !=
                                                            null
                                                        ? Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.w),
                                                            child: Text(
                                                              "${profileController.aboutUser!.joinedDate != null ? profileController.dateTimeFormator(profileController.aboutUser!.joinedDate).date : ""}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.h),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 47.w),
                                                      child: Icon(
                                                        Icons.email_outlined,
                                                        size: 13.sp,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.w),
                                                      child: Text(
                                                        "${profileController.aboutUser!.email}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              profileController
                                                          .phoneNumberCotroller
                                                          .text !=
                                                      null
                                                  ? Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 47.w),
                                                          child: Icon(
                                                            Icons
                                                                .phone_android_outlined,
                                                            size: 13.sp,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12.w),
                                                          child: Text(
                                                            "+91 ${profileController.phoneNumberCotroller.text}",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox(),
                                              profileController
                                                          .selectedGender !=
                                                      null
                                                  ? Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8.h),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 47.w),
                                                            child: Icon(
                                                              profileController
                                                                              .selectedGender ==
                                                                          "Male" ||
                                                                      profileController
                                                                              .selectedGender ==
                                                                          "male"
                                                                  ? Icons
                                                                      .male_rounded
                                                                  : Icons
                                                                      .female_rounded,
                                                              size: 13.sp,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12.w),
                                                            child: profileController
                                                                        .selectedGender !=
                                                                    null
                                                                ? Text(
                                                                    "${profileController.selectedGender}",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall,
                                                                  )
                                                                : SizedBox(),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              profileController.addressCotroller
                                                          .text !=
                                                      null
                                                  ? Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 47.w),
                                                          child: Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            size: 13.sp,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12.w),
                                                          child: Container(
                                                            width: 210.w,
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Text(
                                                              "${profileController.addressCotroller.text}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox(),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: (profileController.profileImage
                                              .toString() ==
                                          "null" ||
                                      profileController.profileImage.value ==
                                          '')
                                  ? CircleAvatar(
                                      backgroundColor: ColorConstant.backgroud,
                                      radius: 42.r,
                                      child: profileController
                                                      .selectedGender.value ==
                                                  "Male" ||
                                              profileController
                                                      .selectedGender.value ==
                                                  "male"
                                          ? Image(
                                              image: AssetImage(
                                                  ImageConstant.maleProfile),
                                            )
                                          : Image(
                                              image: AssetImage(
                                                  ImageConstant.femaleProfile),
                                            ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: ColorConstant.backgroud,
                                      radius: 42.r,
                                      backgroundImage: NetworkImage(
                                          APIsProvider.mediaBaseUrl +
                                              profileController.profileImage
                                                  .toString()),
                                    ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 44.w, vertical: 15.h),
                          child: Container(
                            height: 59.h,
                            width: 270.w,
                            color: Color(0xeFFF0F4F9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Attendance",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      "${profileController.attendance.value}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    )
                                  ],
                                ),
                                VerticalDivider(
                                  indent: 15,
                                  endIndent: 15,
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Leaves",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      "${profileController.leaveApproved}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Container(
                            height: 40.h,
                            color: ColorConstant.complimentaryBackground,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.editProfileManager);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 12.w, right: 16.w),
                                        child: SizedBox(
                                            height: 24.h,
                                            child: Image(
                                                image: AssetImage(
                                                    ImageConstant.Edit))),
                                      ),
                                      Text(
                                        "Edit Profile",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      Get.toNamed(AppRoutes.editProfileManager);
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 12.r,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Container(
                            height: 40.h,
                            color: ColorConstant.complimentaryBackground,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.checkListScreen);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 12.w, right: 16.w),
                                        child: SizedBox(
                                            height: 24.h,
                                            child: Image(
                                                image: AssetImage(
                                                    ImageConstant.CheckIn))),
                                      ),
                                      Text(
                                        "Check List",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      Get.toNamed(AppRoutes.checkListScreen);
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 12.r,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 24.w),
                        //   child: Container(
                        //     height: 40.h,
                        //     color: ColorConstant.complimentaryBackground,
                        //     child: InkWell(
                        //       onTap: () {
                        //         Get.toNamed(AppRoutes.leaveForm);
                        //       },
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               Padding(
                        //                 padding: EdgeInsets.only(left: 12.w, right: 16.w),
                        //                 child: SizedBox(
                        //                     height: 24.h,
                        //                     child: Image(
                        //                         image: AssetImage(ImageConstant.Edit))),
                        //               ),
                        //               Text(
                        //                 "Apply For Leave",
                        //                 style: Theme.of(context).textTheme.bodySmall,
                        //               ),
                        //             ],
                        //           ),
                        //           IconButton(
                        //             onPressed: () async {

                        //             },
                        //             icon: Icon(
                        //               Icons.arrow_forward_ios_outlined,
                        //               size: 12.r,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 24.w, vertical: 15.h),
                        //   child: Container(
                        //     height: 40.h,
                        //     color: ColorConstant.complimentaryBackground,
                        //     child: InkWell(
                        //       onTap: () {
                        //         Get.toNamed(AppRoutes.leaveBase);
                        //       },
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               Padding(
                        //                 padding: EdgeInsets.only(
                        //                     left: 12.w, right: 16.w),
                        //                 child: Badge(
                        //                   position: BadgePosition.topEnd(
                        //                       top: -2.h, end: -2.h),
                        //                   showBadge: profileController
                        //                           .newlyRequestedList.length !=
                        //                       0,
                        //                   child: SizedBox(
                        //                       height: 24.h,
                        //                       child: Image(
                        //                           image: AssetImage(
                        //                               ImageConstant.Manage))),
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Manage Leave",
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .bodySmall,
                        //               ),
                        //             ],
                        //           ),
                        //           IconButton(
                        //             onPressed: () {},
                        //             icon: Icon(
                        //               Icons.arrow_forward_ios_outlined,
                        //               size: 12.r,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 0.h),
                          child: InkWell(
                            onTap: () {
                              // profileController.logOut();
                              logoutdialog(context, profileController);
                            },
                            child: Container(
                              height: 40.h,
                              color: ColorConstant.complimentaryBackground,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 12.w, right: 16.w),
                                        child: SizedBox(
                                            height: 24.h,
                                            child: Image(
                                                image: AssetImage(
                                                    ImageConstant.CheckOut))),
                                      ),
                                      Text(
                                        "Log Out",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // profileController.logOut();
                                      logoutdialog(context, profileController);
                                    },
                                    icon: Icon(
                                      Icons.logout_sharp,
                                      size: 12.r,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : CircularProgressIndicator(
                      color: ColorConstant.primaryDark,
                    );
            }),
          ),
        ),
      ),
    );
  }
}

logoutdialog(context, profileController) async {
  await Get.dialog(
    AlertDialog(
      title:
          Text('Confirm Logout', style: Theme.of(context).textTheme.bodyLarge),
      content: Text('Are you sure you want to logout?',
          style: Theme.of(context).textTheme.bodyMedium),
      actions: [
        TextButton(
          child: Text('Cancel', style: Theme.of(context).textTheme.bodySmall),
          onPressed: () {
            Get.back(); // Close the dialog
          },
        ),
        ElevatedButton(
          child: Text('Logout', style: Theme.of(context).textTheme.bodySmall),
          onPressed: () {
            // Perform logout logic here
            profileController.logOut(); // Close the dialog
          },
        ),
      ],
    ),
  );
}
