// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/manageLeave/base/controller.dart';
import 'package:nable_ess/app/modules/manager/manageLeave/controller.dart';

import '../../../../core/values/colors.dart';
import 'package:badges/badges.dart' as badges;

class LeaveBaseView extends StatelessWidget {
  LeaveBaseView({super.key});
  var leaveController = Get.put(LeaveBaseViewController());
  var leave = Get.put(LeaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.primary,
      body: Obx(() {
        return leaveController.widgetOptions
            .elementAt(leaveController.index.toInt());
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
          onTap: (value) {
            leaveController.getRequestedLeave();
            leaveController.changeChipIndex(value);
            print("value-===================$value");
            if (value == 1) {
              leave.getLeaveList();
            } else if (value == 2) {
              leave.getRequestedLeave();
            }
          },
          currentIndex: leaveController.index.value,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          selectedItemColor: ColorConstant.complimentary,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.quora,
                  size: 24.sp,
                ),
                label: 'Apply'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  size: 24.sp,
                ),
                label: 'Hostory'),
            BottomNavigationBarItem(
                icon: badges.Badge(
                  position: badges.BadgePosition.topEnd(top: -2.h, end: -2.h),
                  showBadge: leaveController.newlyRequestedList.length != 0,
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
                  child: Icon(
                    Icons.notifications,
                    size: 24.sp,
                  ),
                ),
                // icon: Icon(
                //   Icons.notifications,
                //   size: 24.sp,
                // ),
                label: 'Notification'),
          ],
        ),
      ),
    );
  }
}
