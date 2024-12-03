import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nable_ess/app/modules/management/profile/controller.dart';
import 'package:nable_ess/app/modules/management/profile/profile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/models/userBasedDoc.dart';
import '../../../data/providers/apis_provider.dart';

class DocumentUsers extends StatelessWidget {
  DocumentUsers({super.key});
  final managementProfileController = Get.put(ProfileManagementController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return managementProfileController.user.length != 0
            ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded),
                          color: Colors.black87,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${managementProfileController.user[0].displayName.toString()}",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 24.h),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => ProfileManagement());
                            },
                            child: managementProfileController
                                            .user[0].photoUrl ==
                                        null ||
                                    managementProfileController
                                            .user[0].photoUrl ==
                                        ""
                                ? CircleAvatar(
                                    backgroundImage:
                                        AssetImage(ImageConstant.maleProfile),
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        APIsProvider.mediaBaseUrl +
                                            managementProfileController
                                                .user[0].photoUrl!),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10.w),
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Image(
                  //       height: 100.h,
                  //       width: 100.w,
                  //       image: AssetImage(ImageConstant.Logo),
                  //       fit: BoxFit.contain,
                  //     ),
                  //   ),
                  // ),
                  Divider(),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 28.w),
                  //   child: Container(
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //         color: Color(0xff08b8b6),
                  //         borderRadius: BorderRadius.circular(0.r)),
                  //     child: Center(
                  //       child: Column(
                  //         children: [
                  //           SizedBox(
                  //             height: 12.h,
                  //           ),
                  //           Text(
                  //             "Last Month Salary",
                  //             style: GoogleFonts.roboto(
                  //                 color: Colors.white, fontSize: 17.sp),
                  //           ),
                  //           SizedBox(
                  //             height: 3.h,
                  //           ),
                  //           Text(
                  //             "December 2023",
                  //             style: GoogleFonts.roboto(
                  //                 color: Colors.white, fontSize: 13.sp),
                  //           ),
                  //           SizedBox(
                  //             height: 3.h,
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 "4,568.23 \$",
                  //                 style: GoogleFonts.roboto(
                  //                     color: Colors.white, fontSize: 30.sp),
                  //               ),
                  //             ],
                  //           ),
                  //           SizedBox(
                  //             height: 12.h,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Number of columns in the grid
                      ),
                      itemCount:
                          managementProfileController.finalDocList.length,
                      itemBuilder: (context, index) {
                        // return VideoContainer(user_name: "Kuldeep");

                        return InkWell(
                          onTap: () async {
                            var object =
                                managementProfileController.finalDocList[index];
                            // Get.to(() => SingleProfile(),
                            //     transition: Transition.leftToRight);
                            // await clockInController.singleUserDataF(
                            //     clockInController.allEmployeesList[index].id);

                            // // Get.bottomSheet(SingleProfile());
                            printInfo(info: "object ====${object}");
                            printInfo(
                                info:
                                    "object of document list ====${object.docList!.length}");
                            Get.dialog(
                              documentDialogWidget(context, object),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 5.h),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20.r)),
                                  height: 60.h,
                                  width: 60.h,
                                  child: managementProfileController
                                                  .finalDocList[index]
                                                  .profileImage ==
                                              null ||
                                          managementProfileController
                                                  .finalDocList[index]
                                                  .profileImage ==
                                              ""
                                      ? CircleAvatar(
                                          radius: 35.r,
                                          child: Image(
                                              image: AssetImage(
                                                  ImageConstant.maleProfile)),
                                        )
                                      : CircleAvatar(
                                          backgroundImage: NetworkImage(
                                          APIsProvider.mediaBaseUrl +
                                              managementProfileController
                                                  .finalDocList[index]
                                                  .profileImage
                                                  .toString(),
                                        )),
                                ),
                                // SizedBox( height: 10.h,),
                                Container(
                                  width: 100.w,
                                  // decoration: BoxDecoration(
                                  //     // border: Border.all(),
                                  //     ),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.w),
                                      child: Text(
                                        "${managementProfileController.finalDocList[index].userFirstName} ${managementProfileController.finalDocList[index].userLastName}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Expanded(
                  //     child: ListView.builder(
                  //   itemCount: managementProfileController.finalDocList.length,
                  //   itemBuilder: (context, index) {
                  //     var obj = managementProfileController.finalDocList[index];
                  //     return Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 25.w),
                  //       child: Card(
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(15.r)),
                  //         color: Color(0xffebece7),
                  //         child: SizedBox(
                  //           height: 138.h,
                  //           width: double.infinity,
                  //           child: Center(
                  //             child: Stack(
                  //               // crossAxisAlignment: CrossAxisAlignment.start,
                  //               // mainAxisAlignment: MainAxisAlignment.start,
                  //               children: [
                  //                 Align(
                  //                   alignment: Alignment.topLeft,
                  //                   child: Padding(
                  //                     padding:
                  //                         EdgeInsets.only(top: 5.h, left: 9.w),
                  //                     child: Row(
                  //                       crossAxisAlignment:
                  //                           CrossAxisAlignment.center,
                  //                       // mainAxisAlignment:
                  //                       //     MainAxisAlignment.center,
                  //                       children: [
                  //                         Padding(
                  //                           padding:
                  //                               EdgeInsets.only(right: 24.h),
                  //                           child: InkWell(
                  //                             onTap: () {},
                  //                             child: managementProfileController
                  //                                             .finalDocList[
                  //                                                 index]
                  //                                             .profileImage ==
                  //                                         null ||
                  //                                     managementProfileController
                  //                                             .finalDocList[
                  //                                                 index]
                  //                                             .profileImage ==
                  //                                         ""
                  //                                 ? CircleAvatar(
                  //                                     radius: 20.r,
                  //                                     backgroundImage:
                  //                                         AssetImage(
                  //                                             ImageConstant
                  //                                                 .maleProfile),
                  //                                   )
                  //                                 : CircleAvatar(
                  //                                     radius: 20.r,
                  //                                     backgroundImage:
                  //                                         NetworkImage(APIsProvider
                  //                                                 .mediaBaseUrl +
                  //                                             managementProfileController
                  //                                                 .finalDocList[
                  //                                                     index]
                  //                                                 .profileImage
                  //                                                 .toString()),
                  //                                   ),
                  //                           ),
                  //                         ),
                  //                         Text(
                  //                           "${obj.userFirstName} ${obj.userLastName}",
                  //                           style: GoogleFonts.roboto(
                  //                               color: Color(0xff607683),
                  //                               fontSize: 14.sp,
                  //                               fontWeight: FontWeight.w500),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Column(
                  //                   children: [
                  //                     SizedBox(
                  //                       height: 45.h,
                  //                     ),
                  //                     Expanded(
                  //                       child: Container(
                  //                         width: double.infinity,
                  //                         decoration: BoxDecoration(
                  //                             color: Colors.white,
                  //                             borderRadius: BorderRadius.only(
                  //                                 bottomLeft:
                  //                                     Radius.circular(15.r),
                  //                                 bottomRight:
                  //                                     Radius.circular(15.r))),
                  //                         child: Padding(
                  //                           padding: EdgeInsets.only(
                  //                               bottom: 6.h, top: 5.h),
                  //                           child: Container(
                  //                             child: ListView.builder(
                  //                               itemCount: obj.docList!.length,
                  //                               itemBuilder:
                  //                                   (context, indexChild) {
                  //                                 return Stack(children: [
                  //                                   // Padding(
                  //                                   //   padding:
                  //                                   //       EdgeInsets.symmetric(
                  //                                   //           horizontal: 8.w),
                  //                                   //   child: Column(
                  //                                   //     children: [
                  //                                   //       Card(
                  //                                   //         shape: RoundedRectangleBorder(
                  //                                   //             borderRadius: BorderRadius.only(
                  //                                   //                 topLeft: Radius
                  //                                   //                     .circular(10
                  //                                   //                         .r),
                  //                                   //                 topRight: Radius
                  //                                   //                     .circular(
                  //                                   //                         10.r))),
                  //                                   //         child: Container(
                  //                                   //           decoration:
                  //                                   //               BoxDecoration(
                  //                                   //                   boxShadow: [
                  //                                   //                 BoxShadow(
                  //                                   //                   color: Colors
                  //                                   //                       .black
                  //                                   //                       .withOpacity(
                  //                                   //                           0.5.r),
                  //                                   //                   // .grey
                  //                                   //                   // .withOpacity(
                  //                                   //                   //     .5),
                  //                                   //                   blurRadius:
                  //                                   //                       5.0.r, // soften the shadow
                  //                                   //                   spreadRadius:
                  //                                   //                       0.0.r, //extend the shadow
                  //                                   //                   offset:
                  //                                   //                       Offset(
                  //                                   //                     -5.5,
                  //                                   //                     0.0,
                  //                                   //                     // Move to right 10  horizontally
                  //                                   //                     // Move to bottom 10 Vertically
                  //                                   //                   ),
                  //                                   //                 )
                  //                                   //               ],
                  //                                   //                   borderRadius: BorderRadius.only(
                  //                                   //                       topLeft: Radius.circular(10
                  //                                   //                           .r),
                  //                                   //                       topRight: Radius.circular(10
                  //                                   //                           .r)),
                  //                                   //                   gradient:
                  //                                   //                       LinearGradient(
                  //                                   //                           colors: [
                  //                                   //                         Color(0xff9edbe0),
                  //                                   //                         Color(0xffc6debc),
                  //                                   //                         Color(0xfff1dcb5),
                  //                                   //                         Color(0xfff1dcb5),
                  //                                   //                         Color(0xffc6debc),
                  //                                   //                         Color(0xff9edbe0),
                  //                                   //                       ])),
                  //                                   //           height: 43.h,
                  //                                   //           width: double
                  //                                   //               .infinity,
                  //                                   //           child: Padding(
                  //                                   //             padding: EdgeInsets
                  //                                   //                 .only(
                  //                                   //                     left: 10
                  //                                   //                         .w,
                  //                                   //                     top: 8
                  //                                   //                         .h),
                  //                                   //             child: Text(
                  //                                   //                 "${obj.docList![indexChild].docName}"),
                  //                                   //           ),
                  //                                   //         ),
                  //                                   //       ),
                  //                                   //       // Container(
                  //                                   //       //   width:
                  //                                   //       //       double.infinity,
                  //                                   //       //   height: 1.h,
                  //                                   //       //   color: Colors.black26,
                  //                                   //       // )
                  //                                   //     ],
                  //                                   //   ),
                  //                                   // ),
                  //                                   InkWell(
                  //                                     onTap: () async {
                  //                                       printInfo(
                  //                                           info:
                  //                                               'this is index number-=-=-=------${indexChild}');
                  //                                       await launch(
                  //                                           "${APIsProvider.mediaBaseUrl}${obj.docList![indexChild].documentUrl.toString()}");
                  //                                     },
                  //                                     child: Column(
                  //                                       children: [
                  //                                         // SizedBox(
                  //                                         //   height: 30.h,
                  //                                         // ),
                  //                                         Padding(
                  //                                           padding:
                  //                                               EdgeInsets.only(
                  //                                                   right: 5.w,
                  //                                                   left: 11.w),
                  //                                           child: Card(
                  //                                             // elevation: 2,
                  //                                             shape: RoundedRectangleBorder(
                  //                                                 borderRadius: BorderRadius.only(
                  //                                                     topLeft: Radius
                  //                                                         .circular(10
                  //                                                             .r),
                  //                                                     topRight:
                  //                                                         Radius.circular(
                  //                                                             10.r))),
                  //                                             child: Container(
                  //                                               decoration: BoxDecoration(
                  //                                                   boxShadow: [
                  //                                                     BoxShadow(
                  //                                                       color: Colors
                  //                                                           .black
                  //                                                           .withOpacity(0.5.r),
                  //                                                       // .grey
                  //                                                       // .withOpacity(
                  //                                                       //     .5),
                  //                                                       blurRadius:
                  //                                                           5.0.r, // soften the shadow
                  //                                                       spreadRadius:
                  //                                                           0.0.r, //extend the shadow
                  //                                                       offset:
                  //                                                           Offset(
                  //                                                         -5.5,
                  //                                                         0.0,
                  //                                                         // Move to right 10  horizontally
                  //                                                         // Move to bottom 10 Vertically
                  //                                                       ),
                  //                                                     )
                  //                                                   ],
                  //                                                   borderRadius: BorderRadius.only(
                  //                                                       topLeft:
                  //                                                           Radius.circular(10
                  //                                                               .r),
                  //                                                       topRight:
                  //                                                           Radius.circular(10
                  //                                                               .r)),
                  //                                                   color: Color(
                  //                                                       0xffff2d8c0)),
                  //                                               height: 40.h,
                  //                                               width: double
                  //                                                   .infinity,
                  //                                               child: Column(
                  //                                                 mainAxisAlignment:
                  //                                                     MainAxisAlignment
                  //                                                         .center,
                  //                                                 crossAxisAlignment:
                  //                                                     CrossAxisAlignment
                  //                                                         .start,
                  //                                                 children: [
                  //                                                   Padding(
                  //                                                     padding: EdgeInsets.only(
                  //                                                         left:
                  //                                                             20.w),
                  //                                                     child: Text(obj
                  //                                                         .docList![
                  //                                                             indexChild]
                  //                                                         .docName
                  //                                                         .toString()),
                  //                                                   ),
                  //                                                 ],
                  //                                               ),
                  //                                             ),
                  //                                           ),
                  //                                         )
                  //                                       ],
                  //                                     ),
                  //                                   ),
                  //                                 ]);
                  //                               },
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     )
                  //                   ],
                  //                 )

                  //                 // ListTile(
                  //                 //   title: Text(
                  //                 //     "Name of the candidate",
                  //                 //     style: Theme.of(context)
                  //                 //         .textTheme
                  //                 //         .bodyMedium,
                  //                 //   ),
                  //                 //   subtitle: Text(
                  //                 //     "November",
                  //                 //     style: Theme.of(context)
                  //                 //         .textTheme
                  //                 //         .bodySmall,
                  //                 //   ),
                  //                 //   trailing: SizedBox(),
                  //                 // ),
                  //                 // SizedBox(height: 3.h),
                  //                 // Text(
                  //                 //   "2023",
                  //                 //   style: TextStyle(
                  //                 //       color: Colors.black54,
                  //                 //       fontSize: 10.sp),
                  //                 // ),
                  //                 // Text(
                  //                 //   "4,568.23 \$",
                  //                 //   style: Theme.of(context)
                  //                 //       .textTheme
                  //                 //       .bodyMedium,
                  //                 // ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // )),
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
    );
  }

  documentDialogWidget(context, UserBasedDocModel object) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10, bottom: 50.h),
      child: Container(
        decoration: BoxDecoration(
            color: ColorConstant.backgroud,
            borderRadius: BorderRadius.circular(25.r)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
              child: AppBar(
                leading: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                  height: 60.h,
                  width: 60.h,
                  child:
                      object.profileImage == null || object.profileImage == ""
                          ? CircleAvatar(
                              radius: 35.r,
                              child: Image(
                                  image: AssetImage(ImageConstant.maleProfile)),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(
                                APIsProvider.mediaBaseUrl +
                                    object.profileImage.toString(),
                              ),
                            ),
                ),
                title: Text("${object.userFirstName} ${object.userLastName}",
                    style: Theme.of(context).textTheme.bodyMedium),
                actions: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 25.sp,
                        color: Colors.blueAccent,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.black,
              height: 1.2.h,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: object.docList!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    await launch(
                        "${APIsProvider.mediaBaseUrl}${object.docList![index].documentUrl.toString()}");
                    printInfo(
                        info:
                            "${APIsProvider.mediaBaseUrl}${object.docList![index].documentUrl.toString()}");
                  },
                  child: Container(
                    // height: 101.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        // color: Colors.blue,
                        borderRadius: BorderRadius.circular(17.r)),
                    child: Card(
                      elevation: 4.0,
                      margin: EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Document Type",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.picture_as_pdf,
                                          color: Colors
                                              .red, // Customize the color as needed
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          'PDF',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Document Name",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            170.0, // Set the maximum width
                                      ),
                                      child: Text(
                                        '${object.docList![index].docName}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 6,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
