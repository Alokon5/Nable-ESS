import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/values/colors.dart';

class SummaryCard extends StatelessWidget {
  SummaryCard(
      {super.key,
      this.tillDate,
      this.presentDs,
      this.absentDs,
      this.daysWorked,
      this.hrsWorked,
      this.workHours});

  String? tillDate;
  String? presentDs;
  String? absentDs;
  String? daysWorked;
  String? hrsWorked;
  String? workHours;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 120.h,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  "Summary ",
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "till",
                  style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  "${tillDate}",
                  style: GoogleFonts.roboto(
                      fontSize: 14.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PRESENT DAYS",
                      style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          color: ColorConstant.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "${presentDs} DAYS",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Work Hours",
                      style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          color: ColorConstant.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "${workHours}",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ABSENT DAYS",
                      style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          color: ColorConstant.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "$absentDs DAYS",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DAYS WORKED",
                      style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          color: ColorConstant.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "${daysWorked} DAYS",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  width: 50.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "HRS WORKED",
                      style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          color: ColorConstant.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "300h 00m",
                      style: GoogleFonts.roboto(
                          fontSize: 14.sp,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
