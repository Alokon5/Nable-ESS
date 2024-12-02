import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/modules/staff/home/controller.dart';
import 'package:nable_ess/app/modules/staff/videos/controller.dart';

import '../../../core/values/colors.dart';
import 'controller.dart';

// ignore: must_be_immutable
class StaffBase extends StatelessWidget {
  StaffBase({super.key});

  var staffController = Get.put(StaffController());
  DateTime? _currentBackPressTime;

  Future<bool> _onWillPop() async {
    print("this is back button");
    // Handle the back button press here
    // You can perform custom actions or show a snackbar
    // If enough time hasn't passed since the last back button press, exit the app
    if (_currentBackPressTime == null ||
        DateTime.now().difference(_currentBackPressTime!) >
            Duration(seconds: 2)) {
      _currentBackPressTime = DateTime.now();
      Get.snackbar("Press back again to exit", "");
      return false; // Prevent back navigation for now
    } else {
      SystemNavigator.pop();
      return true; // Allow back navigation
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: ColorConstant.primary,
        body: Obx(() {
          return staffController.widgetOptions
              .elementAt(staffController.index.toInt());
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (value) async {
              if (value == 0 || value == 2) {
                var homeController = await Get.put(StaffHomeController());
                homeController.onInit();
              } else {
                await Get.delete<StaffHomeController>();
              }
              if (value == 1) {
                var videoController = Get.put(VideoController());
                videoController.onInit();
              } else {
                Get.delete<VideoController>();
              }
              staffController.changeChipIndex(value);

              print("value-===================$value");
            },
            currentIndex: staffController.index.value,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            unselectedItemColor: ColorConstant.primary,
            selectedItemColor: ColorConstant.complimentary,
            items: [
              BottomNavigationBarItem(
                  icon: Image(
                    height: 20.h,
                    width: 40.w,
                    image: AssetImage(ImageConstant.clockIcon),
                    fit: BoxFit.contain,
                  ),
                  label: 'Clock In'),
              // BottomNavigationBarItem(
              //     icon: Icon(
              //       Icons.video_camera_back_outlined,
              //       size: 22.sp,
              //     ),
              //     label: 'Upload Task'),
              BottomNavigationBarItem(
                // icon: Icon(
                //   Icons.video_collection_outlined,
                //   size: 24.sp,
                // ),
                icon: Image(
                  height: 20.h,
                  width: 40.w,
                  image: AssetImage(ImageConstant.vlogIcon),
                  fit: BoxFit.contain,
                ),
                label: 'Vlog',
              ),
              BottomNavigationBarItem(
                  icon: Image(
                    height: 20.h,
                    width: 40.w,
                    image: AssetImage(ImageConstant.homeIcon
                    ),
                    fit: BoxFit.contain,
                  ),
                  // icon: Icon(
                  //   Icons.group,
                  //   size: 24.sp,
                  // ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Image(
                    height: 20.h,
                    width: 40.w,
                    image: AssetImage(ImageConstant.documentsIcon),
                    fit: BoxFit.contain,
                  ),
                  label: 'Documents'),
            ],
          ),
        ),
      ),
    );
  }
}
