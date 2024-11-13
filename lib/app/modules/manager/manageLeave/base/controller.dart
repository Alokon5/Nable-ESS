import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/manageLeave/widgets/leave_history.dart';
import 'package:nable_ess/app/modules/manager/manageLeave/widgets/notification.dart';

import '../../../../data/models/requiestedLeaveModel/requiestedLeaveModel.dart';
import '../../../../data/models/user_model.dart';
import '../../../../data/providers/apis_provider.dart';
import '../../../../data/providers/storage_provider.dart';
import '../widgets/leaveForm.dart';

class LeaveBaseViewController extends GetxController {
  StorageProvider storageProvider = StorageProvider();

  APIsProvider apIsProvider = APIsProvider();
  var index = 0.obs;
    var user = <UserModel>[].obs;
     var showBadge = false.obs;

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await fetchUserDetails();
    await getRequestedLeave();
  }
var requestedLeave = <RequestedLeaveModel>[].obs;
var newlyRequestedList = <RequestedLeaveModel>[].obs;
  void changeChipIndex(int value) {
    index.value = value;
  }

  
  Future<bool> back() async {
    return true;
  }

    Future fetchUserDetails() async {
    
    var userModel = await storageProvider.readUserModel();
    user.assign(userModel);
   
  }

   getRequestedLeave() async {
    newlyRequestedList.clear();
    var list = await apIsProvider.getRequestedLeave(user[0].token);

    if (list!.length.toInt() != 0) {
      requestedLeave.assignAll(list);
      for (int i = 0; i < requestedLeave.length; i++) {
        if (requestedLeave[i].seen == false) {
          var object = requestedLeave.removeAt(i);
          requestedLeave.insert(0, object);
          newlyRequestedList.add(object);
          print("showBadge--=-=---=-${showBadge}");
        }
      }
      // print("list of requested----${list}");
    } else {}
  }

  List<Widget> widgetOptions =
      <Widget>[LeaveForm(), History(), LeaveNotification()].obs;
}
