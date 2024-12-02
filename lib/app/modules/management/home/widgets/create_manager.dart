// ignore_for_file: body_might_complete_normally_nullable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/models/deptModel/deptModel.dart';
import 'package:nable_ess/app/data/models/designationModel/designationModel.dart';
import 'package:nable_ess/app/data/models/weeklyOffPolicy/weeklyOffPolicy.dart';
import 'package:nable_ess/app/data/models/weeklyShiftModel/weeklyShiftModel.dart';
import 'package:nable_ess/app/modules/management/home/controller.dart';

import '../../../../core/values/colors.dart';
import '../../../../widgets/text_form.dart';

class CreateManagerForm extends StatefulWidget {
  CreateManagerForm({super.key});

  @override
  State<CreateManagerForm> createState() => _CreateManagerFormState();
}

class _CreateManagerFormState extends State<CreateManagerForm> {
  final homeManageMentController = Get.put(HomeManagementController());

   Future<void> _selectDateB(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Earliest selectable date
      lastDate: DateTime.now(), // Latest selectable date
    );

    if (pickedDate != null) {
      setState(() {
        homeManageMentController.dobController.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
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
        homeManageMentController.joinedDateController.text = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
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
          "Create Reporting Officer",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: homeManageMentController.createManagerFormKey,
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
                    controller: homeManageMentController.firstName,
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
                    controller: homeManageMentController.lastName,
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
                    controller: homeManageMentController.email,
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
                    controller: homeManageMentController.mobileNumberController,
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
                    controller: homeManageMentController.alternateNumberController,
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
                                  controller: homeManageMentController.dobController,
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
                                  onTap: () => _selectDateB(context), // Show date picker on tap
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
                    controller: homeManageMentController.fatherName,
                  ),
                ),

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
                    controller: homeManageMentController.fatherNumber,
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
                          return "Please Enter Date of Joining";
                        }
                      },
                      maxLines: 1,
                                  controller: homeManageMentController.joinedDateController,
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
                    controller: homeManageMentController.bloodController,
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
                      value: homeManageMentController.selectedGender.value,
                      onChanged: (String? newValue) {
                        homeManageMentController.selectedGender.value = newValue!;
                      },
                      items: homeManageMentController.genderItems,
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
                      value: homeManageMentController.selectMaritalStatus.value,
                      onChanged: (String? newValue) {
                        homeManageMentController.selectMaritalStatus.value = newValue!;
                        print(homeManageMentController.selectMaritalStatus);
                      },
                      items: homeManageMentController.maritalItems,
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
                  ),
                ),
                //maerital status end

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
                        child: homeManageMentController.deptList.length != 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: DropdownSearch<DepartModel>(
                                  items: homeManageMentController.deptList.value,
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
                                    homeManageMentController.selectedDept.value =
                                        newValue!.id!.toInt();
                                  print("dept ${homeManageMentController.selectedDept.value}");
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
                                  selectedItem: homeManageMentController.deptList
                                      .where((p0) =>
                                          p0.id ==
                                          homeManageMentController.selectedDept
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
                //dept end






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
                        child: homeManageMentController.desgnationList.length != 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: DropdownSearch<DesignationModel>(
                                  items: homeManageMentController.desgnationList.value,
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
                                    homeManageMentController.selectedDesignation.value =
                                        newValue!.id!.toInt();
                                    print("designantion ${homeManageMentController.selectedDesignation}");
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
                                  selectedItem: homeManageMentController.desgnationList
                                      .where((p0) =>
                                          p0.id ==
                                          homeManageMentController.selectedDesignation
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
                        child: homeManageMentController.shiftTimeList.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: DropdownSearch<Shift>(
                                  items: homeManageMentController.shiftTimeList.value,
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
                                    homeManageMentController.selectedShift.value =
                                        newValue!.id!.toInt();
                                   print(" selected shift ${homeManageMentController.selectedShift}");
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
                                  selectedItem: homeManageMentController.shiftTimeList
                                      .where((p0) =>
                                          p0.id ==
                                          homeManageMentController.selectedShift
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
                        child: homeManageMentController.weekOffPolicyList.length != 0
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: DropdownSearch<WeekOff>(
                                  items: homeManageMentController.weekOffPolicyList.value,
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
                                    homeManageMentController.selectdWeek.value =
                                        newValue!.id!.toInt();
                                    print(" selected week ${homeManageMentController.selectdWeek}");
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
                                  selectedItem: homeManageMentController.weekOffPolicyList
                                      .where((p0) =>
                                          p0.id ==
                                          homeManageMentController.selectdWeek
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
                    controller: homeManageMentController.addressController,
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
                    controller: homeManageMentController.homeAddressController,
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
                              // validator: (value) {
                              //   if (value == null || value == "") {
                              //     return "Please Enter Latitude";
                              //   }
                              // },
                              controller: homeManageMentController
                                  .mobileNumberController,
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
                              // validator: (value) {
                              //   if (value == null || value == "") {
                              //     return "Please Enter Longitude";
                              //   }
                              // },
                              controller: homeManageMentController
                                  .mobileNumberController,
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
                          controller: homeManageMentController.password,
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
                //         homeManageMentController.updateSelectedDate(selectedDate.toString());
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
                //     "Designation",
                //     style: Theme.of(context)
                //         .textTheme
                //         .labelMedium!
                //         .copyWith(color: Colors.black),
                //   ),
                // ),
                // Obx(() {
                //   return Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 28.w),
                //       child: Container(
                //         decoration: BoxDecoration(
                //             border: Border.all(color: ColorConstant.grey),
                //             borderRadius: BorderRadius.circular(9.r)),
                //         child: Center(
                //           child: homeManageMentController
                //                       .desgnationList.length !=
                //                   0
                //               ? Padding(
                //                   padding: EdgeInsets.symmetric(vertical: 4.h),
                //                   child: DropdownSearch<DesignationModel>(
                //                     items: homeManageMentController
                //                         .desgnationList.value,
                //                     dropdownBuilder: (context, selectedItem) {
                //                       return SizedBox(
                //                         child: Text(
                //                           selectedItem!.name.toString(),
                //                           style: Theme.of(context)
                //                               .textTheme
                //                               .bodyMedium, // Customize the text style here
                //                         ),
                //                       );
                //                     },
                //                     popupItemBuilder:
                //                         (context, item, isSelected) {
                //                       return ListTile(
                //                         title: Text(
                //                           item.name.toString(),
                //                           style: Theme.of(context)
                //                               .textTheme
                //                               .bodyMedium, // Customize the text style here
                //                         ),
                //                       );
                //                     },
                //                     validator: (value) {
                //                       if (value == null || value == "") {
                //                         return "Please select a Designation";
                //                       }
                //                     },
                //                     itemAsString: (item) =>
                //                         item!.name.toString(),
                //                     onChanged: (DesignationModel? newValue) {
                //                       // managerProfileController.selectedGender.value = newValue!;
                //                       homeManageMentController
                //                           .selectedDesignation
                //                           .value = newValue!.id!.toInt();
                //                       print(homeManageMentController
                //                           .selectedDepartments);
                //                     },
                //                     mode: Mode.MENU,

                //                     dropdownSearchDecoration: InputDecoration(
                //                       contentPadding: EdgeInsets.symmetric(
                //                           horizontal: 10.w, vertical: 7.h),
                //                       border: OutlineInputBorder(
                //                           borderSide: BorderSide.none
                //                           // borderRadius: BorderRadius.circular(9.0),
                //                           ),
                //                       hintText: "Select Designation",
                //                       // errorBorder: OutlineInputBorder(
                //                       //   // borderRadius: BorderRadius.circular(9.0),
                //                       // ),
                //                       // focusedErrorBorder: OutlineInputBorder(
                //                       //   // borderRadius: BorderRadius.circular(9.0),
                //                       // ),
                //                     ),
                //                     selectedItem: homeManageMentController
                //                         .desgnationList
                //                         .where((p0) =>
                //                             p0.id ==
                //                             homeManageMentController
                //                                 .selectedDesignation
                //                                 .toInt())
                //                         .first,
                //                     // showSelectedItems: true,
                //                   ),
                //                 )
                //               : CircularProgressIndicator(
                //                   color: ColorConstant.primaryDark,
                //                 ),
                //         ),
                //       ));
                // }),
                // Padding(
                //   padding:
                //       EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 7.0.h),
                //   child: Text(
                //     "Gender",
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
                //       value: homeManageMentController.selectedGender.value,
                //       onChanged: (String? newValue) {
                //         homeManageMentController.selectedGender.value =
                //             newValue!;
                //       },
                //       items: homeManageMentController.genderItems,
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
                //       value: homeManageMentController.selectedDepartments.value,
                //       onChanged: (String? newValue) {
                //         homeManageMentController.selectedDepartments.value = newValue!;
                //       },
                //       items: homeManageMentController.departmentItems,
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
                          controller: homeManageMentController.confirmpassword,
                          validator: (value) {
                            if (value == null || value == "") {
                              return "Please Enter Password";
                            }
                            if (value != homeManageMentController.password.text) {
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
                    child: homeManageMentController.isLoading.value == false
                        ? SizedBox(
                            height: 42.h,
                            child: ElevatedButton(
                              onPressed: () {
                                if (homeManageMentController
                                    .createManagerFormKey.currentState!
                                    .validate()) {
                                  // Form is valid, perform desired action
                                  homeManageMentController.creatManager();
                                  print('Form is valid');
                                }
                              },
                              child: Center(
                                child: Text("Create Reporting Officer"),
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
