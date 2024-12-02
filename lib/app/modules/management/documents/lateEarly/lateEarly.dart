import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/modules/management/documents/lateEarly/lateEarlyDetails.dart';
import 'package:nable_ess/app/modules/management/profile/controller.dart';

import '../../../../core/values/colors.dart';
import '../../../../core/values/images.dart';
import '../../../../data/providers/apis_provider.dart';

class LateEarlyAllUsers extends StatelessWidget {
  LateEarlyAllUsers({super.key});

final profileStaffController = Get.put(ProfileManagementController());
//  final LateEarlyNotificationController lateEarlyNotification = Get.find<LateEarlyNotificationController>();
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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // print(lateEarlyNotification.lateEarlyListNew);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black87,
        ),
        centerTitle: true,
        title: Text(
          "Requested Late/Early",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body:
      Obx(() {
        
        return profileStaffController.lateEarlyListNew.isNotEmpty
            ? ListView.builder(
                itemCount: profileStaffController.lateEarlyListNew.length,
                itemBuilder: (context, index) {
                   var status = profileStaffController.lateEarlyListNew[index].status;
                  var lateEarlyData = profileStaffController.lateEarlyListNew[index];
                  var user = profileStaffController.user[0]; 

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                    child: InkWell(
                      onTap: ()  {
                        profileStaffController.updateLateSeenStatus(
                                  profileStaffController.lateEarlyListNew[index].id);
                       
                        Get.to(LateEarlyDetails(
                                object: profileStaffController.lateEarlyListNew[index],
                              ));
                        
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
                                          backgroundImage:NetworkImage( APIsProvider.mediaBaseUrl +
                                                    profileStaffController
                                                        .lateEarlyListNew[index]
                                                        .user!
                                                        .profileImage
                                                        .toString()),
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
                                          "${lateEarlyData.user!.firstName}",
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
                                    Container(
                                                decoration: BoxDecoration(
                                                    color: ColorConstant
                                                        .secondaryLight,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7.r)),
                                                child: profileStaffController
                                                            .lateEarlyListNew[
                                                                index].seen
                                                            == false
                                                      
                                                    ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.w,
                                                                vertical: 3.h),
                                                        child: Text(
                                                          "New",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                        ),
                                                      )
                                                    : SizedBox(),
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
                                      "Time: ${convertToAmPmFormat(lateEarlyData.time)} ",
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

                                     SizedBox(
                                          height: 10.h,
                                        ),
                                        lateEarlyData.status.toString() == "Pending"
                                            ? Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      profileStaffController
                                                          .requestLateApprovelApi(
                                                              profileStaffController
                                                                  .lateEarlyListNew[
                                                                      index]
                                                                  .id);
                                                    },
                                                    child: Container(
                                                      height: 24.h,
                                                      width: 60.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors.green),
                                                      child: Center(
                                                        child: Text(
                                                          "Approve",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 30.w,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      profileStaffController
                                                          .requestLateDeclineApi(
                                                              profileStaffController
                                                                  .lateEarlyListNew[
                                                                      index]
                                                                  .id);
                                                    },
                                                    child: Container(
                                                      height: 24.h,
                                                      width: 60.w,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Colors
                                                              .orange[900]),
                                                      child: Center(
                                                        child: Text(
                                                          "Decline".toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : SizedBox(),
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

  Color getColorForLeaveStatus(String leaveStatus) {
    switch (leaveStatus) {
      case "Approved":
        return Colors.green;
      case "Pending":
        return Colors.blue;
      case "Declined":
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ActionButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 24.h,
        width: 80.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
