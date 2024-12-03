// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/manager/profile/controller.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../widgets/text_form.dart';

// ignore: must_be_immutable
class EditProfileManager extends StatelessWidget {
  EditProfileManager({super.key});

  ProfileManagerController managerProfileController =
      Get.find<ProfileManagerController>();

  @override
  Widget build(BuildContext context) {
    print(
        "managerProfileController.user[0]-=-=-=-=-=-${managerProfileController.firstNameCotroller.text}");
    // print(
    //     "this is edit profile---${managerProfileController.firstNameCotroller.text}");
    // print(
    //     "userDetails of gender ------${managerProfileController.selectedGender}");
    // managerProfileController.updateDetails()
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Edit Profile",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            return Form(
              key: managerProfileController.edtiProfileFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.h),
                    child: Stack(
                      children: [
                        Center(
                          child: managerProfileController.selectedImage.value !=
                                  null
                              ? CircleAvatar(
                                  backgroundColor: ColorConstant.backgroud,
                                  radius: 42.r,
                                  child: ClipOval(
                                    child: SizedBox(
                                        width: 76.r,
                                        height: 76.r,
                                        child: Image.file(
                                          File(managerProfileController
                                              .selectedImage.value!.path),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                )
                              : managerProfileController.profileImage.value ==
                                          '' ||
                                      managerProfileController
                                              .profileImage.value ==
                                          "null"
                                  ? CircleAvatar(
                                      backgroundColor: ColorConstant.backgroud,
                                      radius: 42.r,
                                      child: ClipOval(
                                        child: SizedBox(
                                          width: 76.r,
                                          height: 76.r,
                                          child: managerProfileController
                                                          .selectedGender ==
                                                      "Male" ||
                                                  managerProfileController
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
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: ColorConstant.backgroud,
                                      radius: 42.r,
                                      backgroundImage: NetworkImage(
                                          APIsProvider.mediaBaseUrl +
                                              managerProfileController
                                                  .user[0].photoUrl
                                                  .toString()),
                                    ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 56.w, top: 50.h),
                          child: Center(
                            child: CircleAvatar(
                              radius: 15.r,
                              child: IconButton(
                                onPressed: () {
                                  // print("object");
                                  managerProfileController
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
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Please Enter First Name";
                        }
                      },
                      controller: managerProfileController.firstNameCotroller,
                      lableText: 'First Name',
                      maxLine: 1,
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
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Please Enter Last Name";
                        }
                      },
                      controller: managerProfileController.lastNameCotroller,
                      lableText: 'Last Name',
                      maxLine: 1,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                    child: Text(
                      "Gender",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: DropdownSearch<String>(
                      maxHeight: 100.h,
                      dropdownBuilder: (context, selectedItem) {
                        return Text(
                          selectedItem.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium, // Customize the text style here
                        );
                      },
                      popupItemBuilder: (context, item, isSelected) {
                        return ListTile(
                          title: Text(
                            item,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium, // Customize the text style here
                          ),
                        );
                      },
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Please select your gender";
                        }
                      },
                      onChanged: (String? newValue) {
                        managerProfileController.selectedGender.value =
                            newValue!;
                      },
                      mode: Mode.MENU,
                      items: ["Male", "Female"],
                      dropdownSearchDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        hintText: "Select Gender",
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                      ),
                      selectedItem:
                          managerProfileController.selectedGender.value,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                    child: Text(
                      "Mobile No.",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: AppTextField(
                      controller: managerProfileController.phoneNumberCotroller,
                      lableText: 'Mobile No.',
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                    child: Text(
                      "Address",
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: AppTextField(
                      controller: managerProfileController.addressCotroller,
                      lableText: 'Address',
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 21.h),
                    child: SizedBox(
                      height: 42.h,
                      child: managerProfileController.editLoading == false
                          ? ElevatedButton(
                              onPressed: () {
                                if (managerProfileController
                                    .edtiProfileFormKey.currentState!
                                    .validate())
                                  managerProfileController.editManagerProfile();
                              },
                              child: Center(
                                child: Text("Apply",style: TextStyle(color: ColorConstant.buttonText ),),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.button,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              backgroundColor: ColorConstant.primaryDark,
                            )),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
