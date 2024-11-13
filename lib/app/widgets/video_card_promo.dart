import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nable_ess/app/data/providers/apis_provider.dart';

import '../core/values/colors.dart';

// ignore: must_be_immutable
class VideoCardListing extends StatelessWidget {
  String? text_name;
  String? text_desc;
  String? text_thumb;
  String? videoUrl;
  String? date;
  String? userName;

  VideoCardListing(
      {super.key,
      this.text_name,
      this.text_desc,
      this.text_thumb,
      this.videoUrl,
      this.date,
      this.userName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        height: 180.h,
        width: double.infinity,
        decoration: BoxDecoration(),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 10.h),
              child: Card(
                elevation: 0,
                child: Container(
                  height: 175.h,
                  width: 90.w,
                  child: Container(
                    decoration: BoxDecoration(
                        // color: Color(0xffff7b01),
                        // color: Color(0xff0a81b8),
                        color: Colors.transparent,
                        // gradient: LinearGradient(colors: [
                        //   Color(0xffff7b01),
                        //   Color(0xff0a81b8),
                        //   Color(0xffff7b01),
                        //   // Color(0xff0a81b8),
                        // ]),
                        borderRadius: BorderRadius.circular(4.r)),
                    child: Image(
                      image: NetworkImage(
                          APIsProvider.mediaBaseUrl + text_thumb.toString()),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.h, bottom: 3.h),
                        child: Text(
                          text_name.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "$date",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.h, bottom: 29.h),
                    child: Text(
                      userName != null ? userName.toString() : '',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: ColorConstant.grey, fontSize: 14.sp),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.h, bottom: 29.h),
                    child: Text(
                      text_desc.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: ColorConstant.grey, fontSize: 14.sp),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
