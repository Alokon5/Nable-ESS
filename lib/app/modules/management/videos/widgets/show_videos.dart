import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/management/usersDetails/controller.dart';
import 'package:video_player/video_player.dart';

import '../../home/controller.dart';

class VideoShowWidget extends StatelessWidget {
  final String? video;
  final String? title;
  final String? description;

  VideoShowWidget({
    super.key,
    this.video,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    print("this is running ,,,$video");
    final VideoPlayerController videoPlayerController =
        VideoPlayerController.network("${APIsProvider.mediaBaseUrl}${video}");

    final ChewieController chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      allowMuting: false,
    );

    Future<bool> _onWillPop() async {
      print("this is back button");
      await videoPlayerController.dispose();
      chewieController.dispose();
      // Handle the back button press here
      // You can perform custom actions or show a snackbar
      // If enough time hasn't passed since the last back button press, exit the app
      return true;
    }

    return GetBuilder<UsersController>(
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
