import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nable_ess/app/modules/staff/profile/controller.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';
import '../profile/view.dart';

class SalaryScreen extends StatelessWidget {
  SalaryScreen({super.key});
  final profileStaffController = Get.put(StaffProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black87,
        ),
        centerTitle: true,
        title: Text(
          "",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: Obx(() {
          return profileStaffController.user.length != 0
              ? Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${profileStaffController.user[0].displayName.toString()}",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 24.h),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => StaffProfile());
                              },
                              child: profileStaffController.user[0].photoUrl ==
                                          null ||
                                      profileStaffController.user[0].photoUrl ==
                                          ""
                                  ? CircleAvatar(
                                      backgroundImage:
                                          AssetImage(ImageConstant.maleProfile),
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          APIsProvider.mediaBaseUrl +
                                              profileStaffController
                                                  .user[0].photoUrl!),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Image(
                          height: 100.h,
                          width: 100.w,
                          image: AssetImage(ImageConstant.Logo),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color(0xff08b8b6),
                            borderRadius: BorderRadius.circular(0.r)),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12.h,
                              ),
                              Text(
                                "Last Month Salary",
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 17.sp),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text(
                                "December 2023",
                                style: GoogleFonts.roboto(
                                    color: Colors.white, fontSize: 13.sp),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "4,568.23 \$",
                                    style: GoogleFonts.roboto(
                                        color: Colors.white, fontSize: 30.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12.h,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                            child: SizedBox(
                              height: 50.h,
                              width: double.infinity,
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "November",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          SizedBox(height: 3.h),
                                          Text(
                                            "2023",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 10.sp),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "4,568.23 \$",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: ColorConstant.primaryDark,
                ));
        }),
      ),
    );
  }
}
