// import 'package:cached_video_player/cached_video_player.dart';
// import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/management/videos/widgets/show_videos.dart';
import 'package:video_player/video_player.dart';

import '../../../core/mediaPlayer/playShortVideos.dart';
import '../../../data/models/allVideosModel/allVideoModel.dart';
import '../../../data/providers/apis_provider.dart';
import '../home/controller.dart';
import '../usersDetails/controller.dart';

class AllVideos extends StatelessWidget {
  AllVideosData? videoObj;
  AllVideos({super.key, this.videoObj});
  var staffController = Get.put(HomeManagementController());
  @override
  // Future<bool> _onWillPop() async {
  //   print("this is back button");
  //   await staffController.playVideosController.pause();
  //   Get.back();
  //   // Handle the back button press here
  //   // You can perform custom actions or show a snackbar
  //   // If enough time hasn't passed since the last back button press, exit the app
  //   return true;
  // }

  Widget build(BuildContext context) {
    print("user Video -----${staffController.allVideos.length}");
    // return ShortsMainScreen(
    //   allVideoList: staffController.allVideos,
    //   index: 0,
    // );

    return Scaffold(
        body: PageView.builder(
      //to make the whole page scrollable
      itemCount: staffController.allVideos.length,
      controller: PageController(
          initialPage: staffController.pageBuilderIndex.toInt(),
          viewportFraction: 1),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        printError(info: "index =====${index}");
        return Stack(
          //to put all other elements on top of the video
          children: [
            // ShortsPlayer(
            //   shortsUrl:
            //       "${APIsProvider.mediaBaseUrl}${widget.allVideoList![index].video.toString()}",
            // ),

            ShortVideoPlayer(
              homeMngmntController: staffController,
              videoUrl:
                  "${APIsProvider.mediaBaseUrl}${staffController.allVideos[index].video.toString()}",
              // nextIndexUrl:
              //     "${APIsProvider.mediaBaseUrl}${staffController.allVideos[(staffController.allVideos.length - 1) > index ? index + 1 : index].video.toString()}",
            ),

            //all stacked options
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //upper options row
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // back-arrow + shorts-heading row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // IconButton(
                        //   onPressed: () {

                        //   },
                        //   icon: const Icon(
                        //     Icons.arrow_back_outlined,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        // IconButton(
                        //   onPressed: () {
                        //     Get.back();
                        //   },
                        //   icon: Icon(Icons.arrow_back_ios_rounded),
                        //   color: Colors.white,
                        // ),
                        SizedBox(
                          width: 10.w,
                        ),
                        const Text(
                          'VLog',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),

                    //search + camera + menu row
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //search btn
                        // IconButton(
                        //   onPressed: () {
                        //     // Navigator.of(context)
                        //     //     .push(MaterialPageRoute(
                        //     //   builder: (context) =>
                        //     //       const SearchScreen(),
                        //     // ));
                        //   },
                        //   icon: const Icon(
                        //     Icons.search_rounded,
                        //     color: Colors.white,
                        //   ),
                        // ),

                        //camera btn
                        // widget.userType != null ||
                        //         widget.userType == "Manager"
                        //     ? IconButton(
                        //         onPressed: () async {
                        //           await ImagePicker().pickImage(
                        //               source: ImageSource.camera);
                        //         },
                        //         icon: const Icon(
                        //           Icons.camera_alt_outlined,
                        //           color: Colors.white,
                        //         ),
                        //       )
                        //     : SizedBox(),

                        //menu btn
                        IconButton(
                          onPressed: () {
                            showBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    color: const Color(0xff1A1818),
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            showBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  color:
                                                      const Color(0xff1A1818),
                                                  width: double.infinity,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            25),
                                                    child: Text(
                                                      staffController
                                                          .allVideos[index]
                                                          .description
                                                          .toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 25),
                                                  child: Icon(
                                                    Icons.notes_rounded,
                                                    color: Colors.white,
                                                    size: 27,
                                                  ),
                                                ),
                                                Text(
                                                  'Description',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 25),
                                                  child: Icon(
                                                    Icons
                                                        .closed_caption_rounded,
                                                    color: Colors.white,
                                                    size: 27,
                                                  ),
                                                ),
                                                Text(
                                                  'Captions',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 25),
                                                  child: Icon(
                                                    Icons
                                                        .do_not_disturb_alt_rounded,
                                                    color: Colors.white,
                                                    size: 27,
                                                  ),
                                                ),
                                                Text(
                                                  'Don\'t recommend this channel',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 25),
                                                  child: Icon(
                                                    Icons.outlined_flag_rounded,
                                                    color: Colors.white,
                                                    size: 27,
                                                  ),
                                                ),
                                                Text(
                                                  'Report',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 25),
                                                  child: Icon(
                                                    Icons.feedback_outlined,
                                                    color: Colors.white,
                                                    size: 27,
                                                  ),
                                                ),
                                                Text(
                                                  'Send feedback',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.more_vert_rounded,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                //lower-operations row
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //video content details
                      Column(
                        children: [
                          // userprofile details
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "${APIsProvider.mediaBaseUrl}${staffController.allVideos[index].thumbnail}"),
                                radius: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: 150.w,
                                  child: Text(
                                    '${staffController.allVideos[index].title}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     if (subscribeSwitch) {
                              //       showAlertDialog(context, index);
                              //     } else {
                              //       setState(() {
                              //         subscribeText = 'Subscribed';
                              //         subscribeBtnColor = Colors.black
                              //             .withOpacity(0.7);
                              //         subscribeSwitch = true;
                              //       });
                              //     }
                              //   },
                              //   child: Container(
                              //     margin:
                              //         const EdgeInsets.only(left: 8),
                              //     padding: const EdgeInsets.symmetric(
                              //       horizontal: 8,
                              //       vertical: 6,
                              //     ),
                              //     decoration: BoxDecoration(
                              //       color: subscribeBtnColor,
                              //       borderRadius:
                              //           BorderRadius.circular(4),
                              //     ),
                              //     child: Text(
                              //       subscribeText,
                              //       style: const TextStyle(
                              //         color: Colors.white,
                              //         fontSize: 16,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              width: 240.w,
                              // MediaQuery.of(context).size.width,
                              // color: Colors.amber,
                              child: Text(
                                staffController.allVideos[index].description
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      //like + dislike + comments + share options
                      // SizedBox(
                      //   child: Column(
                      //     children: [
                      //       //like btn
                      //       Padding(
                      //         padding: const EdgeInsets.symmetric(vertical: 25),
                      //         child: InkWell(
                      //           onTap: () {
                      //             // setState(() {
                      //             //   if (likeBtnSwitch) {
                      //             //     likeBtnSwitch = false;
                      //             //     // widget.postDetails[index]
                      //             //     //     .reaction.count--;
                      //             //     likeBtnColor = Colors.white;
                      //             //   } else {
                      //             //     likeBtnSwitch = true;
                      //             //     // widget.postDetails[index]
                      //             //     //     .reaction.count++;
                      //             //     likeBtnColor = Colors.blue;
                      //             //     if (dislikeBtnSwitch) {
                      //             //       dislikeBtnColor = Colors.white;
                      //             //     }
                      //             //   }
                      //             // });
                      //           },
                      //           // child: Column(
                      //           //   children: [
                      //           //     Icon(
                      //           //       Icons.thumb_up_rounded,
                      //           //       color: likeBtnColor,
                      //           //       size: iconSize,
                      //           //     ),
                      //           //     Text(
                      //           //       "2",
                      //           //       style: textStyle1,
                      //           //     ),
                      //           //   ],
                      //           // ),
                      //         ),
                      //       ),

                      //       //dislike btn
                      //       // Padding(
                      //       //   padding: const EdgeInsets.only(bottom: 25),
                      //       //   child: InkWell(
                      //       //     onTap: () {
                      //       //       setState(() {
                      //       //         if (dislikeBtnSwitch) {
                      //       //           dislikeBtnSwitch = false;
                      //       //           dislikeBtnColor = Colors.white;
                      //       //         } else {
                      //       //           dislikeBtnSwitch = true;
                      //       //           dislikeBtnColor = Colors.blue;
                      //       //           if (likeBtnSwitch) {
                      //       //             // widget.postDetails[index]
                      //       //             //     .reaction.count--;
                      //       //             likeBtnColor = Colors.white;
                      //       //             likeBtnSwitch = false;
                      //       //           }
                      //       //         }
                      //       //       });
                      //       //     },
                      //       //     child: Column(
                      //       //       children: [
                      //       //         Icon(
                      //       //           Icons.thumb_down_rounded,
                      //       //           color: dislikeBtnColor,
                      //       //           size: iconSize,
                      //       //         ),
                      //       //         Text(
                      //       //           'Dislike',
                      //       //           style: textStyle1,
                      //       //         ),
                      //       //       ],
                      //       //     ),
                      //       //   ),
                      //       // ),

                      //       //comment btn
                      //       // Padding(
                      //       //   padding: const EdgeInsets.only(bottom: 25),
                      //       //   child: InkWell(
                      //       //     // onTap: (){
                      //       //     //   setState(() {
                      //       //     //     //open modal box
                      //       //     //   });
                      //       //     // },
                      //       //     child: Column(
                      //       //       children: [
                      //       //         Icon(
                      //       //           Icons.comment_rounded,
                      //       //           color: Colors.white,
                      //       //           size: iconSize,
                      //       //         ),
                      //       //         Text(
                      //       //           "6",
                      //       //           style: textStyle1,
                      //       //         ),
                      //       //       ],
                      //       //     ),
                      //       //   ),
                      //       // ),

                      //       // //save btn
                      //       // Padding(
                      //       //   padding: const EdgeInsets.only(bottom: 25),
                      //       //   child: InkWell(
                      //       //     // onTap: (){
                      //       //     //   setState(() {
                      //       //     //     //open share modal box
                      //       //     //   });
                      //       //     // },
                      //       //     child: Column(
                      //       //       children: [
                      //       //         Icon(
                      //       //           Icons.bookmark_border_rounded,
                      //       //           color: Colors.white,
                      //       //           size: iconSize,
                      //       //         ),
                      //       //         Text(
                      //       //           'Save',
                      //       //           style: textStyle1,
                      //       //         ),
                      //       //       ],
                      //       //     ),
                      //       //   ),
                      //       // ),

                      //       // // share btn
                      //       // Padding(
                      //       //   padding: const EdgeInsets.only(bottom: 25),
                      //       //   child: InkWell(
                      //       //     onTap: () {
                      //       //       Share.share(
                      //       //           "${APIsProvider.mediaBaseUrl}${widget.allVideoList![index].video}");
                      //       //     },
                      //       //     child: Column(
                      //       //       children: [
                      //       //         Icon(
                      //       //           Icons.share_rounded,
                      //       //           color: Colors.white,
                      //       //           size: iconSize,
                      //       //         ),
                      //       //         Text(
                      //       //           'Share',
                      //       //           style: textStyle1,
                      //       //         ),
                      //       //       ],
                      //       //     ),
                      //       //   ),
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),

            Obx(() {
              return Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.h),
                    child: Text(
                      "${staffController.videoLength}",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(
                                2.0, 2.0), // Adjust the shadow offset as needed
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ));
            }),
          ],
        );
      },
    ));
  }
}

class ShortVideoPlayer extends StatefulWidget {
  final String videoUrl;
  // final String nextIndexUrl;
  final HomeManagementController? homeMngmntController;

  ShortVideoPlayer({
    required this.videoUrl,
    this.homeMngmntController,
    // required this.nextIndexUrl
  });

  @override
  _ShortVideoPlayerState createState() => _ShortVideoPlayerState();
}

class _ShortVideoPlayerState extends State<ShortVideoPlayer> {
  // late BetterPlayerController controller;
  late VideoPlayerController _controller;
  // late CachedVideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    printInfo(info: "video Url=========${widget.videoUrl}");
    // _controller = VideoPlayerController.network(widget.videoUrl)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized
    //     setState(() {});
    //   });

    // setState(() {
    //   _controller.play();
    // });

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        // setState(() {});
      });

    setState(() {
      _controller.play();
      _controller.setLooping(true);
      // _controller.
    });
    _controller.addListener(() {
      // printInfo(
      //     info: "_controller.value.position====${_controller.value.position}");
      printInfo(
          info: "_controller.value.duration====${_controller.value.duration}");
      widget.homeMngmntController!.videoLength.value =
          _controller.value.position.toString();

      if (_controller.value.duration.toString() == "0:00:00.000000") {
      } else {
        setState(() {});
      }

      // _controller.play();
    });

    // printInfo(
    //     info: "_controller.value.position====${_controller.value.position}");
    // printInfo(
    //     info: "_controller.value.duration====${_controller.value.duration}");

    // controller = BetterPlayerController(
    //   BetterPlayerConfiguration(
    //     autoPlay: true,
    //     aspectRatio: 16 / 9,
    //     placeholder: Center(child: CircularProgressIndicator()),
    //     controlsConfiguration: BetterPlayerControlsConfiguration(
    //       enableFullscreen: true,
    //       enableSkips: true,
    //       enableProgressBar: true,
    //     ),
    //   ),
    //   betterPlayerDataSource: BetterPlayerDataSource.network(
    //     'https://ess.nablean.com/media/video_upload/VID_2023-11-21_06-39-312128999891.mp4',
    //     // Replace with your video URL
    //     cacheConfiguration: BetterPlayerCacheConfiguration(
    //       useCache: true,
    //       maxCacheSize: 512 * 1024 * 1024, // 512MB
    //       maxCacheFileSize: 100 * 1024 * 1024, // 100MB
    //     ),
    //   ),
    // );
  }

  // final chewieController = ChewieController(
  //   videoPlayerController: _controller,
  //   autoPlay: true,
  //   looping: false,
  // );

  @override
  Widget build(BuildContext context) {
    // _controller.play();
    return _controller.value.duration.toString() == "0:00:00.000000"
        ? Center(child: CircularProgressIndicator())
        : VideoPlayer(_controller);
    // return BetterPlayer(controller: controller);
    // return Chewie(
    //   controller: ChewieController(
    //     videoPlayerController: _controller,
    //     fullScreenByDefault: true,
    //     autoPlay: true,
    //     looping: false,
    //   ),
    // );
    // Show loading indicator until the video is initialized
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    // controller.dispose();
  }
}

// class VideoListScreen extends StatelessWidget {
//   final List<String> videoUrls = [
//     'https://www.example.com/video1.mp4',
//     'https://www.example.com/video2.mp4',
//     'https://www.example.com/video3.mp4',
//     // Add more video URLs as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TikTok-like Videos'),
//       ),
//       body: TikTokVideoList(videoUrls: videoUrls),
//     );
//   }
// }

// class TikTokVideoList extends StatefulWidget {
//   final List<String> videoUrls;

//   const TikTokVideoList({required this.videoUrls});

//   @override
//   _TikTokVideoListState createState() => _TikTokVideoListState();
// }

// class _TikTokVideoListState extends State<TikTokVideoList> {
//   late PageController _pageController;
//   late VideoPlayerController _videoPlayerController;
//   late ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _initializeVideoPlayer(0);
//   }

//   void _initializeVideoPlayer(int index) {
//     _videoPlayerController =
//         VideoPlayerController.network(widget.videoUrls[index]);
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       aspectRatio: 9 / 16,
//       autoPlay: true,
//       looping: true,
//     );
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PageView.builder(
//       controller: _pageController,
//       itemCount: widget.videoUrls.length,
//       itemBuilder: (context, index) {
//         _initializeVideoPlayer(index);

//         return GestureDetector(
//           onTap: () {
//             // Handle tapping on the video (e.g., pause/play)
//           },
//           child: Stack(
//             alignment: Alignment.bottomCenter,
//             children: [
//               Chewie(controller: _chewieController),
//               VideoOverlayWidget(), // Add your overlay widgets (likes, comments, etc.)
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class VideoOverlayWidget extends StatelessWidget {
//   // Add your overlay widgets (likes, comments, etc.) here

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         // Add your overlay widgets (likes, comments, etc.) here
//       ],
//     );
//   }
// }
