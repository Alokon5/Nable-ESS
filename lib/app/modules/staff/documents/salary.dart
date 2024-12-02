import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nable_ess/app/data/models/staff_salary_model.dart';
import 'package:nable_ess/app/modules/staff/profile/controller.dart';
import 'package:intl/intl.dart'; // Added for date formatting
import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';
import '../profile/view.dart';

class SalaryScreen extends StatelessWidget {
  SalaryScreen({super.key});
  final profileStaffController = Get.put(StaffProfileController());


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
          "Salary Screen",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body:SafeArea(
        child: Obx(() {
          return profileStaffController.user.isNotEmpty
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
                                  "${profileStaffController.user[0].displayName.toString()}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 24.h),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => StaffProfile());
                              },
                              child: profileStaffController
                                              .user[0].photoUrl ==
                                          null ||
                                      profileStaffController
                                              .user[0].photoUrl ==
                                          ""
                                  ? CircleAvatar(
                                      backgroundImage:
                                          AssetImage(ImageConstant.maleProfile),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          APIsProvider.mediaBaseUrl +
                                              profileStaffController
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
                  // if (profileStaffController.isLoading.value) {
                  //   return Center(child: const CircularProgressIndicator());
                  // }

                  // Handle error if there's any
                  // if (profileStaffController.errorMessage.isNotEmpty) {
                  //   return Center(
                  //       child: Text(profileStaffController.errorMessage.value));
                  // }

                  // If no salary data available
                  if (profileStaffController.salaryList.isEmpty) {
                    return Center(child: const Text('No salary data available.'));
                  }

                  // Display the salary list if available
                  return ListView.builder(
                    shrinkWrap: true, // Allow ListView to take up only the space it needs
                    itemCount: profileStaffController.salaryList.length,
                    itemBuilder: (context, index) {
                      StaffSalaryModel salary =
                          profileStaffController.salaryList[index];

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Display the formatted date on the left
                              Text(
                                DateFormat('MMM yyyy').format(salary.salaryMonth),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              // Display the net salary on the right
                              Text(
                                'Net Salary: ${salary.netCurrentSalary}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
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
