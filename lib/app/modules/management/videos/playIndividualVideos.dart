import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/videos/widgets/show_videos.dart';

import '../usersDetails/controller.dart';

class PlayIndividualVideos extends StatelessWidget {
  int? comeIn;
  PlayIndividualVideos({super.key,this.comeIn});
  // var staffController = Get.put(UsersController());
  var staffController = Get.find<UsersController>();



  @override
  Future<bool> _onWillPop() async {
    printInfo(info: "this is back button ------$comeIn");
    await staffController.playVideosController.dispose();
    // await staffController.getUserDetails(userIdArgu);
    Get.back();
    // Handle the back button press here
    // You can perform custom actions or show a snackbar
    // If enough time hasn't passed since the last back button press, exit the app
    return true;
  }

  Widget build(BuildContext context) {

    return Scaffold(
    
      body: GetBuilder<UsersController>(
        init: UsersController(),
        builder: (controller) {
          return ListView.builder(
            itemCount: 1,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var video = controller.userVideos[comeIn!.toInt()];
              print("video details ====${video.toJson()}");
            
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    VideoShowWidget(
                      video: video.video.toString(),
                      // title: video.title.toString(),
                      // description: video.description.toString(),
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
