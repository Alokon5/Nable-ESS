import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/modules/manager/profile/controller.dart';
import 'package:nable_ess/app/modules/staff/profile/controller.dart';
import 'package:open_file/open_file.dart';

class LateEarlyFormM extends StatelessWidget {
  LateEarlyFormM({super.key});
  final profileStaffController = Get.put(StaffProfileController());
    final List<String> options = [
    "------------------",
    "Late Coming",
    "Early Going"
  ];

  @override
  Widget build(BuildContext context) {
    printInfo(info: "this is ApplyLeaveForm manger");
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
          "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   centerTitle: true,
      //   title: Text(
      //     "Late/Early",
      //     style: Theme.of(context).textTheme.titleMedium,
      //   ),
      //   backgroundColor: Color(0xff4472c4),
      // ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: profileStaffController.lateEarlyFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xff4472c4),
                        borderRadius: BorderRadius.circular(6.r)),
                    child: Center(
                      child: Text(
                        "Late/Early",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Late / Early *",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(height: 5.h,),
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                   child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: profileStaffController.lateEarlyDropdownController.text.isEmpty
                        ? options[0]
                        : profileStaffController.lateEarlyDropdownController.text,
                    items: options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null && value != options[0]) {
                        print("Selected value: $value");
                        profileStaffController.lateEarlyDropdownController.text = value;
                      }
                    },
                    validator: (value) {
                      if (value == null || value == options[0]) {
                        return "Please select an option";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    ),
                    style: Theme.of(context).textTheme.titleSmall,
                                   ),
                 ),
                 SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Late/Early Date",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(height: 5.h,),
                      Padding(
                        padding: EdgeInsets.only(),
                        child: InkWell(
                          onTap: () async {
                            final currentDate = DateTime.now();
                            final selectedDate = await showDatePicker(
                              context: context,
                              initialDate: currentDate,
                              firstDate:
                                  currentDate.subtract(Duration(days: 40)),
                              lastDate: DateTime(2100),
                            );
                            if (selectedDate != null) {
                              var date =
                                  selectedDate.toString().split(' ')[0];
                              profileStaffController.lateEarlyDateController
                                  .text = date.toString();
                              // leaveController.leaveFormKey.currentState!.validate();
                              // _controller.updateSelectedDate(selectedDate.toString());
                            }
                          },
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: profileStaffController
                                  .lateEarlyDateController,
                              validator: (value) {
                                if (value == null || value == "") {
                                  return "Please Select Date";
                                }
                                return null;
                              },
                              // controller: leaveController.leaveDescription,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              style: Theme.of(context).textTheme.titleSmall,
                              decoration: InputDecoration(
                                hintText: "Select Date...",
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
                    ],
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Late/Early Time",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(height: 5.h,),
                Padding(
                   padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: InkWell(
                    onTap: () async {
                    final selectedTime = TimeOfDay.now();
                    final selectedTimeNow = await showTimePicker(
                        context: context, initialTime: selectedTime);
                  
                    if (selectedTimeNow != null) {
                      // Store time in 24-hour format for backend
                      // String time24Hour = "${selectedTimeNow.hour}:${selectedTimeNow.minute.toString().padLeft(2, '0')}";
                  
                      // Format time in 12-hour format for display in the app
                      int hour = selectedTimeNow.hour;
                      int minute = selectedTimeNow.minute;
                      String amPm = (hour < 12) ? 'AM' : 'PM';
                      if (hour >= 12) {
                        if (hour > 12) hour -= 12;
                      } else if (hour == 0) hour = 12;
                      
                      // Set the display text
                      profileStaffController.lateEarlyTimeController.text =
                         "${hour}:${minute.toString().padLeft(2, '0')} $amPm";
                      //  print(time24Hour);
                      // Send `time24Hour` to the backend
                      // await sendTimeToBackend(time24Hour);
                    }
                  
                    },
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: profileStaffController.lateEarlyTimeController,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please Select time";
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                          hintText: "Select time...",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.black)),
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
                    "Reason",
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
                        profileStaffController.lateEarlyReasonController,
                    onChanged: (value) {
                      profileStaffController.lateEarlyFormKey.currentState!
                          .validate();
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter Reason";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: null,
                    style: Theme.of(context).textTheme.titleSmall,
                    decoration: InputDecoration(
                        hintText: "Enter Reason ...",
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
   SizedBox(
                  height: 20.h,
                ),

                Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                       
                      child: Text(
                        "Upload Document or Image",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                    ),
                     SizedBox(
                  height: 5.h,
                ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
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
                                  profileStaffController.imageName != ''
                                      ? OpenFile.open(profileStaffController
                                          .imagePathVar.value)
                                      : OpenFile.open(
                                          profileStaffController.pdfPath.value);
                                },
                                child:
                                    profileStaffController.selectedImage.value != null ?

                                    //this profileStaffCOntroller ka bad pdfName.toString()
                                        //         "" ||
                                        //     profileStaffController.imageName
                                        //             .toString() !=
                                        //         ''
                                        // ? (profileStaffController.pdfName
                                        //             .toString() !=
                                        //         ""
                                        //     ? Text(profileStaffController
                                        //         .pdfName.value)
                                        //     :
                                             Text(
                                              profileStaffController
                                               
                                                    .truncateFileName(
                                                        profileStaffController
                                                            .imageName.value,
                                                        17),
                                              )
                                        : Text("File not selected yet."))
                          ],
                        );
                      }),
                    ),

                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 21.h),
                    child:
                        profileStaffController.lateEarlyLoading.value == false
                            ? SizedBox(
                                height: 42.h,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (profileStaffController
                                        .lateEarlyFormKey.currentState!
                                        .validate()) {
                                      // Form is valid, perform desired action
                                      await profileStaffController
                                          .posteLateEarlyData();
                                      print('Form is valid sfsdfsdgsag');
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
      ),
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
              profileStaffController.imageName.value = "";
              profileStaffController.pickPDF();

              Get.back();
            },
          ),
          ElevatedButton(
            child: Text('Image', style: Theme.of(context).textTheme.bodySmall),
            onPressed: () {
              profileStaffController.pdfName.value = '';
              profileStaffController.pickImageFromGallery();

              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
