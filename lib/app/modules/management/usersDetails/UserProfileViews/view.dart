import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/mediaPlayer/playShortVideos.dart';
import 'package:nable_ess/app/core/mediaPlayer/playStaffVideos.dart';
import 'package:nable_ess/app/modules/management/usersDetails/controller.dart';
import 'package:nable_ess/app/routes/route.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';

import 'package:nable_ess/app/widgets/video_card_promo.dart';

import '../../../../core/values/colors.dart';
import '../../../../core/values/images.dart';
import '../../videos/playIndividualVideos.dart';

class UserProfileVideos extends StatelessWidget {
  UserProfileVideos({super.key});

  var stafffUserController = Get.put(UsersController());

  Future<bool> _onWillPop() async {
    print("this is back button");
    stafffUserController.fetchUsers();

    Get.back();
    // Handle the back button press here
    // You can perform custom actions or show a snackbar
    // If enough time hasn't passed since the last back button press, exit the app
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              stafffUserController.fetchUsers();
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Details",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: SafeArea(
            child: stafffUserController.userDetails != null
                ? Obx(() {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Column(
                                children: [
                                  Container(
                                    height: 263.0.h,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 221.h,
                                          width: double.infinity,
                                          color: Color(0xeFFF0F4F9),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 59.h),
                                                child: Text(
                                                  "${stafffUserController.userDetails!.firstName} ${stafffUserController.userDetails!.lastName}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 11.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    stafffUserController
                                                                .userDetails!
                                                                .designation !=
                                                            null
                                                        ? Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.w),
                                                            child: Text(
                                                              "${stafffUserController.userDetails!.designation != null ? stafffUserController.getDesignationNameViaId(stafffUserController.userDetails!.designation) : ""}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    stafffUserController
                                                                .userDetails!
                                                                .designation !=
                                                            null
                                                        ? Text(
                                                            "|",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          )
                                                        : SizedBox(),
                                                    stafffUserController
                                                                .userDetails!
                                                                .userType !=
                                                            null
                                                        ? Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.w),
                                                            child: Text(
                                                              "${stafffUserController.userDetails!.userType}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                    stafffUserController
                                                                .userDetails!
                                                                .userType !=
                                                            null
                                                        ? Text(
                                                            "|",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall,
                                                          )
                                                        : SizedBox(),
                                                    stafffUserController
                                                                .userDetails!
                                                                .joinedDate !=
                                                            null
                                                        ? Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        4.w),
                                                            child: Text(
                                                              "${stafffUserController.userDetails!.joinedDate != null ? stafffUserController.dateTimeFormator(stafffUserController.userDetails!.joinedDate).date : ""}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.h),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 47.w),
                                                      child: Icon(
                                                        Icons.email_outlined,
                                                        size: 13.sp,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.w),
                                                      child: Text(
                                                        "${stafffUserController.userDetails!.email}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              stafffUserController.userDetails!
                                                          .phoneNumber !=
                                                      null
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 8.h),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 47.w),
                                                            child: Icon(
                                                              Icons
                                                                  .phone_android_outlined,
                                                              size: 13.sp,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12.w),
                                                            child: Text(
                                                              "+91 ${stafffUserController.userDetails!.phoneNumber}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              stafffUserController.userDetails!
                                                          .gender !=
                                                      null
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 8.h),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 47.w),
                                                            child: Icon(
                                                              stafffUserController
                                                                              .userDetails!
                                                                              .gender ==
                                                                          "Male" ||
                                                                      stafffUserController
                                                                              .userDetails!
                                                                              .gender ==
                                                                          "male"
                                                                  ? Icons
                                                                      .male_rounded
                                                                  : Icons
                                                                      .female_rounded,
                                                              size: 13.sp,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        12.w),
                                                            child: stafffUserController
                                                                        .userDetails!
                                                                        .gender !=
                                                                    null
                                                                ? Text(
                                                                    "${stafffUserController.userDetails!.gender}",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall,
                                                                  )
                                                                : SizedBox(),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox(),
                                              stafffUserController.userDetails!
                                                          .address !=
                                                      null
                                                  ? Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 47.w),
                                                          child: Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            size: 13.sp,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12.w),
                                                          child: Container(
                                                            width: 210.w,
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Text(
                                                              "${stafffUserController.userDetails!.address}",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox(),
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
                              child: stafffUserController
                                              .userDetails!.profileImage ==
                                          null ||
                                      stafffUserController
                                              .userDetails!.profileImage ==
                                          ""
                                  ? CircleAvatar(
                                      radius: 38.r,
                                      child: Image(
                                        image: AssetImage(
                                            ImageConstant.maleProfile),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 38.r,
                                      backgroundImage: NetworkImage(
                                          APIsProvider.mediaBaseUrl +
                                              stafffUserController
                                                  .userDetails!.profileImage
                                                  .toString()),
                                    ),
                            ),
                          ],
                        ),
                        //here condition if user type is manager then will be two tab bar one videos and
                        //  stafffUserController.userDetails!.userType =="Manager" ?
                        stafffUserController.userDetails!.userType == "Manager"
                            ? TabBar(
                                // labelPadding:  EdgeInsets.symmetric(horizontal: 12.0),

                                labelColor: Colors.black,
                                indicatorColor: Colors.black,

                                tabs: stafffUserController.profileTab,
                                isScrollable: true,
                                controller:
                                    stafffUserController.managerProfileTab,
                              )
                            : SizedBox(),
                        stafffUserController.userDetails!.userType == "Manager"
                            ? Expanded(
                                child: TabBarView(
                                controller:
                                    stafffUserController.managerProfileTab,
                                children: [
                                  ListView.builder(
                                    itemCount:
                                        stafffUserController.userVideos.length,
                                    // physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.w, vertical: 10.h),
                                        child: InkWell(
                                          onTap: () async {
                                            await stafffUserController
                                                .getUserDetails(
                                                    stafffUserController
                                                        .userDetails!.id);

                                            Get.to(() => StaffShortsMainScreen(
                                                  index: index,
                                                  allVideoList:
                                                      stafffUserController
                                                          .userVideos,
                                                  anVideoObject:
                                                      stafffUserController
                                                          .userVideos[index],
                                                ));
                                            // Get.to(() => PlayIndividualVideos(
                                            //       comeIn: index,
                                            //     ));
                                          },
                                          child: VideoCardListing(
                                            text_name: stafffUserController
                                                .userVideos[index].title
                                                .toString(),
                                            text_desc: stafffUserController
                                                .userVideos[index].description
                                                .toString(),
                                            text_thumb: stafffUserController
                                                .userVideos[index].thumbnail
                                                .toString(),
                                            videoUrl: stafffUserController
                                                .userVideos[index].video,
                                            date: stafffUserController
                                                .userVideos[index].createdAt,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  stafffUserController.isLoading.value != true
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  2, // Number of columns in the grid
                                            ),
                                            itemCount: stafffUserController
                                                .allEmployeesList.length,
                                            itemBuilder: (context, index) {
                                              // return VideoContainer(user_name: "Kuldeep");

                                              return InkWell(
                                                  onTap: () async {
                                                    await stafffUserController
                                                        .getUserDetails(
                                                            stafffUserController
                                                                .allEmployeesList[
                                                                    index]
                                                                .id);

                                                    //  Get.toNamed(AppRoutes.userProfileVideos);
                                                    print(
                                                        "hello i am  ${stafffUserController.allEmployeesList[index].firstName} ${stafffUserController.allEmployeesList[index].userType} ");
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.w,
                                                            vertical: 10.h),
                                                    child: Card(
                                                      elevation: 2,
                                                      // decoration: BoxDecoration(border: Border.all()),
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            child: SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              // decoration: BoxDecoration(border: Border.all()),
                                                              child: stafffUserController
                                                                              .allEmployeesList[
                                                                                  index]
                                                                              .profileImage ==
                                                                          null ||
                                                                      stafffUserController
                                                                              .allEmployeesList[
                                                                                  index]
                                                                              .profileImage ==
                                                                          ""
                                                                  ? Image(
                                                                      image: AssetImage(
                                                                          ImageConstant
                                                                              .maleProfile))
                                                                  : CircleAvatar(
                                                                      radius:
                                                                          40.r,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .white,
                                                                      // backgroundImage: NetworkImage(
                                                                      //     APIsProvider.mediaBaseUrl +
                                                                      //         userDetailsController
                                                                      //             .allEmployeesList[
                                                                      //                 index]
                                                                      //             .profileImage
                                                                      //             .toString(),
                                                                      //     scale: 50.r),
                                                                      child:
                                                                          Image(
                                                                        image:
                                                                            NetworkImage(
                                                                          APIsProvider.mediaBaseUrl +
                                                                              stafffUserController.allEmployeesList[index].profileImage.toString(),
                                                                        ),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      )),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Card(
                                                              elevation: 1,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.r)),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        // border: Border.all(),
                                                                        ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "${stafffUserController.allEmployeesList[index].firstName} ${stafffUserController.allEmployeesList[index].lastName}",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Card(
                                                              elevation: 0,
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        // border: Border.all(),
                                                                        ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "${stafffUserController.allEmployeesList[index].status}",
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodySmall,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                            },
                                          ),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(
                                          color: ColorConstant.primaryDark,
                                        ))
                                ],
                              ))
                            : SizedBox(),

                        stafffUserController.userDetails!.userType == "Staff"
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount:
                                      stafffUserController.userVideos.length,
                                  // physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 14.w, vertical: 10.h),
                                      child: InkWell(
                                        onTap: () async {
                                          await stafffUserController
                                              .getUserDetails(
                                                  stafffUserController
                                                      .userDetails!.id);

                                          // Get.to(() => PlayIndividualVideos(
                                          //       comeIn: index,
                                          //     ));
                                          Get.to(() => StaffShortsMainScreen(
                                                index: index,
                                                allVideoList:
                                                    stafffUserController
                                                        .userVideos,
                                                anVideoObject:
                                                    stafffUserController
                                                        .userVideos[index],
                                              ));
                                        },
                                        child: VideoCardListing(
                                          text_name: stafffUserController
                                              .userVideos[index].title
                                              .toString(),
                                          text_desc: stafffUserController
                                              .userVideos[index].description
                                              .toString(),
                                          text_thumb: stafffUserController
                                              .userVideos[index].thumbnail
                                              .toString(),
                                          videoUrl: stafffUserController
                                              .userVideos[index].video,
                                          date: stafffUserController
                                              .userVideos[index].createdAt,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox()
                      ],
                    );
                  })
                : Center(
                    child: CircularProgressIndicator(
                    color: ColorConstant.primaryDark,
                  ))),
      ),
    );
  }
}
