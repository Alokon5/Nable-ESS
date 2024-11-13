// ignore_for_file: body_might_complete_normally_nullable, invalid_use_of_protected_member

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/values/colors.dart';
import '../../../data/models/designationModel/designationModel.dart';
import '../../../widgets/text_form.dart';
import 'controller.dart';

class ManagerForm extends StatelessWidget {
  ManagerForm({super.key});

  final HomeManagerController _controller = Get.put(HomeManagerController());

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
          "Create Staff",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _controller.createManagerFormKey,
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
                    lableText: "Enter First Name",
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter First Name";
                      }
                    },
                    controller: _controller.firstNameController,
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
                    lableText: "Enter Last  Name",
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter Last Name";
                      }
                    },
                    controller: _controller.lastNameController,
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
                    lableText: "Enter Email",
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter Email";
                      }
                    },
                    controller: _controller.emailController,
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
                          lableText: "Enter Your Password",
                          controller: _controller.passwordController,
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
                        child: _controller.desgnationList.length != 0 ? Padding(
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
                            popupItemBuilder: (context, item, isSelected) {
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
                                    _controller.selectedDesignation.toInt())
                                .first,
                            // showSelectedItems: true,
                          ),
                        ):CircularProgressIndicator(color: ColorConstant.primaryDark,),
                      ),
                    ),
                  );
                }),
                // Padding(
                //   padding:
                //       EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                //   child: Text(
                //     "D-O-B",
                //     style: Theme.of(context)
                //         .textTheme
                //         .labelMedium!
                //         .copyWith(color: Colors.black),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 28.w),
                //   child: InkWell(
                //     onTap: () async {
                //       final selectedDate = await showDatePicker(
                //         context: context,
                //         initialDate: DateTime.now(),
                //         firstDate: DateTime(1900),
                //         lastDate: DateTime(2100),
                //       );
                //       if (selectedDate != null) {
                //         _controller.updateSelectedDate(selectedDate.toString());
                //       }
                //     },
                //     child: IgnorePointer(
                //       child: AppTextField(
                //         lableText: "Enter Date of birth",
                //         validator: (value) {},
                //         controller: TextEditingController(),
                //       ),
                //     ),
                //   ),
                // ),
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
                // Padding(
                //   padding:
                //       EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                //   child: Text(
                //     "Department",
                //     style: Theme.of(context)
                //         .textTheme
                //         .labelMedium!
                //         .copyWith(color: Colors.black),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 28.w),
                //   child: Obx(
                //     () => DropdownButtonFormField<String>(
                //       value: _controller.selectedDepartments.value,
                //       onChanged: (String? newValue) {
                //         _controller.selectedDepartments.value = newValue!;
                //       },
                //       items: _controller.departmentItems,
                //       style: Theme.of(context).textTheme.bodyMedium,
                //       decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(9.0),
                //         ),
                //         hintText: "Select Gender",
                //         errorBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(9.0),
                //         ),
                //         focusedErrorBorder: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(9.0),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                Obx(() {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 21.h),
                    child: _controller.isLoading.value == false
                        ? SizedBox(
                            height: 42.h,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_controller
                                    .createManagerFormKey.currentState!
                                    .validate()) {
                                  // Form is valid, perform desired action
                                  _controller.createUser();
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
