// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/values/colors.dart';

class CheckInOutHistory extends StatelessWidget {
  CheckInOutHistory({
    super.key,
    this.checkInDate,
    this.checkInTime,
    this.checkOutDate,
    this.checkOutTime,
    this.statusCheckIn,
    this.statusCheckOut,
    this.title,
    this.iconImage,
    this.iconImageOut,
  });

  String? checkInDate;
  String? checkInTime;
  String? checkOutDate;
  String? checkOutTime;
  String? statusCheckIn;
  String? statusCheckOut;
  String? title;

  String? iconImage;
  String? iconImageOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 23.h),
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
                        image: AssetImage(iconImage!),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 7.h),
                            child: Text(
                              "$title",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Text(
                            "${checkInDate}",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: ColorConstant.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 7.h),
                      child: Text(
                        "${checkInTime}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      "$statusCheckIn",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: ColorConstant.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
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
                        child: Image(image: AssetImage(iconImageOut!))),
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 7.h),
                            child: Text(
                              "Check Out",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          Text(
                            "${checkOutDate}",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: ColorConstant.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 7.h),
                      child: Text(
                        "${checkOutTime}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    Text(
                      "$statusCheckOut",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: ColorConstant.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
