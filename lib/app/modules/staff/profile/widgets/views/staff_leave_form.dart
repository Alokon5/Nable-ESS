// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/data/models/leaveModels/leaveTypeModel.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller.dart';

class StaffLeaveForm extends StatelessWidget {
  StaffLeaveForm({super.key});

  var staffProfileController = Get.put(StaffProfileController());

  @override
  Widget build(BuildContext context) {
    // print("staffProfileController-----${staffProfileController.}")
    printInfo(
        info:
            "userId ======${staffProfileController.user[0].id},token=======${staffProfileController.user[0].token}");
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
          "Apply For Leave",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Form(
            key: staffProfileController.editProfileStaffFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 18.0.h, left: 20.w, bottom: 5.0.h),
                      child: Text(
                        "Title",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: TextFormField(
                        controller: staffProfileController.leaveTitleController,
                        onChanged: (value) {
                          staffProfileController
                              .editProfileStaffFormKey.currentState!
                              .validate();
                        },
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please Enter Title";
                          }
                        },
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                          hintText: "Enter Title...",
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          contentPadding: EdgeInsets.only(left: 12.w),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 18.0.h, left: 20.w, bottom: 5.0.h),
                      child: Text(
                        "Description",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: TextFormField(
                        controller:
                            staffProfileController.leaveDescriptionController,
                        onChanged: (value) {
                          staffProfileController
                              .editProfileStaffFormKey.currentState!
                              .validate();
                        },
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please Enter Description";
                          }
                        },
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: null,
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                            hintText: "Enter Description...",
                            isDense: true,
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 12)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 18.0.h, left: 20.w, bottom: 10.0.h),
                      child: Text(
                        "Date From",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: InkWell(
                        onTap: () async {
                          final currentDate = DateTime.now();
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: currentDate,
                            firstDate: currentDate.subtract(Duration(days: 0)),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null) {
                            var date = selectedDate.toString().split(' ')[0];
                            staffProfileController.dateFromController.text =
                                date.toString();
                            staffProfileController
                                .editProfileStaffFormKey.currentState!
                                .validate();
                            // _controller.updateSelectedDate(selectedDate.toString());
                          }
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            controller:
                                staffProfileController.dateFromController,
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please Select Date";
                              }
                            },
                            // controller: staffProfileController.leaveDescription,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            style: Theme.of(context).textTheme.titleSmall,
                            decoration: InputDecoration(
                              hintText: "Select From Date...",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              contentPadding: EdgeInsets.only(left: 12.w),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 18.0.h, left: 20.w, bottom: 5.0.h),
                      child: Text(
                        "Date To",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: InkWell(
                        onTap: () async {
                          final currentDate = DateTime.now();
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: currentDate,
                            firstDate: currentDate.subtract(Duration(days: 0)),
                            lastDate: DateTime(2100),
                          );
                          if (selectedDate != null) {
                            var date = selectedDate.toString().split(' ')[0];
                            staffProfileController.dateToController.text =
                                date.toString();
                            staffProfileController
                                .editProfileStaffFormKey.currentState!
                                .validate();
                          }
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: staffProfileController.dateToController,
                            validator: (value) {
                              if (value == null || value == "") {
                                return "Please Select Date";
                              }
                            },
                            minLines: 1,
                            style: Theme.of(context).textTheme.titleSmall,
                            decoration: InputDecoration(
                              hintText: "Select To Date...",
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                              contentPadding: EdgeInsets.only(left: 12.w),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 18.0.h, left: 20.w, bottom: 5.0.h),
                      child: Text(
                        "Leave Type",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Obx(
                      () => staffProfileController.leaveTypeList.length != 0
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: DropdownSearch<LeaveTypeModel>(
                                dropdownBuilder: (context, selectedItem) {
                                  return Text(
                                    selectedItem!.name.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium, // Customize the text style here
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
                                    return "Please select leaveType";
                                  }
                                },
                                itemAsString: (item) => item!.name.toString(),
                                onChanged: (LeaveTypeModel? newValue) {
                                  // managerProfileController.selectedGender.value = newValue!;
                                  staffProfileController.selecteLeaveType
                                      .value = newValue!.id!.toInt();
                                  print(
                                      staffProfileController.selecteLeaveType);
                                },
                                mode: Mode.MENU,
                                items: staffProfileController.leaveTypeList,
                                dropdownSearchDecoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 7.h),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Colors.black)),
                                  hintText: "Select Leavetype",
                                ),
                                selectedItem: staffProfileController
                                    .leaveTypeList
                                    .where((p0) =>
                                        p0.id ==
                                        staffProfileController.selecteLeaveType
                                            .toInt())
                                    .first,
                                // showSelectedItems: true,
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                              color: ColorConstant.primaryDark,
                            )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 18.0.h, left: 20.w, bottom: 5.0.h),
                      child: Text(
                        "Upload Document or Image",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                      ),
                      child: Obx(() {
                        return Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  showDialogUpload(context);
                                },
                                child: Text("Choose file")),
                            TextButton(
                                onPressed: () async {
                                  staffProfileController.imageName != ''
                                      ? OpenFile.open(staffProfileController
                                          .imagePathVar.value)
                                      : OpenFile.open(
                                          staffProfileController.pdfPath.value);
                                },
                                child:
                                    staffProfileController.pdfName.toString() !=
                                                "" ||
                                            staffProfileController.imageName
                                                    .toString() !=
                                                ''
                                        ? (staffProfileController.pdfName
                                                    .toString() !=
                                                ""
                                            ? Text(staffProfileController
                                                .pdfName.value)
                                            : Text(
                                                staffProfileController
                                                    .truncateFileName(
                                                        staffProfileController
                                                            .imageName.value,
                                                        17),
                                              ))
                                        : Text("File not selected yet."))
                          ],
                        );
                      }),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
                Obx(() {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 21.h),
                    child: staffProfileController.isLoading.value == false
                        ? Container(
                            height: 42.h,
                            constraints: BoxConstraints(maxHeight: 42.h),
                            child: ElevatedButton(
                              onPressed: () {
                                print(
                                    "staffProfileController.date from---${staffProfileController.dateFromController.text}");
                                if (staffProfileController
                                    .editProfileStaffFormKey.currentState!
                                    .validate()) {
                                  // Form is valid, perform desired action
                                  print('Form is valid');
                                  staffProfileController.applyForLeave();
                                } else {
                                  Get.snackbar(
                                      "Empty", "Some fields may be empty?");
                                }
                              },
                              child: Center(
                                child: Text("Submit"),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.button,
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
      )),
    );
  }

  showDialogUpload(context) {
    Get.dialog(
      AlertDialog(
        title: Text('Select File Type ',
            style: Theme.of(context).textTheme.bodyLarge),
        actions: [
          TextButton(
            child: Text('Cancel', style: Theme.of(context).textTheme.bodySmall),
            onPressed: () {
              Get.back();
            },
          ),
          ElevatedButton(
            child: Text('PDF', style: Theme.of(context).textTheme.bodySmall),
            onPressed: () {
              staffProfileController.imageName.value = "";
              staffProfileController.pickPDF();

              Get.back();
            },
          ),
          ElevatedButton(
            child: Text('Image', style: Theme.of(context).textTheme.bodySmall),
            onPressed: () {
              staffProfileController.pdfName.value = '';
              staffProfileController.pickImageFromGallery();

              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
