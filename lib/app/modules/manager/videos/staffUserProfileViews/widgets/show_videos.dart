import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:video_player/video_player.dart';

import '../../controller.dart';

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
      // videoController.onInit();

      return true;
    }

   

    return GetBuilder<StaffVideocontroller>(
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
