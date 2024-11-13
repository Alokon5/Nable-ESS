import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:nable_ess/app/widgets/video_card_promo.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';

class VideoCardPromo extends StatelessWidget {
  const VideoCardPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.black,
        ),
        title: Text(
          "My Videos",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      children: [
                        Container(
                          height: 176.0.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 135.h,
                                width: double.infinity,
                                color: Color(0xeFFF0F4F9),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 53.h),
                                      child: Text(
                                        "Suraj Patel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 11.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Manager",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            child: Text("|"),
                                          ),
                                          Text(
                                            "Department",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundColor: ColorConstant.backgroud,
                      radius: 42.r,
                      child: CircleAvatar(
                        radius: 38.r,
                        child: Image(
                          image: AssetImage(ImageConstant.maleProfile),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                child: VideoCardListing(
                  text_name: "Nable ESS",
                  text_desc: "Lorem Ipsum is simply",
                  text_thumb: "Video Thumbnail",
                  date: "2023-07-01",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: VideoCardListing(
                  text_name: "Nable ESS",
                  text_desc: "Lorem Ipsum is simply",
                  text_thumb: "Video Thumbnail",
                  date: "2023-07-01",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                child: VideoCardListing(
                  text_name: "Nable ESS",
                  text_desc: "Lorem Ipsum is simply",
                  text_thumb: "Video Thumbnail",
                  date: "2023-07-01",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
