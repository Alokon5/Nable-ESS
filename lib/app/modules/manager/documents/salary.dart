import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/staff_salary_model.dart';
import 'package:nable_ess/app/modules/manager/profile/controller.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';
import '../profile/profileManager.dart';

class SalaryScreen extends StatelessWidget {
  SalaryScreen({super.key});
  final managerProfileController = Get.put(ProfileManagerController());
  @override
  Widget build(BuildContext context) {
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
          "Salary",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return managerProfileController.user.length != 0
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${managerProfileController.user[0].displayName.toString()}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 24.h),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => ProfileManager());
                              },
                              child: managerProfileController
                                              .user[0].photoUrl ==
                                          null ||
                                      managerProfileController
                                              .user[0].photoUrl ==
                                          ""
                                  ? CircleAvatar(
                                      backgroundImage:
                                          AssetImage(ImageConstant.maleProfile),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          APIsProvider.mediaBaseUrl +
                                              managerProfileController
                                                  .user[0].photoUrl!),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10.w),
                    //   child: Align(
                    //     alignment: Alignment.topLeft,
                    //     child: Image(
                    //       height: 100.h,
                    //       width: 100.w,
                    //       image: AssetImage(ImageConstant.Logo),
                    //       fit: BoxFit.contain,
                    //     ),
                    //   ),
                    // ),
                    Divider(),
                     Padding(
                padding: const EdgeInsets.all(16.0),
                child: Obx(() {
                  if (managerProfileController.isLoading.value) {
                    return Center(child: const CircularProgressIndicator());
                  }

                  // Handle error if there's any
                  if (managerProfileController.errorMessage.isNotEmpty) {
                    return Center(
                        child: Text(managerProfileController.errorMessage.value));
                  }

                  // If no salary data available
                  if (managerProfileController.salaryList.isEmpty) {
                    return Center(child: const Text('No salary data available.'));
                  }

                  // Display the salary list if available
                  return ListView.builder(
                    shrinkWrap: true, // Allow ListView to take up only the space it needs
                    itemCount: managerProfileController.salaryList.length,
                    itemBuilder: (context, index) {
                      StaffSalaryModel salary =
                          managerProfileController.salaryList[index];

                      return Card(
    margin: EdgeInsets.symmetric(vertical: 8.h),
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Salary Month
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('MMMM yyyy').format(salary.salaryMonth),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Net Salary: ${salary.netCurrentSalary} ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.primaryDark,
                    ),
              ),
            ],
          ),
          SizedBox(height: 8.h),

          // Staff Name
          Text(
            '${salary!.staff!.firstName} ${salary!.staff!.lastName} ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 8.h),

          // Salary Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailRow('Total Days', salary.totalDays.toString()),
                  _detailRow('Present Days', salary.presentDays.toString()),
                  _detailRow('Absent Days', salary.absent.toString()),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailRow('Week Offs', salary.weekOff.toString()),
                  _detailRow('Holidays', salary.holiday.toString()),
                  _detailRow('Payable Days', salary.payableDays.toString()),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
                    },
                  );
                }),
              ),
                    // Expanded(
                    //     child: ListView.builder(
                    //   itemCount: 20,
                    //   itemBuilder: (context, index) {
                    //     return Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 25.w),
                    //       child: Card(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(15.r)),
                    //         child: SizedBox(
                    //           height: 50.h,
                    //           width: double.infinity,
                    //           child: Center(
                    //             child: Padding(
                    //               padding:
                    //                   EdgeInsets.symmetric(horizontal: 12.w),
                    //               child: Row(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.center,
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.center,
                    //                     children: [
                    //                       Text(
                    //                         "November",
                    //                         style: Theme.of(context)
                    //                             .textTheme
                    //                             .bodySmall,
                    //                       ),
                    //                       SizedBox(height: 3.h),
                    //                       Text(
                    //                         "2023",
                    //                         style: TextStyle(
                    //                             color: Colors.black54,
                    //                             fontSize: 10.sp),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   Text(
                    //                     "4,568.23 \$",
                    //                     style: Theme.of(context)
                    //                         .textTheme
                    //                         .bodyMedium,
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // )),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: ColorConstant.primaryDark,
                ));
        }),
      ),
    );
  }
}

 Widget _detailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14.sp, color: Colors.black54),
          ),
        ],
      ),
    );
  }
