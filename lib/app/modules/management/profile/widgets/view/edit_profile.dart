import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/management/profile/controller.dart';

import '../../../../../core/values/colors.dart';
import '../../../../../core/values/images.dart';
import '../../../../../widgets/text_form.dart';

// ignore: must_be_immutable
class EditProfileManagement extends StatelessWidget {
  EditProfileManagement({super.key});

  ProfileManagementController _profileManagementController =
      Get.put(ProfileManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25.h),
                child: Stack(
                  children: [
                    Obx(
                      () => Center(
                        child: _profileManagementController.selectedImagePath !=
                                ''
                            ? CircleAvatar(
                                backgroundColor: ColorConstant.backgroud,
                                radius: 42.r,
                                child: ClipOval(
                                  child: SizedBox(
                                    width: 76.w,
                                    height: 76.h,
                                    child: Image.file(
                                      File(_profileManagementController
                                          .selectedImagePath
                                          .toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : _profileManagementController.user[0].photoUrl ==
                                        null ||
                                    _profileManagementController
                                            .user[0].photoUrl ==
                                        ''
                                ? CircleAvatar(
                                    backgroundColor: ColorConstant.backgroud,
                                    radius: 42.r,
                                    child: ClipOval(
                                      child: SizedBox(
                                        width: 76.w,
                                        height: 76.h,
                                        child: _profileManagementController
                                                    .selectedGender ==
                                                "Male"
                                            ? Image(
                                                image: AssetImage(
                                                    ImageConstant.maleProfile),
                                              )
                                            : Image(
                                                image: AssetImage(ImageConstant
                                                    .femaleProfile),
                                              ),
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: ColorConstant.backgroud,
                                    radius: 42.r,
                                    backgroundImage: NetworkImage(
                                      APIsProvider.mediaBaseUrl +
                                          _profileManagementController
                                              .user[0].photoUrl
                                              .toString(),
                                    ),
                                  ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 56.w, top: 50.h),
                      child: Center(
                        child: CircleAvatar(
                          radius: 15.r,
                          child: IconButton(
                            onPressed: () {
                              _profileManagementController
                                  .pickImageFromGallery();
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                child: Text(
                  "First Name",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: AppTextField(
                  controller: _profileManagementController.firstName,
                  lableText: 'First Name',
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                child: Text(
                  "Last Name",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.black),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: AppTextField(
                  controller: _profileManagementController.lastName,
                  lableText: 'Last Name',
                ),
              ),
              Obx(() {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 21.h),
                  child: SizedBox(
                    height: 42.h,
                    child: _profileManagementController.isLoading.value != true
                        ? ElevatedButton(
                            onPressed: () {
                              _profileManagementController.editProfile();
                            },
                            child: Center(
                              child: Text("Save"),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: ColorConstant.primary,
                            ),
                          ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
