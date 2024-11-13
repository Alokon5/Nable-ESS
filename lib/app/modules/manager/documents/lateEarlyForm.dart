import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/modules/manager/profile/controller.dart';
import 'package:nable_ess/app/modules/staff/profile/controller.dart';

class LateEarlyFormM extends StatelessWidget {
  LateEarlyFormM({super.key});
  final profileStaffController = Get.put(StaffProfileController());

  @override
  Widget build(BuildContext context) {
    printInfo(info: "this is ApplyLeaveForm staff");
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
                  height: 60.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Text(
                        "Late/Early Date",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Late/Early Time",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.black),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: InkWell(
                            onTap: () async {
                              final selectedTime = TimeOfDay.now();

                              final selectedTimeNow = await showTimePicker(
                                  context: context, initialTime: selectedTime);
                              if (selectedTimeNow != null &&
                                  selectedTimeNow != selectedTime) {
                                int hour = selectedTime.hour;
                                int minute = selectedTime.minute;

                                String amPm =
                                    (selectedTimeNow.hour < 12) ? 'AM' : 'PM';

                                if (hour >= 12) {
                                  if (hour > 12) {
                                    hour -= 12;
                                  }
                                } else if (hour == 0) {
                                  hour = 12;
                                }
                                profileStaffController
                                        .lateEarlyTimeController.text =
                                    "${selectedTimeNow.hour}:${selectedTimeNow.minute}  $amPm";

                                printInfo(
                                    info:
                                        "selected time -=--=-=--=-=-${selectedTimeNow}");
                              }
                              // if (selectedDate != null) {
                              //   var date =
                              //       selectedDate.toString().split(' ')[0];
                              //   // leaveController.dateFrom.text = date.toString();
                              //   // leaveController.leaveFormKey.currentState!.validate();
                              //   // _controller.updateSelectedDate(selectedDate.toString());
                              // }
                            },
                            child: IgnorePointer(
                              child: TextFormField(
                                controller: profileStaffController
                                    .lateEarlyTimeController,
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return "Please Select time";
                                  }
                                  return null;
                                },
                                // controller: leaveController.leaveDescription,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                style: Theme.of(context).textTheme.titleSmall,
                                decoration: InputDecoration(
                                  hintText: "Select time...",
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
                      ),
                    ],
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
}
