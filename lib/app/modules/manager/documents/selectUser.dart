import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../widgets/text_form.dart';
import '../videos/controller.dart';
import 'doc_controller.dart';
import 'ownDoc/managerDoc.dart';

class SelectUsers extends StatelessWidget {
  SelectUsers({super.key});

  final staffListController = Get.put(StaffVideocontroller());
  final managerDocCotnroller = Get.put(ManagersDocController());
  @override
  Widget build(BuildContext context) {
    // staffListController.staffsListed.length != 0
    //     ? managerDocCotnroller
    //         .getDocument(staffListController.staffsListed[0].id)
    //     : null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
          color: Colors.black87,
        ),
        centerTitle: false,
        title: Text(
          "Select a staff",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
              onPressed: () async {
                await managerDocCotnroller
                    .getDocument(managerDocCotnroller.user[0].id);
                Get.to(() => DocumentListScreenManager());
              },
              child: Text("My Documents"))
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Column(
              children: [
                Expanded(
                    child: ListView.builder(
                  itemCount: staffListController.staffsListed.length,
                  itemBuilder: (context, index) {
                    var object = staffListController.staffsListed[index];

                    return Obx(() {
                      return ListTile(
                        onTap: () {
                          managerDocCotnroller.documents.clear();
                          staffListController.selectedListTile.value =
                              index.toInt();
                          staffListController.staffName.value =
                              object.firstName.toString();

                          staffListController.staffProfilePhoto.value =
                              object.profileImage.toString();

                          staffListController.staffEmail.value =
                              object.email.toString();
                          staffListController.staffId.value =
                              object.id.toString();
                          managerDocCotnroller.getDocument(object.id);
                        },
                        // selectedColor:
                        //     staffListController.selectedListTile.value
                        //         ? Colors.blue
                        //         : null,
                        tileColor:
                            staffListController.selectedListTile.value == index
                                ? Colors.blueGrey
                                : null,

                        leading: object.profileImage == null
                            ? CircleAvatar(
                                child: Image(
                                  image: AssetImage(ImageConstant.maleProfile),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    APIsProvider.mediaBaseUrl +
                                        object.profileImage.toString()),
                              ),

                        //  Text("${object.profileImage}"),
                        // leading: object != null
                        //     ? SizedBox(
                        //         width: double.infinity,
                        //         // decoration: BoxDecoration(border: Border.all()),
                        //         child: object.profileImage == null ||
                        //                 object.profileImage == ''
                        //             ? CircleAvatar(
                        //                 // radius: 35.r,
                        //                 child: Image(
                        //                     image: AssetImage(ImageConstant.maleProfile)),
                        //               )
                        //             : CircleAvatar(
                        //                 // radius: 40.r,
                        //                 backgroundColor: Colors.white,
                        //                 child: Image(
                        //                   image: NetworkImage(
                        //                     APIsProvider.mediaBaseUrl +
                        //                         object.profileImage.toString(),
                        //                   ),
                        //                   fit: BoxFit.fill,
                        //                 ),
                        //               ),
                        //       )
                        //     : SizedBox(),
                        title: Text(
                          "${object.firstName}",
                          style: TextStyle(fontSize: 13.sp),
                        ),
                      );
                    });
                  },
                ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueGrey,
              child: Obx(() {
                return Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    staffListController.staffProfilePhoto == '' ||
                            staffListController.staffProfilePhoto == "null"
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 38.r,
                            child: Image(
                              image: AssetImage(ImageConstant.maleProfile),
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 38.r,
                            backgroundImage: NetworkImage(
                                APIsProvider.mediaBaseUrl +
                                    staffListController.staffProfilePhoto
                                        .toString()),
                          ),
                    Text("${staffListController.staffName}",
                        style: TextStyle(fontSize: 14.sp)),
                    Text("${staffListController.staffEmail}",
                        style: TextStyle(fontSize: 12.sp)),
                    // Text("${staffListController.staffId}",
                    //     style: TextStyle(fontSize: 12.sp)),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Expanded(
                            child: managerDocCotnroller.documents.length != 0
                                ? SizedBox(
                                    child: ListView.builder(
                                      itemCount:
                                          managerDocCotnroller.documents.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25.w),
                                          child: Obx(() {
                                            return Column(
                                              children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 1.w,
                                                                  color: ColorConstant
                                                                      .primaryDark)),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        5.h),
                                                            child: Center(
                                                              child: Text(
                                                                "${managerDocCotnroller.documents[index].documentName}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 4,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          // printInfo(
                                                          //     info:
                                                          //         'here opening menu item');
                                                          if (managerDocCotnroller
                                                                  .docIndex
                                                                  .value ==
                                                              index
                                                                  .toString()) {
                                                            managerDocCotnroller
                                                                .docIndex
                                                                .value = '';
                                                          } else {
                                                            managerDocCotnroller
                                                                    .docIndex
                                                                    .value =
                                                                index
                                                                    .toString();
                                                          }
                                                        },
                                                        child: Container(
                                                          width: 36.w,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff4472c4),
                                                              border: Border.all(
                                                                  width: 1.w,
                                                                  color: ColorConstant
                                                                      .primaryDark)),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        2.5.h),
                                                            child: Center(
                                                                child: Icon(Icons
                                                                    .more_horiz)),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                managerDocCotnroller
                                                            .docIndex.value ==
                                                        index.toString()
                                                    ? SizedBox(
                                                        height: 70.h,
                                                        width: double.infinity,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(),
                                                            Container(
                                                              height: double
                                                                  .infinity,
                                                              width: 100.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xff4472c4),
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft: Radius
                                                                        .circular(6
                                                                            .r),
                                                                    bottomLeft:
                                                                        Radius.circular(6
                                                                            .r),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            6.r)),
                                                              ),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        printInfo(
                                                                            info:
                                                                                "pdfurl--====${"${APIsProvider.mediaBaseUrl}${managerDocCotnroller.documents[index].document}"}");
                                                                        await launch(
                                                                            "${APIsProvider.mediaBaseUrl}${managerDocCotnroller.documents[index].document}");
                                                                        // Get.to(() =>
                                                                        //     PdfViewerWidget(
                                                                        //       pdfUrl:
                                                                        //           "${APIsProvider.mediaBaseUrl}${managerDocCotnroller.documents[index].document}",
                                                                        //     ));
                                                                      },
                                                                      child: Text(
                                                                          "View")),
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        printInfo(
                                                                            info:
                                                                                "Edit.................");
                                                                        managerDocCotnroller.documentNameController.text = managerDocCotnroller
                                                                            .documents[index]
                                                                            .documentName
                                                                            .toString();
                                                                        managerDocCotnroller.pdfPath.value = managerDocCotnroller
                                                                            .documents[index]
                                                                            .document
                                                                            .toString();
                                                                        Get.dialog(
                                                                          showUploadDialogViaId(
                                                                              managerDocCotnroller,
                                                                              Get.context!,
                                                                              "Update Document",
                                                                              "Update",
                                                                              managerDocCotnroller.documents[index].id.toString(),
                                                                              staffListController.staffId.toString()),
                                                                        );
                                                                      },
                                                                      child: Text(
                                                                          "Edit")),
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        deleteDocuViaId(
                                                                            context,
                                                                            managerDocCotnroller,
                                                                            managerDocCotnroller.documents[index].id!.toInt(),
                                                                            managerDocCotnroller.documents[index].documentName.toString(),
                                                                            staffListController.staffId.value);
                                                                      },
                                                                      child: Text(
                                                                          "Delete")),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : SizedBox(),
                                                SizedBox(
                                                  height: 8.h,
                                                )
                                              ],
                                            );
                                          }),
                                        );
                                      },
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                        "${managerDocCotnroller.uploadingState}")),
                          ),
                          staffListController.staffId.value == ''
                              ? SizedBox()
                              : Padding(
                                  padding: EdgeInsets.only(left: 120.w),
                                  child: InkWell(
                                    onTap: () {
                                      Get.dialog(
                                        showUploadDialogViaId(
                                            managerDocCotnroller,
                                            Get.context!,
                                            "Upload Document",
                                            "Upload",
                                            staffListController.staffId.value,
                                            staffListController.staffId.value),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 23.r,
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      ),
                    )
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  deleteDocuViaId(context, ManagersDocController profileController, int id,
      String docName, String userId) async {
    await Get.dialog(
      AlertDialog(
        title: Text('Confirm Delete $docName!',
            style: Theme.of(context).textTheme.bodyLarge),
        content: Text('Are you sure you want to delete $docName document?',
            style: Theme.of(context).textTheme.bodyMedium),
        actions: [
          profileController.pdfUploading.value != true
              ? TextButton(
                  child: Text('Cancel',
                      style: Theme.of(context).textTheme.bodySmall),
                  onPressed: () {
                    Get.back(); // Close the dialog
                  },
                )
              : SizedBox(),
          profileController.pdfUploading.value != true
              ? ElevatedButton(
                  child: Text('delete',
                      style: Theme.of(context).textTheme.bodySmall),
                  onPressed: () {
                    // Perform logout logic here
                    profileController.deleteDocument(
                        id, userId); // Close the dialog
                  },
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: ColorConstant.primaryDark,
                )),
        ],
      ),
    );
  }

  Widget showUploadDialogViaId(
      ManagersDocController profileStaffController,
      BuildContext context,
      String dTitle,
      String bName,
      String id,
      String userID) {
    return AlertDialog(
      title: Text('$dTitle'),
      // Add the rest of your AlertDialog content here...
      actions: <Widget>[
        Obx(() {
          return Form(
            key: profileStaffController.uploadDocFormKey,
            child: Column(
              children: [
                // Text(
                //     "document Id =========${id},user Id==================${userID}"),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: AppTextField(
                    controller: profileStaffController.documentNameController,
                    validator: (value) {
                      if (value == null || value == "") {
                        return "Please Enter Docoment Name";
                      }
                    },
                    lableText: 'Document Name',
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: InkWell(
                    onTap: () => profileStaffController.pickPDF(),
                    child: Container(
                      height: 44.h,
                      decoration: BoxDecoration(
                          color: ColorConstant.backgroud,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.black54)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.picture_as_pdf_outlined),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            profileStaffController.pdfName.value == ''
                                ? "Choose Document"
                                : profileStaffController.pdfName.value,
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                profileStaffController.pdfUploading.value != true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.back(); // Close the dialog
                            },
                            child: Text('Close'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: Colors.black)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: TextButton(
                                  onPressed: () {
                                    // Close the dialog
                                    if (bName == "Upload") {
                                      profileStaffController
                                          .uploadDocumentViaUserId(id, userID);
                                    } else {
                                      profileStaffController.updateDocument(
                                          id, userID);
                                    }

                                    // profileStaffController.updateDetails();
                                  },
                                  child: Text('$bName'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(
                        color: ColorConstant.primaryDark,
                      ))
              ],
            ),
          );
        })
        // Your dialog content here...
      ],
    );
  }
}
