// ignore_for_file: must_be_immutable, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/videos/staffUserProfileViews/widgets/show_videos.dart';

import '../controller.dart';

class PlayVideosStaff extends StatelessWidget {
  final int? comeIn;
  PlayVideosStaff({super.key, this.comeIn});
  var staffController = Get.put(StaffVideocontroller());
  @override
  Future<bool> _onWillPop() async {
    print("ho gaya");
    await staffController.playVideosController.dispose();
    await staffController.playVideosController.pause();
    Get.back();
    return true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StaffVideocontroller>(
        init: StaffVideocontroller(),
        builder: (controller) {
          return ListView.builder(
            itemCount: 1,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final video = staffController.videoList[comeIn!.toInt()];
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    VideoShowWidget(
                      video: video.video,
                      title: video.title,
                      description: video.description,
                    ),
                    Positioned(
                      bottom: 84.h,
                      left: 16.w,
                      right: 16.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.title.toString(),
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                shadows: [
                                  Shadow(
                                    color: Colors.white,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ]),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            video.description.toString(),
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.black,
                                shadows: [
                                  Shadow(
                                    color: Colors.white,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
