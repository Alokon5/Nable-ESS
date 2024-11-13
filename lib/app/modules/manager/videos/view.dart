import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/modules/manager/home/manager_form.dart';
import 'package:nable_ess/app/modules/manager/videos/controller.dart';
import 'package:nable_ess/app/routes/route.dart';

import '../../management/usersDetails/widgets/videos_container.dart';

class StaffList extends StatelessWidget {
  StaffList({super.key});
  final staffListController = Get.put(StaffVideocontroller());
  @override
  Widget build(BuildContext context) {
    // staffListController.getStaffs();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Staffs",
          style: TextStyle(color: ColorConstant.primaryDark),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Get.to(() => ManagerForm());
        },
        child: CircleAvatar(
            radius: 25.r,
            backgroundColor: ColorConstant.primary,
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
      ),
      body: Obx(() {
        return staffListController.staffsListed.length != 0
            ? SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                    ),
                    itemCount: staffListController.staffsListed.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await staffListController.getUserDetails(
                              staffListController.staffsListed[index].id);

                          Get.toNamed(AppRoutes.staffProfileVideos);

                          // print(
                          //     "${staffListController.staffsListed[index].id} ,hello i am  ${staffListController.staffsListed[index].firstName} ${staffListController.staffsListed[index].id} ");
                        },
                        child: VideoContainer(
                          user_name:
                              "${staffListController.staffsListed[index].firstName} ${staffListController.staffsListed[index].lastName}",
                          profileImage: staffListController
                              .staffsListed[index].profileImage,
                          status:
                              staffListController.staffsListed[index].status,
                        ),
                      );
                    },
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                color: ColorConstant.primaryDark,
              ));
      }),
    );
  }
}
