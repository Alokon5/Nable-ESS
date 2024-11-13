import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/modules/management/base/controller.dart';
import 'package:nable_ess/app/modules/management/clockIn/controller.dart';
import 'package:nable_ess/app/modules/management/home/controller.dart';

import '../../../core/values/colors.dart';
import '../profile/controller.dart';
import '../usersDetails/controller.dart';

// ignore: must_be_immutable
class ManagementBase extends StatelessWidget {
  ManagementBase({super.key});

// var managementBaseController = Get.find<ManagementController>();
  var managementBaseController = Get.put(ManagementController());

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
          return managementBaseController.widgetOptions
              .elementAt(managementBaseController.index.toInt());
        }),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: (value) async {
              await managementBaseController.getRequestedLeave();
              if (value == 0) {
                var homeManagementController =
                    await Get.put(HomeManagementController());
                // await homeManagementController.getEmplyeesDetails();

                homeManagementController.onInit();
              } else {
                await Get.delete<HomeManagementController>();
              }
              if (value == 1) {
                var homeManagementController =
                    await Get.put(HomeManagementController());
                // await homeManagementController.getEmplyeesDetails();

                homeManagementController.onInit();
              } else {
                await Get.delete<HomeManagementController>();
              }
              if (value == 2) {
                var videoLibController = await Get.put(UsersController());

                videoLibController.onInit();
              } else {
                //  await Get.delete<UsersController>();
              }
              if (value == 3) {
                await Get.put(ClockInController());
              } else {
                //  await Get.delete<ProfileManagementController>();
                // await Get.delete<ClockInController>();
              }
              if (value == 4) {
                var managementProfileController =
                    await Get.put(ProfileManagementController());
                managementProfileController.onInit();
              } else {
                //  await Get.delete<ProfileManagementController>();
              }
              managementBaseController.changeChipIndex(value);
              // print("value-===================$value");
            },
            currentIndex: managementBaseController.index.value,
            showUnselectedLabels: false,
            showSelectedLabels: true,
            selectedItemColor: ColorConstant.complimentary,
            items: [
              BottomNavigationBarItem(
                // icon: Icon(
                //   Icons.home,
                //   size: 24.sp,
                // ),
                icon: Image(
                  height: 20.h,
                  width: 40.w,
                  image: AssetImage(ImageConstant.homeIcon),
                  fit: BoxFit.contain,
                ),
                label: 'HOME',
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
                label: 'VLOG',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.group_outlined,
                  color: Colors.black,
                  size: 21.sp,
                ),
                // icon: Image(
                //   height: 30.h,
                //   width: 40.w,
                //   image: AssetImage(ImageConstant.clockIcon),
                //   fit: BoxFit.contain,
                // ),
                label: 'EMPLOYEES',
              ),
              BottomNavigationBarItem(
                icon: Image(
                  height: 20.h,
                  width: 40.w,
                  image: AssetImage(ImageConstant.clockIcon),
                  fit: BoxFit.contain,
                ),
                label: 'CLOCKIN',
              ),
              BottomNavigationBarItem(
  icon: Badge.count(
    count: managementBaseController.newRequestList.length,
    isLabelVisible: managementBaseController.newRequestList.isNotEmpty,
    alignment: Alignment.topRight,
    child: Image(
      height: 20.h,
      width: 40.w, 
      image: AssetImage(ImageConstant.documentsIcon),
      fit: BoxFit.contain,
    ),
  ),
  label: 'DOCUMENTS',
),

            ],
          ),
        ),
      ),
    );
  }
}
