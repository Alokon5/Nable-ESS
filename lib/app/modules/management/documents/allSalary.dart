import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/staff_salary_model.dart';
import 'package:nable_ess/app/modules/manager/profile/controller.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';

class AllSalaryPage extends StatelessWidget {
  AllSalaryPage({super.key});
  final managerProfileController = Get.put(ProfileManagerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black87,
        ),
        centerTitle: true,
        title: Text(
          "All Salaries",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          if (managerProfileController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: ColorConstant.button),
            );
          }

          // if (managerProfileController.errorMessage.isNotEmpty) {
          //   return Center(
          //     child: Text(
          //      "error",
          //       style: TextStyle(color: Colors.red, fontSize: 16.sp),
          //     ),
          //   );
          // }

          if (managerProfileController.salaryList.isEmpty) {
            return Center(
              child: Text(
                '',
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: managerProfileController.salaryList.length,
            itemBuilder: (context, index) {
  StaffSalaryModel salary = managerProfileController.salaryList[index];

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
}
,
          );
        }),
      ),
    );
  }

  // Helper method to create detail rows
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
}
