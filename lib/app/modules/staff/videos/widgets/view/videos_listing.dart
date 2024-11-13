import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/staff/mediaPlayer/playStaffVideos.dart';

import '../../controller.dart';
import '../../upload.dart';

class StaffVideoListing extends StatelessWidget {
  StaffVideoListing({super.key});

  final VideoController _videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    print(
        "_videoController.videoList.length----${_videoController.videoList.length}");

    return _videoController.videoList.length != 0
        ? StaffShortsMainScreen(
            allVideoList: _videoController.videoList,
            index: 0,
          )
        : UploadVideoScreen();
  }
}
