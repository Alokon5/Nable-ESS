// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/home/controller.dart';
import '../../../core/values/colors.dart';
import '../../../widgets/text_form.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key});

  final HomeManagementController _controller =
      Get.put(HomeManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primary,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Create User",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            // key: ,
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
                    validator: (value) {},
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
                    lableText: "Enter Last Name",
                    validator: (value) {},
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
                    lableText: "Enter Your Email",
                    validator: (value) {},
                    controller: _controller.email,
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
                        controller: _controller.password,
                        validator: (value) => value == "" || value == null
                            ? "Password Can't Be Empty"
                            : null,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "D-O-B",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: InkWell(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        // _controller.updateSelectedDate(selectedDate.toString());
                      }
                    },
                    child: IgnorePointer(
                      child: AppTextField(
                        lableText: "Enter Date of birth",
                        validator: (value) {},
                        controller: TextEditingController(),
                      ),
                    ),
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
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Select Roles",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 28.w),
                //   child: Obx(
                //     () => DropdownButtonFormField<String>(
                //       value: _controller.selectedRole.value,
                //       onChanged: (String? newValue) {
                //         _controller.selectedRole.value = newValue!;
                //       },
                //       items: _controller.roleItems,
                //       style: Theme.of(context).textTheme.bodyMedium,
                //       decoration: InputDecoration(
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(9.0),
                //         ),
                //         hintText: "Select Roles",
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
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 28.w, vertical: 21.h),
                  child: SizedBox(
                    height: 42.h,
                    child: ElevatedButton(
                      onPressed: () {
                        _controller.creatManager();
                      },
                      child: Center(
                        child: Text("Create User"),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
