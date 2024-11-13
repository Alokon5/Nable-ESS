// ignore_for_file: unused_local_variable, unnecessary_null_comparison, duplicate_ignore

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/staffList.dart';
import 'package:nable_ess/app/data/models/user_model.dart';
import 'package:nable_ess/app/data/providers/storage_provider.dart';
import 'package:nable_ess/app/modules/manager/videos/controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../data/models/allEmployeesModel.dart';
import '../../../data/models/dateTime.dart';
import '../../../data/models/designationModel/designationModel.dart';
import '../../../data/models/latLongModel/latLongModel.dart';
import '../../../data/models/userDetailsModel.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/locationProvider.dart';

class HomeManagerController extends GetxController {
  APIsProvider apIsProvider = APIsProvider();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  final TextEditingController videoTitleController = TextEditingController();
  final TextEditingController videoDescriptionController =
      TextEditingController();

  final createStaffFormKey = GlobalKey<FormState>();
  final createManagerFormKey = GlobalKey<FormState>();
  late VideoPlayerController playVideosController;

  RxInt totalUser = 0.obs;
  RxInt totalPresent = 0.obs;
  RxInt totalAbsents = 0.obs;

  var isLoading = false.obs;
  var checkOutLoading = false.obs;
  var videoUploadLoading = false.obs;
  var videoCompressLoading = false.obs;
  var user = <UserModel>[].obs;
  var yourVideoList = <Video>[].obs;
  var allEmployeesList = <Datum>[].obs;
  var staffsListed = <Staff>[].obs;

  var checkInList = <CheckIn>[].obs;
  var chekOutList = <CheckOut>[].obs;

  var isChekInDateToday = false.obs;
  var isChekOutDateToday = false.obs;
  var checkInTimeNewStr = "".obs;
  var checkOutTimeNewStr = "".obs;
  var checkInPunctualityNewStr = "".obs;
  var checkOutPunctualityNewStr = "".obs;

  var desgnationList = <DesignationModel>[].obs;
  //widget
  // var selecteMangerID = 1.obs;
  var selectedDesignation = 3.obs;
  var fullName = "".obs;
  var profileImage = "".obs;

  LatLng? latLong;

  var longiTude = "".obs;
  var latiTude = "".obs;

  RxString currentTimeInOut = "".obs;
  RxString currentTimeOut = "".obs;
  RxBool isTimeUpdating = false.obs;

  RxString selectedDate = ''.obs;
  void updateSelectedDate(String date) {
    selectedDate.value = date;
  }

  RxBool isLoadingForEmployeeDetails = false.obs;
  void SetisLoadingForEmployeeDetails(bool value) {
    isLoadingForEmployeeDetails.value = value;
  }

  String formatTime() {
    DateTime now = DateTime.now();

    int hour = now.hour;
    int minute = now.minute;
    int second = now.second;
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert to 12-hour format
    if (hour > 12) {
      hour -= 12;
    } else if (hour == 0) {
      hour = 12;
    }

    // Add leading zero if needed
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');
    String formattedSecond = second.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute:$formattedSecond $period';
  }

  Future getDesignation() async {
    var status = await apIsProvider.getDesignationList(user[0].token);
    if (status!.length.toInt() != 0) {
      desgnationList.assignAll(status);
      selectedDesignation.value = desgnationList[0].id!.toInt();

      print("designationList --=---=-$desgnationList");
    }
  }

  getStaffs() async {
    SetisLoadingForEmployeeDetails(true);
    var staffs = await apIsProvider.fetchStaffs(user[0].token);
    StaffListModel? staffUsersObject;

    if (staffs.staffs!.length == 0) {
      EasyLoading.showError(
        "User not found",
      );
      SetisLoadingForEmployeeDetails(false);
    } else {
      staffUsersObject = staffs;

      staffsListed.assignAll(staffUsersObject.staffs!);

      final presentEmplyeeList = staffsListed.where(
        (element) => element.status == "In Office",
      );
      print("presentEmplyeeList-----${presentEmplyeeList.length}");
      totalUser.value = staffsListed.length;
      totalPresent.value = presentEmplyeeList.length;
      totalAbsents.value = totalUser.value - totalPresent.value;
      SetisLoadingForEmployeeDetails(false);
    }
  }

  dateTimeFormator(dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);

    String formattedTime = DateFormat('h:mm a').format(dateTime);
    String date = "${DateFormat('dd-MMM-yyyy').format(dateTime)}";
    DateTimeModel formatedDateTime =
        DateTimeModel(date: date, time: formattedTime);
    return formatedDateTime;
  }

  getAllUsers() async {
    SetisLoadingForEmployeeDetails(true);
    var userDetailsController = await Get.put(StaffVideocontroller());
    userDetailsController.staffsListed.assignAll(staffsListed);
  }

  getAllPresentUsers() async {
    SetisLoadingForEmployeeDetails(true);
    var userDetailsController = await Get.put(StaffVideocontroller());

    try {
      // totalUser.value = list.length;
      final presentEmplyeeList = staffsListed.where(
        (element) => element.status == "In Office",
      );
      userDetailsController.staffsListed.assignAll(presentEmplyeeList);

      SetisLoadingForEmployeeDetails(false);
    } catch (e) {
      print(e);
      SetisLoadingForEmployeeDetails(false);
    }
  }

  getAllAbsentUsers() async {
    SetisLoadingForEmployeeDetails(true);
    var userDetailsController = await Get.put(StaffVideocontroller());
    printInfo(info: "employeee details");
    try {
      final presentEmplyeeList = staffsListed.where(
        (element) => element.status == "Not In Office",
      );
      userDetailsController.staffsListed.assignAll(presentEmplyeeList);

      SetisLoadingForEmployeeDetails(false);
    } catch (e) {
      print(e);
      SetisLoadingForEmployeeDetails(false);
    }
  }

  getUserDetails() async {
    print("getUser Details");
    isLoading.value = true;

    var status = await apIsProvider.fetchUserDetails(user[0].token, user[0].id);
    if (status != null) {
      fullName.value = "${status.user!.firstName}  ${status.user!.lastName}";
      profileImage.value = status.user!.profileImage.toString();
    }

    UserDetailsModel? staffUsersObject;

    // ignore: unnecessary_null_comparison
    if (status != null) {
      staffUsersObject = status;
      // print("User Details --------${staffUsersObject.user!.email}");

      if (status.user!.status.toString() == "In Office") {
        await GetStorage().write("checkIn", true);
      } else {
        await GetStorage().write("checkIn", false);
      }

      yourVideoList.assignAll(staffUsersObject.video!.toList());
      checkInList.assignAll(status.checkIn!.toList());
      chekOutList.assignAll(status.checkOut!.toList());
      yourVideoList.sort(
        (a, b) => b.id!.compareTo(a.id!),
      );

      // printInfo(info: "chekINLIst data---------${checkInList[0].toJson()}");

      if (chekOutList.length != 0) {
        DateTime now = DateTime.now();
        var object = chekOutList
            .where(
              (element) =>
                  getYearMonthDateFormate(element.createdAt) ==
                  "${now.year}/${now.month}/${now.day}",
            )
            .toList();
        object.length != 0
            ? checkOutPunctualityNewStr.value = object[0].punctuality.toString()
            : "";
        getMatchCheckOutDate(object.length != 0 ? object[0].createdAt : "");
      } else {
        isChekOutDateToday.value = false;
      }
      if (checkInList.length != 0) {
        DateTime now = DateTime.now();
        var object = await checkInList
            .where(
              (element) =>
                  getYearMonthDateFormate(element.createdAt) ==
                  "${now.year}/${now.month}/${now.day}",
            )
            .toList();
        printInfo(info: "this object -=-=---=-=-=-=-${object}");
        object.length != 0
            ? checkInPunctualityNewStr.value = object[0].punctuality.toString()
            : "";
        // printInfo(info: "check it willget ---------------${object.}");
        getMatchCheckInDate(object.length != 0 ? object[0].createdAt : "");
      } else {
        isChekInDateToday.value = false;
      }
      printInfo(
          info:
              "this is if part checkInList.length,,chekOutList.length-------${chekOutList.length},${chekOutList.length}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  bool isOnTimeCheckIn(DateTime checkInTime) {
    DateTime onTimeThreshold =
        DateTime(checkInTime.year, checkInTime.month, checkInTime.day, 9, 31);
    return checkInTime.isBefore(onTimeThreshold);
  }

  getYearMonthDateFormate(createdStr) {
    DateTime createdAt = DateTime.parse(createdStr);
    printInfo(info: "createdStr --=-=-=--=-${checkInTimeNewStr.toString()}");
    // Get the current date

    return "${createdAt.year}/${createdAt.month}/${createdAt.day}";
  }

  getMatchCheckInDate(createdAtString) async {
    if (createdAtString.toString() != "") {
      DateTime createdAt = DateTime.parse(createdAtString);
      printInfo(info: "createdStr --=-=-=--=-${checkInTimeNewStr.toString()}");
      // Get the current date
      DateTime now = DateTime.now();

      printInfo(
          info:
              "Today's date matches the provided date! my zoneStr-----${createdAt.year},${createdAt.month},${createdAt.day}");
      printInfo(
          info:
              "Today's date matches the provided date!--today zone Str---${now.year},${now.month},${now.day}");
      // Compare if the provided date's year, month, and day match the current date's
      if (createdAt.year == now.year &&
          createdAt.month == now.month &&
          createdAt.day == now.day) {
        // printInfo(
        //     info:
        //         "Today's date matches the provided date!-----${createdAt.year},${createdAt.month},${createdAt.day}");

        int hour = createdAt.hour;
        int minute = createdAt.minute;
        String period = hour >= 12 ? 'PM' : 'AM';

        // Convert to 12-hour format
        if (hour > 12) {
          hour -= 12;
        } else if (hour == 0) {
          hour = 12;
        }

        // Add leading zero if needed
        String formattedHour = hour.toString().padLeft(2, '0');
        String formattedMinute = minute.toString().padLeft(2, '0');

        checkInTimeNewStr.value = '$formattedHour:$formattedMinute $period';
        printInfo(
            info: "createdStr --=-=-=--=-${checkInTimeNewStr.toString()}");

        isChekInDateToday.value = true;
        // isChekOutDateToday.value = false;
      } else {
        printInfo(
            info:
                "Today's date did not matches the provided date!-----${createdAtString}");
        isChekInDateToday.value = false;
        // isChekOutDateToday.value = false;
      }
    } else {
      printInfo(
          info:
              "createdStr this is else part --=-=-=--=-${checkInTimeNewStr.toString()}");
      isChekInDateToday.value = false;
      // isChekOutDateToday.value = true;
    }
  }

  getMatchCheckOutDate(createdAtString) async {
    if (createdAtString.toString() != "") {
      DateTime createdAt = DateTime.parse(createdAtString);
      printInfo(info: "createdStr --=-=-=--=-${checkInTimeNewStr.toString()}");
      // Get the current date
      DateTime now = DateTime.now();

      printInfo(
          info:
              "Today's date matches the provided date! my zoneStr-----${createdAt.year},${createdAt.month},${createdAt.day}");
      printInfo(
          info:
              "Today's date matches the provided date!--today zone Str---${now.year},${now.month},${now.day}");
      // Compare if the provided date's year, month, and day match the current date's
      if (createdAt.year == now.year &&
          createdAt.month == now.month &&
          createdAt.day == now.day) {
        // printInfo(
        //     info:
        //         "Today's date matches the provided date!-----${createdAt.year},${createdAt.month},${createdAt.day}");

        int hour = createdAt.hour;
        int minute = createdAt.minute;
        String period = hour >= 12 ? 'PM' : 'AM';

        // Convert to 12-hour format
        if (hour > 12) {
          hour -= 12;
        } else if (hour == 0) {
          hour = 12;
        }

        // Add leading zero if needed
        String formattedHour = hour.toString().padLeft(2, '0');
        String formattedMinute = minute.toString().padLeft(2, '0');

        checkOutTimeNewStr.value = '$formattedHour:$formattedMinute $period';
        printInfo(
            info: "createdStr --=-=-=--=-${checkInTimeNewStr.toString()}");

        isChekOutDateToday.value = true;
      } else {
        printInfo(
            info:
                "Today's date did not matches the provided date!-----${createdAtString}");
        isChekOutDateToday.value = false;
      }
    } else {
      printInfo(
          info:
              "createdStr this is else part --=-=-=--=-${checkInTimeNewStr.toString()}");
      isChekOutDateToday.value = false;
    }
  }

  // Is on time or late history checkin checkout data
  bool isOnTimeCheckOut(DateTime checkInTime) {
    DateTime onTimeThreshold =
        DateTime(checkInTime.year, checkInTime.month, checkInTime.day, 18, 00);
    return checkInTime.isAfter(onTimeThreshold);
  }

  updateCurrentTime() {
    if (isTimeUpdating.value) return;
    isTimeUpdating.value = true;

    currentTimeInOut.value =
        DateFormat('h:mm a').format(DateTime.now()).toString();

    Future.delayed(Duration(seconds: 1), () {
      isTimeUpdating.value = false;
    });
  }

  @override
  void onInit() async {
    isLoading.value = false;
    StorageProvider storageProvider = StorageProvider();

    // TODO: implement onInit
    var userDetails = await storageProvider.readUserModel();
    user.assign(userDetails);
    await getUserDetails();

    if (await GetStorage().read("isGranted") == null) {
      await checkLocationPermissionStatus();
    }
    await getAllManagers();
    await getDesignation();
    await getStaffs();
    _scheduleSetup();
    _updateDateAutomatically();
    super.onInit();
  }

  Future<void> getAllManagers() async {
    isLoading.value = true;
    var employees = await apIsProvider.fetchAllManagers(user[0].token);

    AllEmployeesModel? employeeo;

    if (employees.data!.length == 0) {
      EasyLoading.showSuccess(
        "Employees not found",
      );
    } else {
      employeeo = employees;
      allEmployeesList.assignAll(employeeo.data!);
    }
    isLoading.value = false;
  }

  var selectedGender = "Male".obs;
  List<DropdownMenuItem<String>> get genderItems => [
        DropdownMenuItem<String>(
          value: "Male",
          child: Text("Male"),
        ),
        DropdownMenuItem<String>(
          value: "Female",
          child: Text("Female"),
        ),
      ];

  // Roles list
  var selectedRole = "Staff".obs;
  List<DropdownMenuItem<String>> get roleItems => [
        DropdownMenuItem<String>(
          value: "Staff",
          child: Text("Staff"),
        ),
      ];

  // SetUp Morning, Afternoon and Evening.
  RxString setupMessage = ''.obs;
  void _scheduleSetup() {
    DateTime now = DateTime.now();
    if (_isMorning(now)) {
      setupMessage.value = 'Good Morning';
    } else if (_isAfternoon(now)) {
      setupMessage.value = 'Good Afternoon';
    } else {
      setupMessage.value = 'Good Evening';
    }
  }

  bool _isMorning(DateTime time) {
    return time.hour >= 6 && time.hour < 12;
  }

  bool _isAfternoon(DateTime time) {
    return time.hour >= 12 && time.hour < 17;
  }

  // SetUp Date
  Rx<DateTime> currentDate = DateTime.now().obs;
  void _updateDateAutomatically() {
    // Periodically update the date (e.g., every second)
    Future.delayed(Duration(seconds: 1), () {
      currentDate.value = DateTime.now();
      _updateDateAutomatically();
    });
  }

  createUser() async {
    isLoading.value = true;
    var designation = selectedDesignation.value;
    var status = await apIsProvider.createNewStaff(
        emailController.text,
        passwordController.text,
        firstNameController.text,
        lastNameController.text,
        addressController.text,
        mobileNumberController.text,
        selectedGender,
        selectedRole,
        user[0].id,
        selectedDesignation.value);
    if (status) {
      isLoading.value = false;
      EasyLoading.showSuccess(
        "Staff Created Successful",
      );
    } else {
      isLoading.value = false;
      // EasyLoading.showSuccess(
      //   "Faild to create Staff",
      // );
    }
    isLoading.value = false;
  }

  getCurrentLatLong() async {
    print("current location");
    // isLoading.value = true;

    var latLong = await LocationProvider().getCurrentPosition();

    print("lati----=-=--${latLong.latitude!.toStringAsFixed(3)}");
    print("longi----=-=--${latLong.longitude!.toStringAsFixed(3)}");
    isLoading.value = false;
    if (latLong.latitude != null) {
      isLoading.value = true;
      print("user[0].lati--${user[0].lati} user[0].longi---${user[0].longi}");
      // print("user[0].checkIn--${user[0].checkIn} ");

      if (user[0].lati == latLong.latitude!.toStringAsFixed(3) &&
          user[0].longi == latLong.longitude!.toStringAsFixed(3)) {
        var checkIn = await apIsProvider.checkInHit(user[0].token);
        if (checkIn == true) {
          await getUserDetails();
        }
        // updateCurrentTime();
        isLoading.value = false;
      } else {
        EasyLoading.showError(
            "Make sure you are in correct location , thank you !");
        isLoading.value = false;
      }
    } else {
      EasyLoading.showError("Please check your connection !");
      isLoading.value = false;
    }
  }

  checkOutHit() async {
    // print("user[0]--=-=-=--=-=-${user[0].checkIn}");
    checkOutLoading.value = true;

    var checkOut = await apIsProvider.checkOutHitp(user[0].token);
    print("checkOut----$checkOut");
    if (await checkOut == true) {
      await getUserDetails();
      // print("user[0].checkIn--${user[0].checkIn} ");
      checkOutLoading.value = false;
    } else {
      Get.snackbar("Failed!", "Checkout Failed !");
    }
  }

  void uploadVideoToServer() async {
    print(
        "sjfhoweihbfgo huo ${videoTitleController.text},${videoDescriptionController.text},${videos},thumbnail--${videoThumbnail}");
    if (videoTitleController.text.isNotEmpty &&
        videoDescriptionController.text.isNotEmpty &&
        videos != null) {
      try {
        videoUploadLoading.value = true;
        var uploadTask = await apIsProvider.uploadTask(
          imageThumb,
          videoTitleController.text,
          videoDescriptionController.text,
          videoPathString,
          user[0].token,
        );
        if (uploadTask == true) {
          print("upload Task -=--=-${uploadTask}");
          onInit();
          videoUploadLoading.value = false;
          // Clear the input fields
          videoTitleController.clear();
          videoDescriptionController.clear();
          // Clear the selected video
          selectedVideo.value = null;

          // Show success snackbar
          Get.snackbar(
            'Upload Successful',
            'Video uploaded successfully.',
            snackPosition: SnackPosition.TOP,
          );
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

  Rx<File?> selectedVideo = Rx<File?>(null);
  File? videos;
  RxString videoName = ''.obs;
  RxString videoSize = ''.obs;
  RxString videoDate = ''.obs;
  RxString videoThumbnail = ''.obs;
  String? imageThumb;
  String? videoPathString;

  void selectVideo() async {
    videoCompressLoading.value = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    print("result--=-=-=-=-=-=-=_$result");
    if (result != null) {
      File file = File(result.files.single.path!);
      videos = File(result.files.single.path!);

      selectedVideo.value = file;
      videoName.value = result.files.single.name;
      videoSize.value = '${formatVideoSize(file.lengthSync())}';
      videoDate.value = formatDate(file.lastModifiedSync());
      videoThumbnail.value = await generateVideoThumbnail(selectedVideo.value!);
      imageThumb = await generateVideoThumbnail(selectedVideo.value!);
      videoCompressLoading.value = false;
      _compressVideo(file.path);
    } else {
      videoCompressLoading.value = false;
      EasyLoading.showError("File not find");
    }
  }

  // Video Thumbnail
  Future<String> generateVideoThumbnail(File videoFile) async {
    final thumbnailPath = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
      quality: 50,
    );

    return thumbnailPath ?? "";
  }

  // camera video record
  void selectVideoFromCamera() async {
    videoCompressLoading.value = true;
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      selectedVideo.value = File(video.path);
      videos = File(video.path);

      // Reduce video name length by 57%
      final reducedLength = (videoName.value.length * 0.57).toInt();
      videoName.value = videoName.value.substring(0, reducedLength) + ".mp4";
      videoSize.value = '${formatVideoSize(selectedVideo.value!.lengthSync())}';
      videoDate.value = formatDate(selectedVideo.value!.lastModifiedSync());
      imageThumb = await generateVideoThumbnail(selectedVideo.value!);
      // print("File Path: ${selectedVideo.value}");
      // print("Video Name: ${videoName.value}");
      // print("Video Size: ${videoSize.value}");
      // print("Video Date: ${videoDate.value}");
      // print("Video Thumbnail: $videoThumbnail");
      videoCompressLoading.value = false;
      _compressVideo(video.path);
    } else {
      videoCompressLoading.value = false;
      print("selectedVideo--=-=-=-=-=-=-=_${selectedVideo}");
      // User canceled the file selection.
      print("Not Showing files");
      EasyLoading.showError("File not find");
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
      imageThumb = thumbnailFile.path;
      print("Video info ------${info.toJson()}");
      videoSize.value = formatVideoSize(info.filesize!.toInt());
      videoCompressLoading.value = false;
    } catch (e) {
      videoCompressLoading.value = false;
      print(e);
    }
  }

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

  String formatDate(DateTime? date) {
    if (date != null) {
      return DateFormat('dd-MMM-yyyy').format(date);
    }
    return '';
  }

  checkLocationPermissionStatus() async {
    final status = await Permission.location.status;
    printInfo(info: "status of location permit ----------------${status}");
    if (status.isRestricted) {
      // The user has not yet granted or denied location permission.
      // Show the location usage acceptance popup here.
      // requestLocationPermission();
      // showLocationPermissionDeniedDialog();
      if (await GetStorage().read("isGranted") == null) {
        await GetStorage().write("isGranted", false);
      }
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // The user has denied location permission previously or
      // selected 'Never Ask Again' on the permission popup.
      // You can show a message explaining why you need the permission.
      showLocationPermissionDeniedDialog();
    } else if (status.isGranted) {
      if (await GetStorage().read("isGranted") == null) {
        await GetStorage().write("isGranted", true);
      }
      // Location permission is already granted.
      // You can proceed with location-based functionality.
      // For example, navigate to a map view or get the user's location.
      // await getCurrentLatLong();
      // showLocationPermissionDeniedDialog();
    }
  }

  showLocationPermissionDeniedDialog() async {
    await Get.dialog(
      AlertDialog(
        title: Text(
          'Allow Location Access',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            // letterSpacing: 0.25,
            color: Colors.black,
          ),
        ),
        content: SizedBox(
          height: 260.h,
          child: Column(
            children: [
              Text(
                'NABLE ESS would like to access your location.',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  // letterSpacing: 0.25,
                  color: Colors.black,
                ),
              ),
              Text(
                'We use your location to provide you with personalized services and improve your experience. By enabling location access, you can enjoy following features',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  // letterSpacing: 0.25,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Employee Check-In and Check-Out:',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    // letterSpacing: 0.25,
                    color: Colors.black,
                  ),
                ),
              ),
              Text(
                'Employees can easily mark their attendance by using the Check-In and Check-Out feature.',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  // letterSpacing: 0.25,
                  color: Colors.black,
                ),
              ),
              Text(
                'The app utilizes background location access to ensure attendance is recorded only within the designated geo-location, enhancing attendance accuracy and preventing misuse. ',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  // letterSpacing: 0.25,
                  color: Colors.black,
                ),
              ),
              Text(
                'Automated reminders for check-ins and check-outs help employees stay on track.',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  // letterSpacing: 0.25,
                  color: Colors.black,
                ),
              ),
              Text(
                'Your location data is securely stored and never shared with third parties without your consent. You can change your location preferences anytime in the app`s settings.',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  // letterSpacing: 0.25,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Continue',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                // letterSpacing: 0.25,
                color: Colors.black,
              ),
            ),
            onPressed: () async {
              await GetStorage().write("isGranted", false);
              Get.back(); // Close the dialog
            },
          ),
          ElevatedButton(
            child: Text(
              'Next',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                // letterSpacing: 0.25,
                color: Colors.black,
              ),
            ),
            onPressed: () async {
              // Perform logout logic here
              // Close the dialog
              final status = await Permission.location.status;
              printInfo(
                  info:
                      "status of location permit after alow ----------------${status}");
              await GetStorage().write("isGranted", true);
              Get.back();
              // await getCurrentLatLong();
            },
          ),
        ],
      ),
    );
  }
}
