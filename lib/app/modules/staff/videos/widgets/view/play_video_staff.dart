// ignore_for_file: must_be_immutable, unused_element, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/models/userDetailsModel.dart';

import '../../controller.dart';
import '../staff_show_videos.dart';

class StaffVideoPlay extends StatelessWidget {
  final int ? comeIn;
  final Video? object;
  StaffVideoPlay({super.key,this.comeIn,this.object});
  var videoController = Get.put(VideoController());
  @override
  Future<bool> _onWillPop() async {
    print("this is back button");
    await videoController.playVideosController.pause();
    Get.back();
    return true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Videos",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: GetBuilder<VideoController>(
        init: VideoController(),
        builder: (controller) {
          return ListView.builder(
            itemCount: 1,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              // final video = controller.videoList[comeIn!.toInt()];
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    StaffVideoShowWidget(
                      video: object!.video,
                      title: object!.title,
                      description: object!.description,
                    ),
                    Positioned(
                      bottom: 84.h,
                      left: 16.w,
                      right: 16.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            object!.title.toString(),
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
                            object!.description.toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 2,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
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
