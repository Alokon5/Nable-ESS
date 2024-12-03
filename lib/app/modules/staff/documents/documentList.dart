import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:nable_ess/app/modules/staff/profile/controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../widgets/text_form.dart';

import '../profile/view.dart';

class DocumentListScreen extends StatelessWidget {
  DocumentListScreen({super.key});
  final profileStaffController = Get.put(StaffProfileController());
  @override
  Widget build(BuildContext context) {
    profileStaffController.getDocument();

    return Scaffold(
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(bottom: 33.h, right: 0.w),
      //   child: InkWell(
      //     onTap: () {
      //       Get.dialog(
      //         showUploadDialog(profileStaffController, Get.context!,
      //             "Upload Document", "Upload", 0),
      //       );
      //     },
      //     child: CircleAvatar(
      //       radius: 23.r,
      //       child: Icon(Icons.add),
      //     ),
      //   ),
      // ),
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
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
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
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10.w),
                    //   child: Align(
                    //     alignment: Alignment.topLeft,
                    //     child: Image(
                    //       height: 100.h,
                    //       width: 100.w,
                    //       image: AssetImage(ImageConstant.Logo),
                    //       fit: BoxFit.contain,
                    //     ),submit
                    //   ),
                    // ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Container(
                        height: 35.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: ColorConstant.button,
                            borderRadius: BorderRadius.circular(6.r)),
                        child: Center(
                          child: Text(
                            "${profileStaffController.documents.length} Documents",
                            style:TextStyle(color: ColorConstant.buttonText),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: profileStaffController.documents.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.w),
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
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h),
                                              child: Center(
                                                  child: Text(
                                                "${profileStaffController.documents[index].documentName}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 4,
                                              )),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            printInfo(
                                                info: 'here opening menu item');
                                            if (profileStaffController
                                                    .docIndex.value ==
                                                index.toString()) {
                                              profileStaffController
                                                  .docIndex.value = '';
                                            } else {
                                              profileStaffController.docIndex
                                                  .value = index.toString();
                                            }
                                          },
                                          child: Container(
                                            width: 36.w,
                                            decoration: BoxDecoration(
                                                color: ColorConstant.button,
                                                border: Border.all(
                                                    width: 1.w,
                                                    color: ColorConstant
                                                        .primaryDark)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.5.h),
                                              child: Center(
                                                  child:
                                                      Icon(Icons.more_horiz)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  profileStaffController.docIndex.value ==
                                          index.toString()
                                      ? SizedBox(
                                          height: 40.h,
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(),
                                              Container(
                                                height: double.infinity,
                                                width: 100.w,
                                                decoration: BoxDecoration(
                                                  color: ColorConstant.button,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft: Radius
                                                              .circular(6.r),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  6.r),
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
                                                        onTap: () async {
                                                          printInfo(
                                                              info:
                                                                  "pdfurl--====${"${APIsProvider.mediaBaseUrl}${profileStaffController.documents[index].document}"}");
                                                          await launch(
                                                              "${APIsProvider.mediaBaseUrl}${profileStaffController.documents[index].document}");
                                                          // Get.to(() =>
                                                          //     PdfViewerWidget(
                                                          //       pdfUrl:
                                                          //           "${APIsProvider.mediaBaseUrl}${profileStaffController.documents[index].document}",
                                                          //     ));
                                                        },
                                                        child: Text("View")),
                                                    // InkWell(
                                                    //     onTap: () {
                                                    //       Get.snackbar(
                                                    //           "Unreachable",
                                                    //           "You can't edit ${profileStaffController.documents[index].documentName.toString()} document");
                                                    //       // printInfo(
                                                    //       //     info:
                                                    //       //         "Edit.................");
                                                    //       // profileStaffController
                                                    //       //         .documentNameController
                                                    //       //         .text =
                                                    //       //     profileStaffController
                                                    //       //         .documents[
                                                    //       //             index]
                                                    //       //         .documentName
                                                    //       //         .toString();
                                                    //       // profileStaffController
                                                    //       //         .pdfPath
                                                    //       //         .value =
                                                    //       //     profileStaffController
                                                    //       //         .documents[
                                                    //       //             index]
                                                    //       //         .document
                                                    //       //         .toString();
                                                    //       // Get.dialog(
                                                    //       //   showUploadDialog(
                                                    //       //       profileStaffController,
                                                    //       //       Get.context!,
                                                    //       //       "Update Document",
                                                    //       //       "Update",
                                                    //       //       profileStaffController
                                                    //       //           .documents[
                                                    //       //               index]
                                                    //       //           .id!
                                                    //       //           .toInt()),
                                                    //       // );
                                                    //     },
                                                    //     child: Text("Edit")),
                                                    // InkWell(
                                                    //     onTap: () {
                                                    //       Get.snackbar(
                                                    //           "Unreachable",
                                                    //           "You can't delete ${profileStaffController.documents[index].documentName.toString()} document");
                                                    //       // logoutdialog(
                                                    //       //     context,
                                                    //       //     profileStaffController,
                                                    //       //     profileStaffController
                                                    //       //         .documents[
                                                    //       //             index]
                                                    //       //         .id!
                                                    //       //         .toInt(),
                                                    //       //     profileStaffController
                                                    //       //         .documents[
                                                    //       //             index]
                                                    //       //         .documentName
                                                    //       //         .toString());
                                                    //     },
                                                    //     child: Text("Delete")),
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
                    ),
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

Widget showUploadDialog(StaffProfileController profileStaffController,
    BuildContext context, String dTitle, String bName, int id) {
  return AlertDialog(
    title: Text('$dTitle'),
    // Add the rest of your AlertDialog content here...
    actions: <Widget>[
      Obx(() {
        return Form(
          key: profileStaffController.uploadDocFormKey,
          child: Column(
            children: [
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
                                    profileStaffController.uploadDocument();
                                  } else {
                                    profileStaffController.updateDocument(id);
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

logoutdialog(context, StaffProfileController profileController, int id,
    String docName) async {
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
                  profileController.deleteDocument(id); // Close the dialog
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
