// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/staff/profile/controller.dart';

import '../../../../../core/values/colors.dart';
import '../../../../../core/values/images.dart';
import '../../../../../widgets/text_form.dart';

// ignore: must_be_immutable
class EditProfileStaff extends StatelessWidget {
  EditProfileStaff({super.key});

  StaffProfileController staffProfileController =
      Get.put(StaffProfileController());

  @override
  Widget build(BuildContext context) {
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
          "Edit Profile",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Obx(
          () {
            return Form(
              key: staffProfileController.editProfileStaffFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Stack(
                            children: [
                              Center(
                                child: staffProfileController
                                            .selectedImage.value !=
                                        null
                                    ? CircleAvatar(
                                        backgroundColor:
                                            ColorConstant.backgroud,
                                        radius: 42.r,
                                        child: ClipOval(
                                          child: SizedBox(
                                            width: 76.w,
                                            height: 76.h,
                                            child: Image.file(
                                              File(staffProfileController
                                                  .selectedImage.value!.path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      )
                                    : staffProfileController.user[0].photoUrl ==
                                                null ||
                                            staffProfileController
                                                    .user[0].photoUrl ==
                                                ""
                                        ? CircleAvatar(
                                            backgroundColor:
                                                ColorConstant.backgroud,
                                            radius: 42.r,
                                            child: ClipOval(
                                              child: SizedBox(
                                                width: 76.w,
                                                height: 76.h,
                                                child: staffProfileController
                                                                .selectedGender ==
                                                            "Male" ||
                                                        staffProfileController
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
                                            backgroundColor:
                                                ColorConstant.backgroud,
                                            radius: 42.r,
                                            backgroundImage: NetworkImage(
                                              APIsProvider.mediaBaseUrl +
                                                  staffProfileController
                                                      .user[0].photoUrl
                                                      .toString(),
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
                                        staffProfileController
                                            .pickImageFromGallery();
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 18.0.h, left: 37.w, bottom: 7.0.h),
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
                            maxLine: 1,
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please Enter First Name";
                              }
                            },
                            controller:
                                staffProfileController.firstNameController,
                            lableText: 'First Name',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 18.0.h, left: 37.w, bottom: 7.0.h),
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
                            maxLine: 1,
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please Enter Last Name";
                              }
                            },
                            controller:
                                staffProfileController.lastNameController,
                            lableText: 'Last Name',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 18.0.h, left: 37.w, bottom: 7.0.h),
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
                            maxHeight: 120,
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
                              staffProfileController.selectedGender.value =
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
                                staffProfileController.selectedGender.value,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 18.0.h, left: 37.w, bottom: 7.0.h),
                          child: Text(
                            "Phone Number",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: AppTextField(
                            controller:
                                staffProfileController.phoneNumberController,
                            lableText: 'Phone Number',
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       top: 18.0.h, left: 37.w, bottom: 7.0.h),
                        //   child: Text(
                        //     "Upload Document",
                        //     style: Theme.of(context)
                        //         .textTheme
                        //         .labelMedium!
                        //         .copyWith(color: Colors.black),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 24.w),
                        //   child: AppTextField(
                        //     controller:
                        //         staffProfileController.documentNameController,
                        //     lableText: 'Document Name',
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 10.h,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(horizontal: 24.w),
                        //   child: InkWell(
                        //     onTap: () => staffProfileController.pickPDF(),
                        //     child: Container(
                        //       height: 44.h,
                        //       width: 44.w,
                        //       decoration: BoxDecoration(
                        //           color: ColorConstant.backgroud,
                        //           borderRadius: BorderRadius.circular(8.r),
                        //           border: Border.all(color: Colors.black54)),
                        //       child: Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Icon(Icons.picture_as_pdf_outlined),
                        //           SizedBox(
                        //             width: 10.w,
                        //           ),
                        //           Text(
                        //             staffProfileController.pdfName.value == ''
                        //                 ? "Choose Document"
                        //                 : staffProfileController.pdfName.value,
                        //             style: TextStyle(color: Colors.blue),
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5.0.h, left: 37.w, bottom: 7.0.h),
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
                            controller:
                                staffProfileController.addressController,
                            lableText: 'Address',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 21.h),
                    child: SizedBox(
                        height: 42.h,
                        child: staffProfileController.isLoading == false
                            ? ElevatedButton(
                                onPressed: () async {
                                  if (staffProfileController
                                      .editProfileStaffFormKey.currentState!
                                      .validate()) {
                                    staffProfileController.editStaffProfile();
                                  }
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
                                ),
                              )),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
