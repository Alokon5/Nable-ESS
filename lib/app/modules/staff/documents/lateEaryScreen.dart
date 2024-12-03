import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/staff/documents/lateEarlyForm.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';
import '../profile/controller.dart';
import 'package:intl/intl.dart';


class LateEarlyScreen extends StatelessWidget {
  LateEarlyScreen({super.key});

  // Initialize the profileStaffController to access lateEarlyList
  final profileStaffController = Get.put(StaffProfileController());

  // Helper function to convert 24-hour time format to 12-hour format with AM/PM
  String convertToAmPmFormat(String time24Hour) {
    final parts = time24Hour.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    String amPm = (hour >= 12) ? 'PM' : 'AM';
    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;

    return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $amPm";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => LateEarlyForm());
        },
        icon: Icon(Icons.upload_file_rounded,color: ColorConstant.buttonText,),
        label: Text(
          'Apply',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
        backgroundColor: ColorConstant.button,
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black87,
        ),
        title: Text(
          "Late/Early History",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Obx(() {
        // Check if lateEarlyList has any data
        return profileStaffController.lateEarlyListNew.isNotEmpty
            ? ListView.builder(
                itemCount: profileStaffController.lateEarlyListNew.length,
                itemBuilder: (context, index) {
                  // Access the data for the current item
                  var lateEarlyData = profileStaffController.lateEarlyListNew[index];
                  var user = profileStaffController.user[0]; // Assuming you have a user list
                  var status = profileStaffController.lateEarlyListNew[index].status;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                    child: InkWell(
                      onTap: () {
                        // Navigate to detailed view if needed
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xefff0f4f9),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: SizedBox(
                                  height: 50.h,
                                  child: user.photoUrl == null || user.photoUrl == ""
                                      ? Image(image: AssetImage(ImageConstant.maleProfile))
                                      : CircleAvatar(
                                          radius: 25.r,
                                          backgroundColor: ColorConstant.backgroud,
                                          backgroundImage: NetworkImage(
                                              APIsProvider.mediaBaseUrl + user.photoUrl.toString()),
                                        ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Late/Early",
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                        Text("Status:${lateEarlyData.status}",style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: profileStaffController
                                                        .getColorForLeaveStatus(
                                                            status.toString()),
                                                  ),)
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
  "Date: ${DateFormat('dd-MMM-yyyy').format(DateTime.parse(lateEarlyData.date.toString()))}",
  style: Theme.of(context).textTheme.bodySmall,
  overflow: TextOverflow.ellipsis,
),
                                    // SizedBox(width: 5.h,),
                                    Text(
                                      "Time: ${convertToAmPmFormat(lateEarlyData.time)}",
                                      style: Theme.of(context).textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                      ],
                                    ),
                                    
                                    SizedBox(height: 8.h),
                                    Text(
                                      "Reason : ${lateEarlyData.reason}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: ColorConstant.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: Text(
                  "No Data found",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorConstant.grey),
                ),
              );
      }),
    );
  }
}
