import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/management/clockIn/controller.dart';
import 'package:nable_ess/app/modules/management/clockIn/outInTimeCard.dart';
import 'package:nable_ess/app/modules/management/clockIn/summaryCard.dart';

class ClockInView extends StatelessWidget {
  ClockInView({super.key});
  var clockInController = Get.put(ClockInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return clockInController.allEmployeesList.length != 0
              ? Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                    ),
                    itemCount: clockInController.allEmployeesList.length,
                    itemBuilder: (context, index) {
                      // return VideoContainer(user_name: "Kuldeep");

                      return InkWell(
                        onTap: () async {
                          // Get.to(() => SingleProfile(),
                          //     transition: Transition.leftToRight);
                          await clockInController.singleUserDataF(
                              clockInController.allEmployeesList[index].id);

                          // Get.bottomSheet(SingleProfile());
                          Get.dialog(
                            dialogWidget(context),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r)),
                                height: 60.h,
                                width: 60.h,
                                child: clockInController.allEmployeesList[index]
                                                .profileImage ==
                                            null ||
                                        clockInController
                                                .allEmployeesList[index]
                                                .profileImage ==
                                            ""
                                    ? CircleAvatar(
                                        radius: 35.r,
                                        child: Image(
                                            image: AssetImage(
                                                ImageConstant.maleProfile)),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                        APIsProvider.mediaBaseUrl +
                                            clockInController
                                                .allEmployeesList[index]
                                                .profileImage
                                                .toString(),
                                      )),
                              ),
                              Expanded(
                                child: Container(
                                  width: 100.w,
                                  
                                  // decoration: BoxDecoration(
                                  //     // border: Border.all(),
                                  //     ),
                                  child: Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 6.w),
                                      child: Text(
                                        "${clockInController.allEmployeesList[index].firstName} ${clockInController.allEmployeesList[index].lastName}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: ColorConstant.primaryDark,
                ));
        }),
      ),
    );
  }

  dialogWidget(context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10, bottom: 50.h),
      child: Container(
        decoration: BoxDecoration(
            color: ColorConstant.backgroud,
            borderRadius: BorderRadius.circular(25.r)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: AppBar(
                leading: Obx(
                  () {
                    return clockInController.isLoading == false
                        ? Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r)),
                            height: 60.h,
                            width: 60.h,
                            child: clockInController
                                            .singleUserData()
                                            .profileImage ==
                                        null ||
                                    clockInController
                                            .singleUserData()
                                            .profileImage ==
                                        ""
                                ? CircleAvatar(
                                    radius: 35.r,
                                    child: Image(
                                        image: AssetImage(
                                            ImageConstant.maleProfile)),
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      APIsProvider.mediaBaseUrl +
                                          clockInController
                                              .singleUserData()
                                              .profileImage
                                              .toString(),
                                    ),
                                  ),
                          )
                        : CircularProgressIndicator(
                            color: ColorConstant.primaryDark,
                          );
                  },
                ),
                title: Obx(
                  () {
                    return clockInController.isLoading == false
                        ? Text(
                            "${clockInController.singleUserData().firstName} ${clockInController.singleUserData().lastName}",
                            style: Theme.of(context).textTheme.bodyMedium)
                        : CircularProgressIndicator(
                            color: ColorConstant.primaryDark,
                          );
                  },
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 25.sp,
                        color: Colors.blueAccent,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 1.2.h,
            ),
            Container(
              // color: Color(0xfff5f5f5),
              color: Colors.grey[300],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 3.w),
                        child: Text(
                          "From Date",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 130.w,
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
                              var date = selectedDate.toString().split(' ')[0];
                              clockInController.startDateFilter.text =
                                  date.toString();
                              // leaveController.leaveFormKey.currentState!.validate();
                              // _controller.updateSelectedDate(selectedDate.toString());
                              clockInController.generateDateList(
                                  clockInController.startDateFilter.text,
                                  clockInController.endDateFilter.text);
                              print(
                                  "Selected Date -=-=-------------------${clockInController.startDateFilter.text}");
                            }
                          },
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: clockInController.startDateFilter,
                              enabled: false,
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                              decoration: InputDecoration(
                                prefix: Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    size: 17.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // VerticalDivider(
                  //   width: 2.2.w,
                  //   color: Colors.black87,
                  // ),
                  Container(
                    width: 1.2.w,
                    height: 30.h,
                    color: Colors.black87,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5.h, left: 3.w),
                        child: Text(
                          "To Date",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 130.w,
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
                              var date = selectedDate.toString().split(' ')[0];
                              clockInController.endDateFilter.text =
                                  date.toString();
                              // leaveController.leaveFormKey.currentState!.validate();
                              // _controller.updateSelectedDate(selectedDate.toString());
                              clockInController.generateDateList(
                                  clockInController.startDateFilter.text,
                                  clockInController.endDateFilter.text);
                              print(
                                  "Selected Date -=-=----------------End---${clockInController.endDateFilter.text}");
                            }
                          },
                          child: IgnorePointer(
                            child: TextFormField(
                              controller: clockInController.endDateFilter,
                              enabled: false,
                              style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                              decoration: InputDecoration(
                                prefix: Padding(
                                  padding: EdgeInsets.only(right: 5.w),
                                  child: Icon(
                                    Icons.calendar_month_outlined,
                                    size: 17.sp,
                                  ),
                                ),
                                contentPadding: EdgeInsets.only(
                                  left: 12.w,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              // child: InkWell(
              child: Obx(() {
                return SummaryCard(
                  tillDate: clockInController.endDateFilter.text,
                  presentDs: clockInController.workFilteredHorsMinList.length
                      .toString(),
                  workHours: clockInController.totalWorkHrsMins.toString(),
                  absentDs: clockInController.noOfAbsent.toString(),
                  daysWorked: clockInController.workFilteredHorsMinList.length
                      .toString(),
                );
              }),
            ),
            Divider(),
            Obx(() {
              return Expanded(
                  child: ListView.builder(
                itemCount: clockInController.workFilteredHorsMinList.length,
                itemBuilder: (context, index) => OutInTimeCard(
                  workDate:
                      clockInController.workFilteredHorsMinList[index].date,
                  checkInTime: clockInController
                      .workFilteredHorsMinList[index].checkInTime,
                  checkOutTime: clockInController
                      .workFilteredHorsMinList[index].checkOutTime,
                  totalWorkHrs: clockInController
                      .workFilteredHorsMinList[index].totalhrsminDay,
                ),
              ));
            }),
            SizedBox(
              height: 6.h,
            )
          ],
        ),
      ),
    );
  }
}
