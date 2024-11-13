import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/home/controller.dart';
import 'package:nable_ess/app/modules/manager/mediaPlayer/playStaffVideos.dart';

import '../home/uploadTask/upload.dart';

class VlogView extends StatelessWidget {
  VlogView({super.key});

  var homeManagerController = Get.put(HomeManagerController());
  @override
  Widget build(BuildContext context) {
    return homeManagerController.yourVideoList.length != 0
        ? StaffShortsMainScreen(
            index: 0,
            allVideoList: homeManagerController.yourVideoList,
          )
        : UploadTask();
  }
}
