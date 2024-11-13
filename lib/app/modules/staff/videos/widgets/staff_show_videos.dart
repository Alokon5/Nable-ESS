// ignore_for_file: must_be_immutable

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/staff/videos/controller.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/providers/apis_provider.dart';

class StaffVideoShowWidget extends StatelessWidget {
  final String? video;
  final String? title;
  final String? description;

  StaffVideoShowWidget({
    super.key,
    this.video,
    this.title,
    this.description,
  });

  var videoController = Get.find<VideoController>();

  @override
  Widget build(BuildContext context) {
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.network("${APIsProvider.mediaBaseUrl}${video}");

    final ChewieController chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );

    Future<bool> _onWillPop() async {
      print("this is back button");
      videoPlayerController.pause();
      videoController.onInit();

      return true;
    }

    return GetBuilder<VideoController>(
      builder: (s) {
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Column(
            children: [
              Chewie(
                controller: chewieController,
              ),
            ],
          ),
        );
      },
    );
  }
}
