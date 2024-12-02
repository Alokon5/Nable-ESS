import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/staff/checkIn/checkIn.dart';
import 'package:nable_ess/app/modules/staff/documents/documents.dart';
import 'package:nable_ess/app/modules/staff/home/view.dart';
import 'package:nable_ess/app/modules/staff/profile/view.dart';

import '../videos/widgets/view/videos_listing.dart';

class StaffController extends GetxController {
  var index = 0.obs;

  void changeChipIndex(int value) {
    index.value = value;
  }

  List<Widget> widgetOptions = <Widget>[
    CheckInViewStaff(),
    StaffVideoListing(),
    HomeStaff(),
    // UploadVideoScreen(),
    
    
    DocumentsScreen(),
  ].obs;
}
