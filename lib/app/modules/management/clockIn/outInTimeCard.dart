// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nable_ess/app/core/values/images.dart';
import '../../../core/values/colors.dart';

class OutInTimeCard extends StatelessWidget {
  OutInTimeCard(
      {super.key,
      this.workDate,
      this.checkInTime,
      this.checkOutTime,
      this.totalWorkHrs

      // this.statusCheckIn,
      // this.statusCheckOut,

      // this.iconImage,
      // this.iconImageOut,
      });

  String? workDate;
  String? checkInTime;
  String? checkOutTime;
  String? totalWorkHrs;
  // String? statusCheckIn;
  // String? statusCheckOut;

  // String? iconImage;
  // String? iconImageOut;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                ),
                child: Container(
                  height: 35.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 24.h,
                            child: Image(
                              image: AssetImage(ImageConstant.CheckIn),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${checkInTime}",
                                    style: GoogleFonts.roboto(
                                        color: Color(0xff7aae45),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${workDate}",
                              style: GoogleFonts.roboto(
                                  color: Color(0xff2196f3),
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  height: 35.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 24.h,
                              child: Image(
                                  image: AssetImage(ImageConstant.CheckOut))),
                          Padding(
                            padding: EdgeInsets.only(left: 12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${checkOutTime}",
                                    style: GoogleFonts.roboto(
                                        color: Color(0xffa292f6),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: Text(
                              "Work Hours In a Day",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: ColorConstant.grey,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                          Text("${totalWorkHrs}",
                              // style: Theme.of(context).textTheme.bodyMedium,
                              style: GoogleFonts.roboto(
                                  color: Colors.green,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
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
