import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/checkIn/checkIn.dart';
import 'package:nable_ess/app/modules/manager/documents/documents.dart';
import 'package:nable_ess/app/modules/manager/videos/view.dart';
import 'package:nable_ess/app/modules/manager/vlog/vlog.dart';

import '../../../data/models/requiestedLeaveModel/requiestedLeaveModel.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/apis_provider.dart';
import '../../../data/providers/storage_provider.dart';
import '../home/homeManager.dart';
import '../profile/profileManager.dart';

class ManagerController extends GetxController {
  APIsProvider apIsProvider = APIsProvider();
  var index = 0.obs;
  var user = <UserModel>[].obs;
  var requestedLeave = <RequestedLeaveModel>[].obs;
  var newRequestedLeave = <RequestedLeaveModel>[].obs;
  var showBadge = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    StorageProvider storageProvider = StorageProvider();

    var userDetails = await storageProvider.readUserModel();
    user.assign(userDetails);
    await getRequestedLeave();
  }

  void changeChipIndex(int value) {
    index.value = value;
  }

  Future<bool> back() async {
    return true;
  }

  List<Widget> widgetOptions = <Widget>[
    HomeManager(),
    StaffList(),
    VlogView(),
    CheckInView(),
    DocumentsScreen()
  ].obs;

  getRequestedLeave() async {
    newRequestedLeave.clear();
    var list = await apIsProvider.getRequestedLeave(user[0].token);

    if (list!.length.toInt() != 0) {
      requestedLeave.assignAll(list);
      for (int i = 0; i < requestedLeave.length; i++) {
        if (requestedLeave[i].seen == false) {
          var object = requestedLeave.removeAt(i);
          requestedLeave.insert(0, object);
          newRequestedLeave.add(object);

          print("showBadge--=-=---=-${showBadge}");
        }
      }
      // print("list of requested----${list}");
    } else {}
  }
}
