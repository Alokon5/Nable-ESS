// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/models/dateTime.dart';
import '../../../data/models/latLongModel/latLongModel.dart';
import '../../../data/models/userDetailsModel.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/locationProvider.dart';
import '../../../data/providers/storage_provider.dart';
// import '../profile/controller.dart';

class StaffHomeController extends GetxController {
  APIsProvider apIsProvider = APIsProvider();
  var user = <UserModel>[].obs;
  var checkOutLoading = false.obs;
  var isLoading = false.obs;

  LatLng? latLong;

  var checkInList = <CheckIn>[].obs;
  var chekOutList = <CheckOut>[].obs;
  var isChekInDateToday = false.obs;
  var isChekOutDateToday = false.obs;
  var checkInTimeNewStr = "".obs;
  var checkOutTimeNewStr = "".obs;
  var checkInPunctualityNewStr = "".obs;
  var checkOutPunctualityNewStr = "".obs;

  List<Video> videoList = <Video>[].obs;

  var longiTude = "".obs;
  var latiTude = "".obs;

  var selectedGender = "Male".obs;
  var fullName = "".obs;
  var profileImage = "".obs;

  RxString currentTimeInOut = "".obs;
  RxBool isTimeUpdating = false.obs;

  RxString selectedDate = ''.obs;
  void updateSelectedDate(String date) {
    selectedDate.value = date;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    StorageProvider storageProvider = StorageProvider();
    var userDetails = await storageProvider.readUserModel();
    user.assign(userDetails);
    await userDetailsStatus();
    if (await GetStorage().read("isGranted") == null) {
      await checkLocationPermissionStatus();
    }
    await updateDetails();
    print("currentTimeInOut.value-=-=-=-=-=-=--=-${currentTimeInOut.value}");
    _scheduleSetup();
    _updateDateAutomatically();
  }

  void sendScheduleNotification(String title, String body) async {
    var scheduledNotificationDateTime = DateTime.now().add(Duration(days: 28
        // minutes: 1,
        ));

    // AndroidNotificationDetails androidNotificationDetails =
    //     AndroidNotificationDetails(
    //         "channelId", "channelName", "channelDescription",
    //         importance: Importance.max,
    //         playSound: true,
    //         showWhen: true,
    //         priority: Priority.high);
    // NotificationDetails notificationDetails =
    //     NotificationDetails(android: androidNotificationDetails);

    // await _flutterLocalNotificationsPlugin.schedule(
    //     0, title, body, scheduledNotificationDateTime, notificationDetails);
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

  updateCurrentTime() {
    if (isTimeUpdating.value) return;
    isTimeUpdating.value = true;

    currentTimeInOut.value =
        DateFormat('h:mm a').format(DateTime.now()).toString();

    Future.delayed(Duration(seconds: 1), () {
      isTimeUpdating.value = false;
    });
  }

  userDetailsStatus() async {
    isLoading.value = true;
    var status = await apIsProvider.fetchUserDetails(user[0].token, user[0].id);
    printInfo(info: "status of user Details-----------${status.user!.status} ");
    if (status.user!.status.toString() == "In Office") {
      await GetStorage().write("checkIn", true);
    } else {
      await GetStorage().write("checkIn", false);
    }
  }

  // SetUp Morning, Afternoon and Evening.
  RxString setupMessage = ''.obs;
  void _scheduleSetup() {
    DateTime now = DateTime.now();
    if (_isMorning(now)) {
      setupMessage.value = 'Morning, ';
    } else if (_isAfternoon(now)) {
      setupMessage.value = 'Afternoon, ';
    } else {
      setupMessage.value = 'Evening, ';
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

  getCurrentLatLong() async {
    // final StaffProfileController staffProfileController =
    //     Get.put(StaffProfileController());
    print("current location");
    isLoading.value = true;
    var latLong = await LocationProvider().getCurrentPosition();
    isLoading.value = false;

    // print("lati----=-=--${latLong.latitude!.toStringAsFixed(4)}");
    // print("longi----=-=--${latLong.longitude!.toStringAsFixed(4)}");
    if (latLong.latitude != null) {
      isLoading.value = true;
      print("user[0].lati--${user[0].lati} user[0].longi---${user[0].longi}");
      print("user[0].checkIn--${user[0].checkIn} ");

      if (user[0].lati == latLong.latitude!.toStringAsFixed(3) &&
          user[0].longi == latLong.longitude!.toStringAsFixed(3)) {
        var checkIn = await apIsProvider.checkInHit(user[0].token);
        if (checkIn == true) {
          updateCurrentTime();
          await updateDetails();
          // staffProfileController.onInit();
          // print("check In Time ====${dateTimeFormator(checkInList[0].createdAt).time}");
        }
        isLoading.value = false;
        print("storage.read(checkIn)-=-=-=-${GetStorage().read("checkIn")}");
      } else {
        EasyLoading.showError(
            "Make sure you are in correct location , thank you !");
        isLoading.value = false;
      }
    } else {
      EasyLoading.showError("Please check your connection and try again !");
      isLoading.value = false;
    }
  }

  checkOutHit() async {
    // final StaffProfileController staffProfileController =
    //     Get.put(StaffProfileController());

    print("user[0]--=-=-=--=-=-${user[0].checkIn}");
    checkOutLoading.value = true;

    var checkOut = await apIsProvider.checkOutHitp(user[0].token);
    if (checkOut == true) {
      updateCurrentTime();
      await updateDetails();
      // print(
      //     "CheckOut In Time ====${dateTimeFormator(chekOutList[0].createdAt).time}");
      checkOutLoading.value = false;
    }
  }

  updateDetails() async {
    isLoading.value = true;

    var userDetails =
        await apIsProvider.fetchUserDetails(user[0].token, user[0].id);
    checkInList.assignAll(userDetails.checkIn!.toList());
    chekOutList.assignAll(userDetails.checkOut!.toList());
    checkInList.sort((a, b) => b.id!.compareTo(a.id!));
    chekOutList.sort((a, b) => b.id!.compareTo(a.id!));
    videoList.assignAll(userDetails.video!.toList());
    print("videoList Length----------------=======${videoList.length}");
    if (userDetails.user != null) {
      fullName.value =
          "${userDetails.user!.firstName}  ${userDetails.user!.lastName}";
      profileImage.value = userDetails.user!.profileImage.toString();
    }

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

    isLoading.value = false;
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

  dateTimeFormator(dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);

    String formattedTime = DateFormat('h:mm a').format(dateTime);
    String date = "${DateFormat('dd-MMM-yyyy').format(dateTime)}";
    DateTimeModel formatedDateTime =
        DateTimeModel(date: date, time: formattedTime);
    return formatedDateTime;
  }

  var checkInStatusIn = "".obs;

  void isOnTimeCheckIn(List<CheckIn> checkInList) {
    final lateStatus = "Late";
    final onTimeStatus = "On Time";

    DateFormat timeFormat = DateFormat("h:mm a");
    DateTime currentTime = DateTime.now();
    String currentTimeStr = timeFormat.format(currentTime);

    // Parse the current time and target time strings into TimeOfDay objects

    DateTime currentDateTime = timeFormat.parse(checkInList.length != 0
        ? dateTimeFormator(checkInList[0].createdAt).time
        : currentTimeStr);
    TimeOfDay currentTimeOfDay = TimeOfDay.fromDateTime(currentDateTime);

    DateTime targetDateTime = timeFormat.parse("9:30 AM");
    TimeOfDay targetTimeOfDay = TimeOfDay.fromDateTime(targetDateTime);

    // Compare the times
    if (currentTimeOfDay.hour < targetTimeOfDay.hour ||
        (currentTimeOfDay.hour == targetTimeOfDay.hour &&
            currentTimeOfDay.minute <= targetTimeOfDay.minute)) {
      checkInStatusIn.value = onTimeStatus;
    } else {
      checkInStatusIn.value = lateStatus;
    }
  }

  var checkOutStatusOut = "".obs;

  void isOnTimeCheckOut(List<CheckOut> chekOutList) {
    final earlyLeftStatus = "Early Left";
    final onTimeStatus = "On Time";

    DateFormat timeFormat = DateFormat("h:mm a");
    DateTime currentTime = DateTime.now();
    String currentTimeStr = timeFormat.format(currentTime);

    // Parse the current time and target times into TimeOfDay objects
    DateTime currentDateTime =
        timeFormat.parse(dateTimeFormator(chekOutList[0].createdAt).time);
    TimeOfDay currentTimeOfDay = TimeOfDay.fromDateTime(currentDateTime);

    DateTime targetTimePM = timeFormat.parse("6:00 PM");
    TimeOfDay targetTimePMOfDay = TimeOfDay.fromDateTime(targetTimePM);

    // Compare the times
    if (currentTimeOfDay.hour > targetTimePMOfDay.hour ||
        (currentTimeOfDay.hour == targetTimePMOfDay.hour &&
            currentTimeOfDay.minute >= targetTimePMOfDay.minute)) {
      checkOutStatusOut.value = onTimeStatus;
    } else {
      checkOutStatusOut.value = earlyLeftStatus;
    }
  }

  // Is on time or late history checkin checkout data
  // bool isOnTimeCheckOut(DateTime checkInTime) {
  //   DateTime onTimeThreshold =
  //       DateTime(checkInTime.year, checkInTime.month, checkInTime.day, 18, 00);
  //   return checkInTime.isAfter(onTimeThreshold);
  // }

  Future<void> checkLocationPermissionStatus() async {
    final status = await Permission.location.status;
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
      // Location permission is already granted.
      // You can proceed with location-based functionality.
      // For example, navigate to a map view or get the user's location.
      if (await GetStorage().read("isGranted") == null) {
        await GetStorage().write("isGranted", true);
      }
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
          height: 250.h,
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
