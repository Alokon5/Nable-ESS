// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nable_ess/app/core/mediaPlayer/widgets/mediaPlayer.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/data/models/allVideosModel/allVideoModel.dart';
import 'package:nable_ess/app/data/models/userDetailsModel.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/manager/home/uploadTask/upload.dart';
import 'package:share_plus/share_plus.dart';

class ShortsPlayOneStaff extends StatefulWidget {
  // final List<Post> postDetails;
  final AllVideosData? anVideoObject;
  final List<Video>? allVideoList;

  final int? index;
  ShortsPlayOneStaff({
    Key? key,
    this.anVideoObject,
    this.index,
    this.allVideoList,
  }) : super(key: key);

  @override
  State<ShortsPlayOneStaff> createState() => _ShortsPlayOneStaffState();
}

class _ShortsPlayOneStaffState extends State<ShortsPlayOneStaff> {
  Color likeBtnColor = Colors.white,
      dislikeBtnColor = Colors.white,
      subscribeBtnColor = Colors.red;
  double iconSize = 33;
  TextStyle textStyle1 = const TextStyle(
    color: Colors.white,
    fontSize: 15,
  );
  bool likeBtnSwitch = false, dislikeBtnSwitch = false, subscribeSwitch = false;
  String subscribeText = 'Subscribe';

  void showAlertDialog(BuildContext context, int index) {
    Widget cancelButton = TextButton(
      child: const Text(
        'Cancel',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        'Unsubscribe',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        setState(() {
          subscribeText = 'Subscribe';
          subscribeBtnColor = Colors.red;
          subscribeSwitch = false;
        });
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      // content: Text(
      //   'Unsubscribe from\n@${widget.postDetails[index].creator.handle}?',
      //   style: const TextStyle(fontSize: 19),
      // ),
      content: Text(
        'Unsubscribe from\n@?',
        style: const TextStyle(fontSize: 19),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // printInfo(info: "thilshofhoshbvsvo");
    return SafeArea(
      child: (widget.allVideoList!.length != 0)
          ? Scaffold(
              backgroundColor: Colors.black38,

              // floatingActionButton:
              //     Text(widget.anVideoObject!.description.toString()),
              body: PageView.builder(
                //to make the whole page scrollable
                itemCount: widget.allVideoList!.length,
                controller: PageController(
                    initialPage: widget.index!.toInt(), viewportFraction: 1),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Stack(
                    //to put all other elements on top of the video
                    children: [
                      ShortsPlayer(
                        shortsUrl:
                            "${APIsProvider.mediaBaseUrl}${widget.allVideoList![index].video.toString()}",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: Icon(Icons.arrow_back_ios_rounded),
                                    color: Colors.black87,
                                  ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     Navigator.of(context).pop();
                                  //   },
                                  //   icon: const Icon(
                                  //     Icons.arrow_back_outlined,
                                  //     color: Colors.white,
                                  //   ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                  IconButton(
                                    onPressed: () {
                                      // await ImagePicker().pickImage(
                                      //     source: ImageSource.camera);
                                      Get.to(() => UploadTask());
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
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
                                                          builder: (BuildContext
                                                              context) {
                                                            return Container(
                                                              color: const Color(
                                                                  0xff1A1818),
                                                              width: double
                                                                  .infinity,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(25),
                                                                child: Text(
                                                                  widget
                                                                      .allVideoList![
                                                                          index]
                                                                      .description
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        10,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        25),
                                                            child: Icon(
                                                              Icons
                                                                  .notes_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 27,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Description',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        25),
                                                            child: Icon(
                                                              Icons
                                                                  .closed_caption_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 27,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Captions',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        25),
                                                            child: Icon(
                                                              Icons
                                                                  .do_not_disturb_alt_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 27,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Don\'t recommend this channel',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        25),
                                                            child: Icon(
                                                              Icons
                                                                  .outlined_flag_rounded,
                                                              color:
                                                                  Colors.white,
                                                              size: 27,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Report',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 15),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        25),
                                                            child: Icon(
                                                              Icons
                                                                  .feedback_outlined,
                                                              color:
                                                                  Colors.white,
                                                              size: 27,
                                                            ),
                                                          ),
                                                          Text(
                                                            'Send feedback',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                  ),
                                ],
                              ),
                            ],
                          ),

                          //lower-operations row
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 15),
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
                                              "${APIsProvider.mediaBaseUrl}${widget.allVideoList![index].thumbnail}"),
                                          radius: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            width: 150.w,
                                            child: Text(
                                              '${widget.allVideoList![index].title}',
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
                                          widget
                                              .allVideoList![index].description
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
                                SizedBox(
                                  child: Column(
                                    children: [
                                      //like btn
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (likeBtnSwitch) {
                                                likeBtnSwitch = false;
                                                // widget.postDetails[index]
                                                //     .reaction.count--;
                                                likeBtnColor = Colors.white;
                                              } else {
                                                likeBtnSwitch = true;
                                                // widget.postDetails[index]
                                                //     .reaction.count++;
                                                likeBtnColor = Colors.blue;
                                                if (dislikeBtnSwitch) {
                                                  dislikeBtnColor =
                                                      Colors.white;
                                                }
                                              }
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.thumb_up_rounded,
                                                color: likeBtnColor,
                                                size: iconSize,
                                              ),
                                              Text(
                                                "2",
                                                style: textStyle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //dislike btn
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (dislikeBtnSwitch) {
                                                dislikeBtnSwitch = false;
                                                dislikeBtnColor = Colors.white;
                                              } else {
                                                dislikeBtnSwitch = true;
                                                dislikeBtnColor = Colors.blue;
                                                if (likeBtnSwitch) {
                                                  // widget.postDetails[index]
                                                  //     .reaction.count--;
                                                  likeBtnColor = Colors.white;
                                                  likeBtnSwitch = false;
                                                }
                                              }
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.thumb_down_rounded,
                                                color: dislikeBtnColor,
                                                size: iconSize,
                                              ),
                                              Text(
                                                'Dislike',
                                                style: textStyle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //comment btn
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
                                        child: InkWell(
                                          // onTap: (){
                                          //   setState(() {
                                          //     //open modal box
                                          //   });
                                          // },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.comment_rounded,
                                                color: Colors.white,
                                                size: iconSize,
                                              ),
                                              Text(
                                                "6",
                                                style: textStyle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //save btn
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
                                        child: InkWell(
                                          // onTap: (){
                                          //   setState(() {
                                          //     //open share modal box
                                          //   });
                                          // },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.bookmark_border_rounded,
                                                color: Colors.white,
                                                size: iconSize,
                                              ),
                                              Text(
                                                'Save',
                                                style: textStyle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // share btn
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 25),
                                        child: InkWell(
                                          onTap: () {
                                            Share.share(
                                                "${APIsProvider.mediaBaseUrl}${widget.allVideoList![index].video}");
                                          },
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.share_rounded,
                                                color: Colors.white,
                                                size: iconSize,
                                              ),
                                              Text(
                                                'Share',
                                                style: textStyle1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            )
          : const Center(
              // child: SpinKitSpinningLines(
              //   color: Colors.greenAccent,
              //   size: 200,
              //   lineWidth: 3,
              // ),
              child: CircularProgressIndicator(
                color: ColorConstant.primaryDark,
                backgroundColor: Colors.transparent,
              ),
            ),
    );
  }
}
