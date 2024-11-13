import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/images.dart';
import '../../../core/values/colors.dart';
import '../home/controller.dart';
import '../profile/controller.dart';
import '../videos/controller.dart';
import 'controller.dart';
import 'package:badges/badges.dart' as badges;

// ignore: must_be_immutable
class ManagerBase extends StatelessWidget {
  ManagerBase({super.key});

// var managementBaseController = Get.find<ManagementController>();
  var managerBaseController = Get.put(ManagerController());

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
          return managerBaseController.widgetOptions
              .elementAt(managerBaseController.index.toInt());
        }),
        // floatingActionButton: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     SizedBox(),
        //     CircleAvatar(
        //       radius: 25.r,
        //       backgroundColor: ColorConstant.complimentaryLight,
        //       child: Icon(Icons.add,size: 25.sp,),),
        //       SizedBox(),
        //   ],
        // ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (value) async {
              await managerBaseController.getRequestedLeave();
              managerBaseController.changeChipIndex(value);
              if (value == 0) {
                var home = Get.put(HomeManagerController());
                home.onInit();
              } else {
                // await Get.delete<HomeManagerController>();
              }
              if (value == 1) {
                var staffController = await Get.put(StaffVideocontroller());
                staffController.getStaffs();
              } else {
                // Get.delete<StaffVideocontroller>();
              }
              if (value == 3) {
                var home = Get.put(HomeManagerController());
                home.onInit();
              }
              if (value == 4) {
                var managerProfileController =
                    Get.put(ProfileManagerController());
                managerProfileController.onInit();
              } else {
                // Get.delete<ProfileManagerController>();
              }

              print("value-===================$value");
            },
            currentIndex: managerBaseController.index.value,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            selectedItemColor: ColorConstant.complimentary,
            items: [
              BottomNavigationBarItem(
                  icon: Image(
                    height: 20.h,
                    width: 40.w,
                    image: AssetImage(ImageConstant.homeIcon),
                    fit: BoxFit.contain,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                // icon: Icon(
                //   Icons.video_collection_outlined,
                //   size: 24.sp,
                // ),
                icon: Icon(
                  Icons.group_outlined,
                  size: 21.sp,
                  color: Colors.black87,
                ),
                label: 'Staffs',
              ),
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
                    image: AssetImage(ImageConstant.clockIcon),
                    fit: BoxFit.contain,
                  ),
                  // icon: Icon(
                  //   Icons.group,
                  //   size: 24.sp,
                  // ),
                  label: 'Clock In'),
              BottomNavigationBarItem(
                  icon: badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -2.h, end: -2.h),
                    showBadge:
                        managerBaseController.newRequestedLeave.length != 0,
                    ignorePointer: false,
                    onTap: () {},
                    badgeAnimation: badges.BadgeAnimation.rotation(
                      animationDuration: Duration(seconds: 1),
                      colorChangeAnimationDuration: Duration(seconds: 1),
                      loopAnimation: false,
                      curve: Curves.fastOutSlowIn,
                      colorChangeAnimationCurve: Curves.easeInCubic,
                    ),
                    badgeStyle: badges.BadgeStyle(
                      // shape: badges.BadgeShape.instagram,
                      badgeColor: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                      elevation: 0,
                    ),
                    child: Image(
                      height: 20.h,
                      width: 40.w,
                      image: AssetImage(ImageConstant.documentsIcon),
                      fit: BoxFit.contain,
                    ),
                  ),
                  // icon: Icon(
                  //   Icons.person,
                  //   size: 24.sp,
                  // ),
                  label: 'Documents'),
            ],
          ),
        ),
      ),
    );
  }
}
