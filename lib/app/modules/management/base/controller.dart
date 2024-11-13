import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/data/models/allVideosModel/allVideoModel.dart';
import 'package:nable_ess/app/modules/management/clockIn/view.dart';
import 'package:nable_ess/app/modules/management/documents/documents.dart';
import 'package:nable_ess/app/modules/management/profile/profile.dart';
import 'package:nable_ess/app/modules/management/usersDetails/view.dart';

import '../../../core/mediaPlayer/playShortVideos.dart';
import '../../../data/models/requiestedLeaveModel/requiestedLeaveModel.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/storage_provider.dart';
import '../home/view.dart';
import '../videos/playVideos.dart';

class ManagementController extends GetxController {
  APIsProvider apIsProvider = APIsProvider();
  var index = 0.obs;
  var isLoading = false.obs;

  var user = <UserModel>[].obs;
  var requestedLeave = <RequestedLeaveModel>[].obs;
  var newRequestList = <RequestedLeaveModel>[].obs;
  var allVideos = <AllVideosData>[].obs;
  var showBadge = false.obs;
  void changeChipIndex(int value) {
    index.value = value;
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    StorageProvider storageProvider = StorageProvider();

    var userDetails = await storageProvider.readUserModel();
    user.assign(userDetails);
    // await getAllVideos();
    await getRequestedLeave();
  }

  List<Widget> widgetOptions = <Widget>[
    HomeManagement(),
    AllVideos(),
    UsersScreen(),
    ClockInView(),
    DocumentsScreen(),
  ].obs;

  getAllVideos() async {
    isLoading.value = true;
    var status = await apIsProvider.fetchAllVideos(user[0].token);

    if (status != null) {
      allVideos.assignAll(status.data!.toList());
      allVideos.sort((a, b) => b.id!.compareTo(a.id!));

      print("All Videos-=-=-${allVideos.length}");
      isLoading.value = false;
    } else {
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  getRequestedLeave() async {
    newRequestList.clear();
    var list = await apIsProvider.getAllRequestedLeave(user[0].token);
    // print("showBadge--=-=---=-${showBadge}");
    print("list -------${list!.length}");
    if (list.length.toInt() != 0) {
      requestedLeave.assignAll(list);
      for (int i = 0; i < requestedLeave.length; i++) {
        if (requestedLeave[i].seen == false) {
          var object = requestedLeave.removeAt(i);
          requestedLeave.insert(0, object);
          newRequestList.add(object);

          print("showBadge--=-=---=-${showBadge}");
        }
        print("showBadge--=-=---=-${showBadge}");
      }
      // print("list of requested----${list}");
    } else {}
  }
}
