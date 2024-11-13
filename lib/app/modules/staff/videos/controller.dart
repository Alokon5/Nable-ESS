// ignore_for_file: unnecessary_null_comparison, unused_local_variable, duplicate_ignore

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../../data/models/staffList.dart';
import '../../../data/models/userDetailsModel.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/storage_provider.dart';

class VideoController extends GetxController {
  StorageProvider storageProvider = StorageProvider();
  APIsProvider apIsProvider = APIsProvider();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  var user = <UserModel>[].obs;

  var staffsListed = <Staff>[].obs;

  var userDetails = <UserDetailsModel>[].obs;
  var staffVideos = <Video>[].obs;
  List<Video> videoList = <Video>[].obs;
  User? staffUserDetails;
  late VideoPlayerController playVideosController;

  var isLoading = false.obs;
  var videoUploadLoading = false.obs;
  var videoCompressLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    var userDetails = await storageProvider.readUserModel();
    user.assign(userDetails);
    // await getStaffs();
    await getUserDetails(user[0].id);
  }

  getStaffs() async {
    var staffs = await apIsProvider.fetchStaffs(user[0].token);
    StaffListModel? staffUsersObject;

    if (staffs.staffs!.length == 0) {
      EasyLoading.showSuccess(
        "User not found",
      );
    } else {
      staffUsersObject = staffs;
      staffsListed.assignAll(staffUsersObject.staffs!);
    }
  }

  getUserDetails(id) async {
    print("getUser Details");
    isLoading.value = true;

    var status = await apIsProvider.fetchUserDetails(user[0].token, id);
    // print("status-------=-=--${status.checkIn}");

    UserDetailsModel? staffUsersObject;

    // ignore: unnecessary_null_comparison
    if (status != null) {
      staffUsersObject = status;
      // print("User Details --------${staffUsersObject.user!.email}");
      staffUserDetails = staffUsersObject.user;
      staffVideos.assignAll(staffUsersObject.video!.toList());
      videoList.assignAll(staffUsersObject.video!.toList());
      staffVideos.sort((a, b) => b.id!.compareTo(a.id!));
      videoList.sort((a, b) => b.id!.compareTo(a.id!));
      print("video list -=-=-=- ${staffUsersObject.video!}");
      print("videoList -=-=-=- ${videoList.length}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  // Video Section
  Rx<File?> selectedVideo = Rx<File?>(null);
  File? selectedVideoFile;
  RxString videoName = ''.obs;
  RxString videoSize = ''.obs;
  RxString videoDate = ''.obs;
  RxString videoThumbnail = ''.obs;
  String? uploadVideoThumbnail;
  String? videoPathString = '';

  void selectVideo() async {
    videoCompressLoading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    print("result--=-=-=-=-=-=-=_$result");
    if (result != null) {
      File file = File(result.files.single.path!);
      selectedVideoFile = File(result.files.single.path!);
      selectedVideo.value = file;
      print("file path: ${file}");
      videoName.value = result.files.single.name;
      videoSize.value = '${formatVideoSize(file.lengthSync())}';
      videoDate.value = formatDate(file.lastModifiedSync());
      videoThumbnail.value = await generateVideoThumbnail(selectedVideo.value!);
      uploadVideoThumbnail = await generateVideoThumbnail(selectedVideo.value!);
      await _compressVideo(selectedVideoFile!.path);
      print(
          "result--=-=-=-=-=-=-=_${await generateVideoThumbnail(selectedVideo.value!)}");
      print("selectedVideo--=-=-=-=-=-=-=_${selectedVideo}");
      videoCompressLoading.value = false;
    } else {
      print("selectedVideo--=-=-=-=-=-=-=_${selectedVideo}");
      // User canceled the file selection.
      print("Not Showing files");
      EasyLoading.showError("File not find");
      videoCompressLoading.value = false;
    }
  }

  _compressVideo(String videoPath) async {
    try {
      videoCompressLoading.value = true;
      await VideoCompress.setLogLevel(0);
      final MediaInfo? info = await VideoCompress.compressVideo(
        videoPath,
        quality: VideoQuality.LowQuality,
        deleteOrigin: false,
        includeAudio: true,
      );
      final thumbnailFile = await VideoCompress.getFileThumbnail(
        videoPath,
        quality: 25, // default(100)
        position: -1, // default(-1)
      );

      videoPathString = info!.path!.toString();
      uploadVideoThumbnail = thumbnailFile.path;
      print("Video info ------${info.toJson()}");
      videoSize.value = formatVideoSize(info.filesize!.toInt());
      videoCompressLoading.value = false;
    } catch (e) {
      videoCompressLoading.value = false;
      print(e);
    }
    // if (info != null) {
    //   setState(() {
    //     _counter = info.path!;
    //   });
    // }
  }

  void uploadVideoToServer() async {
    print(
        "sjfhoweihbfgo huo ${titleController.text},${descriptionController.text},${selectedVideoFile},thumbnail--${videoThumbnail}");
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        selectedVideoFile != null) {
      try {
        videoUploadLoading.value = true;
        var uploadTask = await apIsProvider.uploadTask(
          uploadVideoThumbnail,
          titleController.text,
          descriptionController.text,
          videoPathString,
          user[0].token,
        );
        if (uploadTask == true) {
          onInit();
          videoUploadLoading.value = false;
          // Clear the input fields
          titleController.clear();
          descriptionController.clear();
          // Clear the selected video
          selectedVideo.value = null;

          // Show success snackbar
          // Get.snackbar(
          //   'Upload Successful',
          //   'Video uploaded successfully.',
          //   snackPosition: SnackPosition.TOP,
          // );
        }
        videoUploadLoading.value = false;
      } catch (e) {
        // Show error snackbar
        Get.snackbar(
          'Upload Error',
          'Failed to upload the video. Please try again.',
          snackPosition: SnackPosition.TOP,
        );
        print('Exception during video upload: $e');
        videoUploadLoading.value = false;
      }
    } else {
      Get.snackbar(
        'Upload Error',
        'Title, description, or video file is missing.',
        snackPosition: SnackPosition.TOP,
      );
      print('Title, description, or video file is missing.');
    }
  }

  // Video Thumbnail
  Future<String> generateVideoThumbnail(File videoFile) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      quality: 75,
    );
    return thumbnailPath ?? "";
  }

  // camera video record
  void selectVideoFromCamera() async {
    videoCompressLoading.value = true;
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(
      source: ImageSource.camera,
    );
    if (video != null) {
      selectedVideo.value = File(video.path);
      selectedVideoFile = File(video.path);

      // Reduce video name length by 57%
      final reducedLength = (videoName.value.length * 0.57).toInt();
      videoName.value = videoName.value.substring(0, reducedLength) + ".mp4";
      videoSize.value = '${formatVideoSize(selectedVideo.value!.lengthSync())}';
      videoDate.value = formatDate(selectedVideo.value!.lastModifiedSync());
      uploadVideoThumbnail = await generateVideoThumbnail(selectedVideo.value!);
      print("File Path: ${selectedVideo.value}");
      print("Video Name: ${videoName.value}");
      print("Video Size: ${videoSize.value}");
      print("Video Date: ${videoDate.value}");
      print("Video Thumbnail: $videoThumbnail");
      _compressVideo(video.path);
      // videoCompressLoading.value = false;
    } else {
      print("selectedVideo--=-=-=-=-=-=-=_${selectedVideo}");
      // User canceled the file selection.
      print("Not Showing files");
      EasyLoading.showError("File not find");
      videoCompressLoading.value = false;
    }
  }

  // video compresser
  // Future<void> _compressVideo(String videoPath) async {
  //   try {
  //     await VideoCompress.setLogLevel(0);
  //     final MediaInfo? info = await VideoCompress.compressVideo(
  //       videoPath,
  //       quality: VideoQuality.DefaultQuality,
  //       deleteOrigin: false,
  //       includeAudio: true,
  //     );
  //     final thumbnailFile = await VideoCompress.getFileThumbnail(
  //       videoPath,
  //       quality: 50,
  //       position: -1,
  //     );
  //     if (info != null && thumbnailFile != null) {
  //       this.videoPath.value = info.path!;
  //       videoThumbnail.value = thumbnailFile.path;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Video Size
  String formatVideoSize(int fileSize) {
    if (fileSize < 1024) {
      return '$fileSize bytes';
    } else if (fileSize < 1024 * 1024) {
      double sizeInKB = fileSize / 1024;
      return '${sizeInKB.toStringAsFixed(2)} KB';
    } else {
      double sizeInMB = fileSize / (1024 * 1024);
      return '${sizeInMB.toStringAsFixed(2)} MB';
    }
  }

  // Video Upload DateFormat
  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd-MMM-yyyy').format(date);
    }
    return '';
  }
}
