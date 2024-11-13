import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/values/colors.dart';
import '../../../../../core/values/images.dart';
import '../../../../../data/providers/apis_provider.dart';
import '../../controller.dart';

class ShowLeaveHistoryData extends StatelessWidget {
  ShowLeaveHistoryData({super.key});

  final StaffProfileController profileController =
      Get.put(StaffProfileController());

  @override
  Widget build(BuildContext context) {
    var leaveItem = Get.arguments;
    print("leaveItem.title -=p=-=-=-==-- ${leaveItem!.title}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Show Details Of Leave",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    // height: 450.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xeFFF0F4F9),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 39.h, bottom: 12.h),
                          child: Center(
                            child: profileController.user[0].photoUrl == null ||
                                    profileController.user[0].photoUrl == ""
                                ? CircleAvatar(
                                    backgroundColor: ColorConstant.backgroud,
                                    radius: 28.5.r,
                                    child: Image(
                                      image:
                                          AssetImage(ImageConstant.maleProfile),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: ColorConstant.backgroud,
                                    radius: 28.5.r,
                                    backgroundImage: NetworkImage(
                                        APIsProvider.mediaBaseUrl +
                                            profileController.user[0].photoUrl
                                                .toString()),
                                  ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 32.h),
                          child: Text(
                            "Leave Request",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22.w, vertical: 19.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Title:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "${leaveItem!.title}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "From Date:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "${leaveItem!.fromDate}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22.w, vertical: 19.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "To Date:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "${leaveItem!.toDate}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Leave Type:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    "${leaveItem.leaveType!.name}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 19.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              child: Row(
                                children: [
                                  Text(
                                    "Description:",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 5.h),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              // height: 90.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.0.h),
                                child: Text(
                                  "${leaveItem!.description}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 5.h),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "Status: ${leaveItem!.status}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: profileController
                                            .getColorForLeaveStatus(
                                                leaveItem!.status),
                                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
