// ignore_for_file: body_might_complete_normally_nullable

import 'dart:ffi';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/values/colors.dart';
import '../../../../data/models/allEmployeesModel.dart';
import '../../../../data/models/designationModel/designationModel.dart';
import '../../../../data/models/leaveModels/leaveTypeModel.dart';
import '../../../../widgets/text_form.dart';
import '../../../manager/home/controller.dart';
import '../controller.dart';

class StaffForm extends StatelessWidget {
  StaffForm({super.key});

  final HomeManagementController _controller =
      Get.put(HomeManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios, color: ColorConstant.button),
        ),
        title: Text(
          "Create staff",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _controller.createStaffFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: AppTextField(
                    maxLine: 1,
                    lableText: "Enter First Name",
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter First Name";
                      }
                    },
                    controller: _controller.firstName,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 26.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Last Name",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: AppTextField(
                    maxLine: 1,
                    lableText: "Enter Last  Name",
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter Last Name";
                      }
                    },
                    controller: _controller.lastName,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Email",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: AppTextField(
                    maxLine: 1,
                    lableText: "Enter Email",
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter Email";
                      }
                    },
                    controller: _controller.email,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Mobile Number",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: AppTextField(
                    maxLine: 1,
                    lableText: "Enter Mobile No.",
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter Mo. No.";
                      }
                    },
                    controller: _controller.mobileNumberController,
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
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: AppTextField(
                    maxLine: 1,
                    lableText: "Enter address",
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter Address";
                      }
                    },
                    controller: _controller.addressController,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Please confirm and enter check in data",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0.h, bottom: 7.0.h, left: 10.w),
                            child: Text(
                              "Latitude",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            width: 130.w,
                            child: AppTextField(
                              lableText: "Eg. 22.0703",
                              keyboardType: TextInputType.number,
                              // maxLength: 10,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please Enter Latitude";
                                }
                              },
                              controller: TextEditingController(),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0.h, bottom: 7.0.h, left: 10.w),
                            child: Text(
                              "Longitude",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            width: 130.w,
                            child: AppTextField(
                              lableText: "Eg. 82.1430",
                              keyboardType: TextInputType.number,
                              // maxLength: 10,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please Enter Longitude";
                                }
                              },
                              controller: TextEditingController(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.0.w, bottom: 7.0.h),
                  child: Text(
                    "Password",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w),
                      child: AppTextField(
                          maxLine: 1,
                          lableText: "Enter Your Password",
                          controller: _controller.password,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please Enter Password";
                            }
                          }),
                    ),
                  ],
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
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Obx(
                    () => DropdownButtonFormField<String>(
                      value: _controller.selectedGender.value,
                      onChanged: (String? newValue) {
                        _controller.selectedGender.value = newValue!;
                      },
                      items: _controller.genderItems,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
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
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Reporting officer",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Obx(
                  () => _controller.allMagngerList.length != 0
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.w),
                          child: DropdownSearch<Datum>(
                            dropdownBuilder: (context, selectedItem) {
                              return Text(
                                selectedItem!.firstName.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium, // Customize the text style here
                              );
                            },
                            popupItemBuilder: (context, item, isSelected) {
                              return ListTile(
                                title: Text(
                                  item.firstName.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium, // Customize the text style here
                                ),
                              );
                            },
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please select manager";
                              }
                            },
                            onChanged: (value) {
                              _controller.selecteMangerID.value = value!.id!;
                              print(_controller.selecteMangerID);
                            },
                            selectedItem: _controller.allMagngerList
                                .where((p0) => true)
                                .first,
                            mode: Mode.MENU,
                            items: _controller.allMagngerList,
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 7.h),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              hintText: "Select Manager",
                            ),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                          color: ColorConstant.primaryDark,
                        )),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Designation",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Obx(() {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorConstant.grey),
                          borderRadius: BorderRadius.circular(9.r)),
                      child: Center(
                        child: _controller.desgnationList.length != 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: DropdownSearch<DesignationModel>(
                                  items: _controller.desgnationList.value,
                                  dropdownBuilder: (context, selectedItem) {
                                    return SizedBox(
                                      child: Text(
                                        selectedItem!.name.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium, // Customize the text style here
                                      ),
                                    );
                                  },
                                  popupItemBuilder:
                                      (context, item, isSelected) {
                                    return ListTile(
                                      title: Text(
                                        item.name.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium, // Customize the text style here
                                      ),
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value == "") {
                                      return "Please select a Designation";
                                    }
                                  },
                                  itemAsString: (item) => item!.name.toString(),
                                  onChanged: (DesignationModel? newValue) {
                                    // managerProfileController.selectedGender.value = newValue!;
                                    _controller.selectedDesignation.value =
                                        newValue!.id!.toInt();
                                    print(_controller.selectedDepartments);
                                  },
                                  mode: Mode.MENU,

                                  dropdownSearchDecoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 7.h),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                        // borderRadius: BorderRadius.circular(9.0),
                                        ),
                                    hintText: "Select Designation",
                                    // errorBorder: OutlineInputBorder(
                                    //   // borderRadius: BorderRadius.circular(9.0),
                                    // ),
                                    // focusedErrorBorder: OutlineInputBorder(
                                    //   // borderRadius: BorderRadius.circular(9.0),
                                    // ),
                                  ),
                                  selectedItem: _controller.desgnationList
                                      .where((p0) =>
                                          p0.id ==
                                          _controller.selectedDesignation
                                              .toInt())
                                      .first,
                                  // showSelectedItems: true,
                                ),
                              )
                            : CircularProgressIndicator(
                                color: ColorConstant.primaryDark,
                              ),
                      ),
                    ),
                  );
                }),
                Obx(() {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 21.h),
                    child: _controller.isLoading.value == false
                        ? SizedBox(
                            height: 42.h,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_controller.createStaffFormKey.currentState!
                                    .validate()) {
                                  // Form is valid, perform desired action
                                  _controller.createStaff();
                                  print('Form is valid');
                                }
                              },
                              child: Center(
                                child: Text("Create Staff"),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                            color: ColorConstant.primaryDark,
                          )),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
