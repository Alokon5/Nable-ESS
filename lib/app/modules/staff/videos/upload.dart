import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/staff/videos/controller.dart';

import '../../../core/values/colors.dart';
import '../../../data/providers/apis_provider.dart';

class UploadVideoScreen extends StatefulWidget {
  UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  final VideoController _videoController = Get.put(VideoController());
  APIsProvider apIsProvider = APIsProvider();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final VideoController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {},
      //   icon: Icon(Icons.camera),
      //   label: Text("Camera"),
      // ),
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   icon: Icon(Icons.arrow_back_ios_rounded),
        //   color: Colors.black87,
        // ),
        title: Center(
          child: Text(
            "Add Your Task",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 5.0.h),
              child: Text(
                "Video Title",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Card(
                elevation: 3,
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextFormField(
                    controller: _videoController.titleController,
                    style: Theme.of(context).textTheme.titleSmall,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 12.w),
                        hintText: "Enter video title"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 18.0.h, left: 37.w, bottom: 5.0.h),
              child: Text(
                "Description",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Card(
                elevation: 3,
                child: Container(
                  height: 150.h,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all()),
                  child: TextFormField(
                    controller: _videoController.descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    style: Theme.of(context).textTheme.titleSmall,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 12.w),
                        hintText: "Enter video description....."),
                  ),
                ),
              ),
            ),
            Obx(() => (_videoController.selectedVideo.value == null)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 28.w, vertical: 21.h),
                        child: SizedBox(
                          height: 42.h,
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.camera_alt),
                                        title: Text(
                                          'Take Video',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        onTap: () {
                                          _videoController
                                              .selectVideoFromCamera();
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.file_upload,
                                        ),
                                        title: Text(
                                          'Select from File',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall,
                                        ),
                                        onTap: () {
                                          _videoController.selectVideo();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Center(
                              child: Text("Add Video",style: TextStyle(color: ColorConstant.buttonText),),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstant.button,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : _videoController.videoCompressLoading.value == false
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 24.h),
                          //   child: SizedBox(
                          //     height: 24.h,
                          //     width: 24.w,
                          //     child: Image(
                          //       image: AssetImage(ImageConstant.uploadVideo),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 20.h),
                            child: _videoController.videoUploadLoading.value ==
                                    false
                                ? SizedBox(
                                    height: 34.h,
                                    width: 117.w,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _videoController.uploadVideoToServer();
                                      },
                                      child: Center(
                                        child: Text(
                                          "Upload Video",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color:
                                                      ColorConstant.secondary),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xefe4efda),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                    color: ColorConstant.primary,
                                  )),
                          ),
                        ],
                      )
                    : SizedBox()),
            Obx(
              () => (_videoController.selectedVideo.value != null)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 18.0.h, left: 37.w, bottom: 5.0.h),
                          child: Text(
                            "Video Details",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        _videoController.videoCompressLoading.value == false
                            ? Column(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
                                    child: Container(
                                      height: 80.h,
                                      width: double.infinity,
                                      child: Row(
                                        children: [
                                          Card(
                                            elevation: 3,
                                            child: Container(
                                              height: 55.h,
                                              width: 81.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                              child: Column(
                                                children: [
                                                  if (_videoController
                                                      .uploadVideoThumbnail!
                                                      .isNotEmpty)
                                                    Image.file(
                                                      File(_videoController
                                                          .uploadVideoThumbnail
                                                          .toString()),
                                                      height: 52.h,
                                                      width: 77.w,
                                                      fit: BoxFit.cover,
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 14.h, left: 14.w),
                                                child: Text(
                                                  "${_videoController.videoName.value}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 6.h, left: 14.w),
                                                child: Text(
                                                  "${_videoController.videoSize.value}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 6.h, left: 14.w),
                                                child: Text(
                                                  "${_videoController.videoDate.value}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 14.w, vertical: 15.h),
                                    child: SizedBox(
                                      height: 34.h,
                                      width: 111.w,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    leading:
                                                        Icon(Icons.camera_alt),
                                                    title: Text(
                                                      'Take Video',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    onTap: () {
                                                      _videoController
                                                          .selectVideoFromCamera();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  ListTile(
                                                    leading: Icon(
                                                      Icons.file_upload,
                                                    ),
                                                    title: Text(
                                                      'Select from File',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    onTap: () {
                                                      _videoController
                                                          .selectVideo();
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Center(
                                          child: Text(
                                            "Re-Take",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorConstant.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                color: ColorConstant.primaryDark,
                              )),
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      )),
    );
  }
}
