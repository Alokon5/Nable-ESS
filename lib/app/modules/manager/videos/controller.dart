import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nable_ess/app/data/models/staffList.dart';
import 'package:nable_ess/app/data/models/userDetailsModel.dart';
import 'package:video_player/video_player.dart';

import '../../../data/models/dateTime.dart';
import '../../../data/models/designationModel/designationModel.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/workDetailModel/datePairModel.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/storage_provider.dart';

class StaffVideocontroller extends GetxController {
  StorageProvider storageProvider = StorageProvider();
  APIsProvider apIsProvider = APIsProvider();

  var user = <UserModel>[].obs;

  var staffsListed = <Staff>[].obs;
  var userDetails = <UserDetailsModel>[].obs;
  var desgnationList = <DesignationModel>[].obs;
  var selectedListTile = 0.obs;
  var staffVideos = <Video>[].obs;
  var videoList = <Video>[].obs;

  var staffName = ''.obs;
  var staffProfilePhoto = ''.obs;
  var staffEmail = ''.obs;
  var staffId = ''.obs;

  User? detailsStaff;
  late VideoPlayerController playVideosController;

  var isLoading = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    isLoading.value = false;
    super.onInit();

    var userDetails = await storageProvider.readUserModel();
    user.assign(userDetails);
    await getStaffs();
    await getDesignation();
    // await getUserDetails(user[0].id);
  }

  getStaffs() async {
    var staffs = await apIsProvider.fetchStaffs(user[0].token);
    StaffListModel? staffUsersObject;

    if (staffs.staffs!.length == 0) {
      EasyLoading.showError(
        "User not found",
      );
    } else {
      staffUsersObject = staffs;

      staffsListed.assignAll(staffUsersObject.staffs!);
    }
  }

  Future getDesignation() async {
    var status = await apIsProvider.getDesignationList(user[0].token);
    if (status!.length.toInt() != 0) {
      desgnationList.assignAll(status);
    }
  }

  getDesignationNameViaId(id) {
    var obj = desgnationList.where((p0) => p0.id == id).first;
    // print("object -=-=-=-=-${obj.name}");
    return obj.name;
  }

  dateTimeFormator(dateTimeStr) {
    DateTime dateTime = DateTime.parse(dateTimeStr);
    // print(dateTimeStr);

    String formattedTime = DateFormat('h:mm a').format(dateTime);
    String date = "${DateFormat('dd-MMM-yyyy').format(dateTime)}";
    // print("date -=--=-$date");
    // print("time -=--=-$formattedTime");
    var formatedDateTime = DateTimeModel(date: date, time: formattedTime);
    return formatedDateTime;
  }

  DatePair getCurrentAndDateBefore27Days() {
    final now = DateTime.now();
    final dateBefore27Days = now.subtract(Duration(days: 27));

    final currentDateFormatted = DateFormat('yyyy-MM-dd').format(now);
    final dateBefore27DaysFormatted =
        DateFormat('yyyy-MM-dd').format(dateBefore27Days);
    // startDateFilter.text = dateBefore27DaysFormatted;
    // endDateFilter.text = currentDateFormatted;
    // generateDateList(startDateFilter.text, endDateFilter.text);
    printInfo(info: "Today Date is--==-=-=---=--${currentDateFormatted}");
    return DatePair(currentDateFormatted, dateBefore27DaysFormatted);
  }

  getUserDetails(id) async {
    print("getUser Details $id");
    isLoading.value = true;

    var status = await apIsProvider.fetchUserDetails(user[0].token, id);
    print("status-------=-=--${status.user!.firstName}");

    UserDetailsModel? staffUsersObject;

    // ignore: unnecessary_null_comparison
    if (status != null) {
      staffUsersObject = status;
      // print("User Details --------${staffUsersObject.user!.email}");
      detailsStaff = staffUsersObject.user;
      staffVideos.assignAll(staffUsersObject.video!.toList());
      videoList.assignAll(staffUsersObject.video!.toList());
      staffVideos.sort((a, b) => b.id!.compareTo(a.id!));
      videoList.sort((a, b) => b.id!.compareTo(a.id!));

      print("video list -=-=-=- ${staffUsersObject.video!}");
      print("videoList -=-=-=- ${videoList.length}");
      print("id -=-=-=- ${detailsStaff!.id}");
      // print("userVideoList -=-=-=- ${staffVideos[0].description}");
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
