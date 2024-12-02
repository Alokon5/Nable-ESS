// ignore_for_file: body_might_complete_normally_nullable, invalid_use_of_protected_member

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/models/allEmployeesModel.dart';
import 'package:nable_ess/app/data/models/deptModel/deptModel.dart';
import 'package:nable_ess/app/data/models/weeklyOffPolicy/weeklyOffPolicy.dart';
import 'package:nable_ess/app/data/models/weeklyShiftModel/weeklyShiftModel.dart';
import '../../../core/values/colors.dart';
import '../../../data/models/designationModel/designationModel.dart';
import '../../../widgets/text_form.dart';
import 'controller.dart';

class ManagerForm extends StatefulWidget {
  ManagerForm({super.key});

  @override
  State<ManagerForm> createState() => _ManagerFormState();
}

class _ManagerFormState extends State<ManagerForm> {
  final HomeManagerController _controller = Get.put(HomeManagerController());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Earliest selectable date
      lastDate: DateTime.now(), // Latest selectable date
    );

    if (pickedDate != null) {
      setState(() {
        _controller.dobController.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }
  Future<void> _selectDateJ(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Earliest selectable date
      lastDate: DateTime.now(), // Latest selectable date
    );

    if (pickedDate != null) {
      setState(() {
        _controller.joinedDateController.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

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
                    lableText: "Enter Last Name",
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
                      EdgeInsets.only(top: 0.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Alternate Mobile Number",
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
                    // validator: (value) {
                    //   if (value == null || value == "") {
                    //     return "Please Enter Mo. No.";
                    //   }
                    // },
                    controller: _controller.alternateNumberController,
                  ),
                ),


                  //Dob
                Padding(
                  padding:
                      EdgeInsets.only(top: 1.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Date of Birth",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Container(
                    
                    height: 60,
                    child: TextFormField(
                       validator: (value) {
                        if (value == null || value == "") {
                          return "Please Enter DOB";
                        }
                      },
                      maxLines: 1,
                                  controller: _controller.dobController,
                                  decoration: InputDecoration(
                    // labelText: "Date of Birth",
                    // hintText: "Select your DOB",
                    // border: OutlineInputBorder(),
                    border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            // hintText: widget.lableText,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  readOnly: true, // Prevent manual text entry
                                  onTap: () => _selectDate(context), // Show date picker on tap
                                ),
                  ),
                ),

                //father name
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Father Name",
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
                    lableText: "Enter Father Name",
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter Father Name";
                      }
                    },
                    controller: _controller.fatherName,
                  ),
                ),
                //end of father name

             //   father mobile number start
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Father Mobile Number",
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
                    lableText: "Enter Father Mobile No.",
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter Mo. No.";
                      }
                    },
                    controller: _controller.fatherNumber,
                  ),
                ),
                //end

                //Joining Date
                   Padding(
                  padding:
                      EdgeInsets.only(top: 1.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Date of Joining",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  child: Container(
                    height: 60,
                    child: TextFormField(
                       validator: (value) {
                        if (value == null || value == "") {
                          return "Please Enter joining date";
                        }
                      },
                      maxLines: 1,
                                  controller: _controller.joinedDateController,
                                  decoration: InputDecoration(
                    // labelText: "Date of Birth",
                    border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
        // hintText: widget.lableText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
                    // hintText: "Select your joining date",
                    // border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  readOnly: true, // Prevent manual text entry
                                  onTap: () => _selectDateJ(context), // Show date picker on tap
                                ),
                  ),
                ),
                //end of joining date

                //Blood group 
                 Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Blood Group",
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
                    lableText: "Enter Blood Group",
                    // validator: (value) {
                    //   if (value == null || value == "") {
                    //     return "Please Enter Blood Group";
                    //   }
                    // },
                    controller: _controller.bloodController,
                  ),
                ),
                //end of blood group
                 

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
                    "Marital Status",
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
                      value: _controller.selectMaritalStatus.value,
                      onChanged: (String? newValue) {
                        _controller.selectMaritalStatus.value = newValue!;
                      },
                      items: _controller.maritalItems,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        hintText: "Select Marital Status",
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                      ),
                    ),
                  ),),

                   Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Department",
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
                        child: _controller.deptList.length != 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: DropdownSearch<DepartModel>(
                                  items: _controller.deptList.value,
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
                                      return "Please select a Department";
                                    }
                                  },
                                  itemAsString: (item) => item!.name.toString(),
                                  onChanged: (DepartModel? newValue) {
                                    // managerProfileController.selectedGender.value = newValue!;
                                    _controller.selectedDept.value =
                                        newValue!.id!.toInt();
                                    print(_controller.selectedDept);
                                  },
                                  mode: Mode.MENU,

                                  dropdownSearchDecoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 7.h),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                        // borderRadius: BorderRadius.circular(9.0),
                                        ),
                                    hintText: "Select Department",
                                    // errorBorder: OutlineInputBorder(
                                    //   // borderRadius: BorderRadius.circular(9.0),
                                    // ),
                                    // focusedErrorBorder: OutlineInputBorder(
                                    //   // borderRadius: BorderRadius.circular(9.0),
                                    // ),
                                  ),
                                  selectedItem: _controller.deptList
                                      .where((p0) =>
                                          p0.id ==
                                          _controller.selectedDept
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

                //       Padding(
                //   padding:
                //       EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                //   child: Text(
                //     "Reporting officer",
                //     style: Theme.of(context)
                //         .textTheme
                //         .labelMedium!
                //         .copyWith(color: Colors.black),
                //   ),
                // ),
                // Obx(
                //   () => _controller.allMagngerList.length != 0
                //       ? Padding(
                //           padding: EdgeInsets.symmetric(horizontal: 28.w),
                //           child: DropdownSearch<Datum>(
                //             dropdownBuilder: (context, selectedItem) {
                //               return Text(
                //                 selectedItem!.firstName.toString(),
                //                 style: Theme.of(context)
                //                     .textTheme
                //                     .bodyMedium, // Customize the text style here
                //               );
                //             },
                //             popupItemBuilder: (context, item, isSelected) {
                //               return ListTile(
                //                 title: Text(
                //                   item.firstName.toString(),
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .bodyMedium, // Customize the text style here
                //                 ),
                //               );
                //             },
                //             validator: (value) {
                //               if (value == null || value == "") {
                //                 return "Please select manager";
                //               }
                //             },
                //             onChanged: (value) {
                //               _controller.selecteMangerID.value = value!.id!;
                //               print(_controller.selecteMangerID);
                //             },
                //             selectedItem: _controller.allMagngerList
                //                 .where((p0) => true)
                //                 .first,
                //             mode: Mode.MENU,
                //             items: _controller.allMagngerList,
                //             dropdownSearchDecoration: InputDecoration(
                //               contentPadding: EdgeInsets.symmetric(
                //                   horizontal: 10.w, vertical: 7.h),
                //               border: OutlineInputBorder(
                //                   borderSide: BorderSide(
                //                       width: 1, color: Colors.black)),
                //               enabledBorder: OutlineInputBorder(
                //                   borderSide: BorderSide(
                //                       width: 1, color: Colors.black)),
                //               hintText: "Select Manager",
                //             ),
                //           ),
                //         )
                //       : Center(
                //           child: CircularProgressIndicator(
                //           color: ColorConstant.primaryDark,
                //         )),
                // ),


                 Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Shift",
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
                        child: _controller.shiftTimeList.length != 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: DropdownSearch<Shift>(
                                  items: _controller.shiftTimeList.value,
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
                                      return "Please select a Shift";
                                    }
                                  },
                                  itemAsString: (item) => item!.name.toString(),
                                  onChanged: (Shift? newValue) {
                                    // managerProfileController.selectedGender.value = newValue!;
                                    _controller.selectedShift.value =
                                        newValue!.id!.toInt();
                                    print(_controller.selectedShift);
                                  },
                                  mode: Mode.MENU,

                                  dropdownSearchDecoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 7.h),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                        // borderRadius: BorderRadius.circular(9.0),
                                        ),
                                    hintText: "Select Shift",
                                    // errorBorder: OutlineInputBorder(
                                    //   // borderRadius: BorderRadius.circular(9.0),
                                    // ),
                                    // focusedErrorBorder: OutlineInputBorder(
                                    //   // borderRadius: BorderRadius.circular(9.0),
                                    // ),
                                  ),
                                  selectedItem: _controller.shiftTimeList
                                      .where((p0) =>
                                          p0.id ==
                                          _controller.selectedShift
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
                // shift time end

                // weekly off policy
                  Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Week Off Policy",
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
                        child: _controller.weekOffPolicyList.length != 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: DropdownSearch<WeekOff>(
                                  items: _controller.weekOffPolicyList.value,
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
                                      return "Please select a Week";
                                    }
                                  },
                                  itemAsString: (item) => item!.name.toString(),
                                  onChanged: (WeekOff? newValue) {
                                    // managerProfileController.selectedGender.value = newValue!;
                                    _controller.selectdWeek.value =
                                        newValue!.id!.toInt();
                                    print(_controller.selectdWeek);
                                  },
                                  mode: Mode.MENU,

                                  dropdownSearchDecoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 7.h),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none
                                        // borderRadius: BorderRadius.circular(9.0),
                                        ),
                                    hintText: "Select Week",
                                    // errorBorder: OutlineInputBorder(
                                    //   // borderRadius: BorderRadius.circular(9.0),
                                    // ),
                                    // focusedErrorBorder: OutlineInputBorder(
                                    //   // borderRadius: BorderRadius.circular(9.0),
                                    // ),
                                  ),
                                  selectedItem: _controller.weekOffPolicyList
                                      .where((p0) =>
                                          p0.id ==
                                          _controller.selectdWeek
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
                //weekly off end
                 

                 Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Local Address",
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
                    lableText: "Enter local address",
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Local Enter Address";
                      }
                    },
                    controller: _controller.addressController,
                  ),
                ),

   
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                  child: Text(
                    "Home Address",
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
                    controller: _controller.homeAddressController,
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
                          controller: _controller.passwordController,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please Enter Password";
                            }
                          },
                          isPassword: true,
                          ),
                    ),

                    //Confirm password
                    
                  ],
                ),
                
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
                      EdgeInsets.only(top: 18.0.h, left: 37.0.w, bottom: 7.0.h),
                  child: Text(
                    "Confirm Password",
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
                          controller: _controller.confirmpassword,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please Enter Password";
                            }
                            if (value != _controller.confirmpassword.text) {
                    return "Passwords do not match";
                  }
                          },
                          isPassword: true,
                          ),
                    ),

                    //Confirm password
                    
                  ],
                ),

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
