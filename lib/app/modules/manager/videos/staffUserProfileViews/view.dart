import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/manager/mediaPlayer/playStaffVideos.dart';
import 'package:nable_ess/app/modules/manager/videos/controller.dart';

import 'package:nable_ess/app/widgets/video_card_promo.dart';

import '../../../../core/values/colors.dart';
import '../../../../core/values/images.dart';
import '../../mediaPlayer/playShortVideos.dart';

class StaffProfileVideos extends StatelessWidget {
  StaffProfileVideos({super.key});

  final stafffUserController = Get.put(StaffVideocontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
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
          child: stafffUserController.detailsStaff != null
              ? Column(
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 221.h,
                                      width: double.infinity,
                                      color: Color(0xeFFF0F4F9),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 59.h),
                                            child: Text(
                                              "${stafffUserController.detailsStaff!.firstName} ${stafffUserController.detailsStaff!.lastName}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 11.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                stafffUserController
                                                            .detailsStaff!
                                                            .designation !=
                                                        null
                                                    ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    4.w),
                                                        child: Text(
                                                          "${stafffUserController.detailsStaff!.designation != null ? stafffUserController.getDesignationNameViaId(stafffUserController.detailsStaff!.designation) : ""}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                      )
                                                    : SizedBox(),
                                                stafffUserController
                                                            .detailsStaff!
                                                            .designation !=
                                                        null
                                                    ? Text(
                                                        "|",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      )
                                                    : SizedBox(),
                                                stafffUserController
                                                            .detailsStaff!
                                                            .userType !=
                                                        null
                                                    ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    4.w),
                                                        child: Text(
                                                          "${stafffUserController.detailsStaff!.userType}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                      )
                                                    : SizedBox(),
                                                stafffUserController
                                                            .detailsStaff!
                                                            .userType !=
                                                        null
                                                    ? Text(
                                                        "|",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      )
                                                    : SizedBox(),
                                                stafffUserController
                                                            .detailsStaff!
                                                            .joinedDate !=
                                                        null
                                                    ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    4.w),
                                                        child: Text(
                                                          "${stafffUserController.detailsStaff!.joinedDate != null ? stafffUserController.dateTimeFormator(stafffUserController.detailsStaff!.joinedDate).date : ""}",
                                                          style:
                                                              Theme.of(context)
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
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.w),
                                                  child: Text(
                                                    "${stafffUserController.detailsStaff!.email}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          stafffUserController.detailsStaff!
                                                      .phoneNumber !=
                                                  null
                                              ? Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 47.w),
                                                      child: Icon(
                                                        Icons
                                                            .phone_android_outlined,
                                                        size: 13.sp,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.w),
                                                      child: Text(
                                                        "+91 ${stafffUserController.detailsStaff!.phoneNumber}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : SizedBox(),
                                          stafffUserController
                                                      .detailsStaff!.gender !=
                                                  null
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8.h),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 47.w),
                                                        child: Icon(
                                                          stafffUserController
                                                                          .detailsStaff!
                                                                          .gender ==
                                                                      "Male" ||
                                                                  stafffUserController
                                                                          .detailsStaff!
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
                                                                    .detailsStaff!
                                                                    .gender !=
                                                                null
                                                            ? Text(
                                                                "${stafffUserController.detailsStaff!.gender}",
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
                                          stafffUserController
                                                      .detailsStaff!.address !=
                                                  null
                                              ? Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 47.w),
                                                      child: Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        size: 13.sp,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.w),
                                                      child: Container(
                                                        width: 210.w,
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        child: Text(
                                                          "${stafffUserController.detailsStaff!.address}",
                                                          style:
                                                              Theme.of(context)
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
                                          .detailsStaff!.profileImage ==
                                      null ||
                                  stafffUserController
                                          .detailsStaff!.profileImage ==
                                      ''
                              ? CircleAvatar(
                                  radius: 38.r,
                                  child: Image(
                                    image:
                                        AssetImage(ImageConstant.maleProfile),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 38.r,
                                  backgroundImage: NetworkImage(
                                      APIsProvider.mediaBaseUrl +
                                          stafffUserController
                                              .detailsStaff!.profileImage
                                              .toString()),
                                ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: stafffUserController.staffVideos.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 2.h),
                            child: InkWell(
                              onTap: () async {
                                await stafffUserController.getUserDetails(
                                    stafffUserController.detailsStaff!.id);
                                // Get.to(() => PlayVideosStaff(
                                //       comeIn: index,
                                //     ));
                                Get.to(() => ShortsPlayOneStaff(
                                    index: index,
                                    allVideoList:
                                        stafffUserController.staffVideos));

                                print(
                                    "this is video screen------${stafffUserController.staffVideos[index].video}");
                              },
                              child: VideoCardListing(
                                text_name: stafffUserController
                                    .staffVideos[index].title
                                    .toString(),
                                text_desc: stafffUserController
                                    .staffVideos[index].description
                                    .toString(),
                                text_thumb: stafffUserController
                                    .staffVideos[index].thumbnail
                                    .toString(),
                                videoUrl: stafffUserController
                                    .staffVideos[index].video,
                                date: stafffUserController
                                    .staffVideos[index].createdAt,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: ColorConstant.primaryDark,
                ))),
    );
  }
}
