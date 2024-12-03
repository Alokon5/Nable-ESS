// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/data/models/leaveModels/leaveTypeModel.dart';
import 'package:nable_ess/app/modules/manager/manageLeave/controller.dart';
import 'package:open_file/open_file.dart';

import '../../../../core/values/images.dart';
import '../../../../data/providers/apis_provider.dart';

class LeaveForm extends StatelessWidget {
  LeaveForm({super.key});

  var leaveController = Get.find<LeaveController>();

  @override
  Widget build(BuildContext context) {
    // print("leaveController-----${leaveController.}")
    printInfo(
        info:
            "userId ========${leaveController.user[0].id}, token---=-=-=-=-=-${leaveController.user[0].token}");
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
            key: leaveController.leaveFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 20.w, bottom: 5.0.h),
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
                    controller: leaveController.leaveTitle,
                    onChanged: (value) {
                      leaveController.leaveFormKey.currentState!.validate();
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
                              BorderSide(width: 1, color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      contentPadding: EdgeInsets.only(left: 12.w),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 20.w, bottom: 5.0.h),
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
                    controller: leaveController.leaveDescription,
                    onChanged: (value) {
                      leaveController.leaveFormKey.currentState!.validate();
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
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 20.w, bottom: 10.0.h),
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
                        leaveController.dateFrom.text = date.toString();
                        leaveController.leaveFormKey.currentState!.validate();
                        // _controller.updateSelectedDate(selectedDate.toString());
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: leaveController.dateFrom,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please Select Date";
                          }
                        },
                        // controller: leaveController.leaveDescription,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                          hintText: "Select From Date...",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          contentPadding: EdgeInsets.only(left: 12.w),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 20.w, bottom: 5.0.h),
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
                        leaveController.dateTo.text = date.toString();
                        leaveController.leaveFormKey.currentState!.validate();
                      }
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        controller: leaveController.dateTo,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please Select Date";
                          }
                        },
                        minLines: 1,
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                          hintText: "Select Date To...",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          contentPadding: EdgeInsets.only(left: 12.w),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 18.0.h, left: 20.w, bottom: 5.0.h),
                  child: Text(
                    "Leave Type",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                Obx(
                  () => leaveController.leaveTypeList.length != 0
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
                              leaveController.selecteLeaveType.value =
                                  newValue!.id!.toInt();
                              // print(leaveController.selecteLeaveType);
                            },
                            mode: Mode.MENU,
                            items: leaveController.leaveTypeList,
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
                            selectedItem: leaveController.leaveTypeList
                                .where((p0) =>
                                    p0.id ==
                                    leaveController.selecteLeaveType.toInt())
                                .first,
                            // showSelectedItems: true,
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                          color: ColorConstant.primaryDark,
                        )),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 25.h),
                //   child: Stack(
                //     children: [
                //       Center(
                //         child: staffProfileController.selectedImage.value !=
                //                 null
                //             ? CircleAvatar(
                //                 backgroundColor: ColorConstant.backgroud,
                //                 radius: 42.r,
                //                 child: ClipOval(
                //                   child: SizedBox(
                //                     width: 76.w,
                //                     height: 76.h,
                //                     child: Image.file(
                //                       File(staffProfileController
                //                           .selectedImage.value!.path),
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             : staffProfileController.user[0].photoUrl == null ||
                //                     staffProfileController.user[0].photoUrl ==
                //                         ""
                //                 ? CircleAvatar(
                //                     backgroundColor: ColorConstant.backgroud,
                //                     radius: 42.r,
                //                     child: ClipOval(
                //                       child: SizedBox(
                //                         width: 76.w,
                //                         height: 76.h,
                //                         child: staffProfileController
                //                                         .selectedGender ==
                //                                     "Male" ||
                //                                 staffProfileController
                //                                         .selectedGender ==
                //                                     "male"
                //                             ? Image(
                //                                 image: AssetImage(
                //                                     ImageConstant.maleProfile),
                //                               )
                //                             : Image(
                //                                 image: AssetImage(ImageConstant
                //                                     .femaleProfile),
                //                               ),
                //                       ),
                //                     ),
                //                   )
                //                 : CircleAvatar(
                //                     backgroundColor: ColorConstant.backgroud,
                //                     radius: 42.r,
                //                     backgroundImage: NetworkImage(
                //                       APIsProvider.mediaBaseUrl +
                //                           staffProfileController
                //                               .user[0].photoUrl
                //                               .toString(),
                //                     ),
                //                   ),
                //       ),
                //       Padding(
                //         padding: EdgeInsets.only(left: 56.w, top: 50.h),
                //         child: Center(
                //           child: CircleAvatar(
                //             radius: 15.r,
                //             child: IconButton(
                //               onPressed: () {
                //                 // staffProfileController
                //                 //     .pickImageFromGallery();
                //               },
                //               icon: Icon(
                //                 Icons.edit,
                //                 size: 16.sp,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                 
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
                                  leaveController.imageName != ''
                                      ? OpenFile.open(leaveController
                                          .imagePathVar.value)
                                      : OpenFile.open(
                                          leaveController.pdfPath.value);
                                },
                                child:
                                    leaveController.selectedImage.value != null ?
                                                // "" ||
                                        //     staffProfileController.imageName
                                        //             .toString() !=
                                        //         ''
                                        // ? (staffProfileController.pdfName
                                        //             .toString() !=
                                        //         ""
                                        //     ? Text(staffProfileController
                                        //         .pdfName.value)
                                        //     
                                         Text(
                                                leaveController
                                                    .truncateFileName(
                                                        leaveController
                                                            .imageName.value,
                                                        17),
                                              )
                                        : Text("File not selected yet."))
                          ],
                        );
                      }),
                    ),

                SizedBox(
                  height: 8.h,
                ),
                Obx(() {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 21.h),
                    child: leaveController.isLoading.value == false
                        ? SizedBox(
                            height: 42.h,
                            child: ElevatedButton(
                              onPressed: () {
                                if (leaveController.leaveFormKey.currentState!
                                    .validate()) {
                                  // Form is valid, perform desired action
                                  print('Form is valid');
                                  leaveController.applyForLeave();
                                } else {
                                  Get.snackbar(
                                      "Empty", "Some fields may be empty?");
                                }
                              },
                              child: Center(
                                child: Text("Submit",style: TextStyle(color: ColorConstant.buttonText ),),
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
              leaveController.imageName.value = "";
              leaveController.pickPDF();

              Get.back();
            },
          ),
          ElevatedButton(
            child: Text('Image', style: Theme.of(context).textTheme.bodySmall),
            onPressed: () {
              leaveController.pdfName.value = '';
              leaveController.pickImageFromGallery();

              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
