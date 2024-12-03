import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/profile/controller.dart';
import 'package:nable_ess/app/modules/management/profile/widgets/view/edit_profile.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';

class ProfileManagement extends StatelessWidget {
  ProfileManagement({super.key});

  var profileManageMent = Get.put(ProfileManagementController());

  @override
  Widget build(BuildContext context) {
    // profileManageMent.onInit();
    print(
        "profileManageMent.user[0].displayName---${profileManageMent.firstName.text}");
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top:1.h),
            child: Obx(() {
              return profileManageMent.user.length != 0
                  ? Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                children: [
                                  Container(
                                    height: 224.0.h,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 182.h,
                                          width: 312.w,
                                          color: Color(0xeFFF0F4F9),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 53.h),
                                                child: Text(
                                                  profileManageMent.fullName
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 47.w, top: 15.h),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 4),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.email,
                                                            size: 16.r,
                                                            color: ColorConstant
                                                                .secondary,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            profileManageMent
                                                                    .user[0]
                                                                    .email ??
                                                                'Not Found',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 4),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            size: 16.r,
                                                            color: ColorConstant
                                                                .primary,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            profileManageMent
                                                                    .user[0]
                                                                    .role ??
                                                                "Not Updated",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
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
                                child: profileManageMent.user[0].photoUrl ==
                                            null ||
                                        profileManageMent.user[0].photoUrl == ''
                                    ? CircleAvatar(
                                        radius: 42.r,
                                        child: profileManageMent
                                                        .selectedGender ==
                                                    "Male" ||
                                                profileManageMent
                                                        .selectedGender ==
                                                    "male"
                                            ? Image(
                                                image: AssetImage(
                                                    ImageConstant.maleProfile),
                                              )
                                            : Image(
                                                image: AssetImage(ImageConstant
                                                    .femaleProfile),
                                              ),
                                      )
                                    : CircleAvatar(
                                        radius: 42.r,
                                        backgroundImage: NetworkImage(
                                            APIsProvider.mediaBaseUrl +
                                                profileManageMent.profileImage
                                                    .toString()),
                                      )),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => EditProfileManagement());
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
                                    onPressed: () {
                                      Get.to(() => EditProfileManagement());
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
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 24.w, vertical: 15.h),
                        //   child: InkWell(
                        //     onTap: () async {
                        //       await profileManageMent.getAllRequestedLeave();
                        //       Get.to(() => RequiestedLeaveManagement());
                        //     },
                        //     child: Container(
                        //       height: 40.h,
                        //       color: ColorConstant.complimentaryBackground,
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
                        //                   showBadge: profileManageMent
                        //                           .newRequestList.length !=
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
                        //             onPressed: () {
                        //               Get.to(() => RequiestedLeaveManagement());
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 0.h),
                          child: InkWell(
                            onTap: () {
                              Get.dialog(
                                AlertDialog(
                                  title: Text('Confirm Logout',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                  content: Text(
                                      'Are you sure you want to logout?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                    ElevatedButton(
                                      child: Text('Logout',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                      onPressed: () {
                                        profileManageMent.logOut();
                                      },
                                    ),
                                  ],
                                ),
                              );
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
                                      Get.dialog(
                                        AlertDialog(
                                          title: Text('Confirm Logout',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                          content: Text(
                                              'Are you sure you want to logout?',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                          actions: [
                                            TextButton(
                                              child: Text('Cancel',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                            ElevatedButton(
                                              child: Text('Logout',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                              onPressed: () {
                                                profileManageMent.logOut();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
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
                  : Center(
                      child: CircularProgressIndicator(
                      color: ColorConstant.primaryDark,
                    ));
            }),
          ),
        ),
      ),
    );
  }
}
