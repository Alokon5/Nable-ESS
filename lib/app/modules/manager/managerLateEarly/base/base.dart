import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/modules/manager/documents/lateEarlyScreenM.dart';
import 'package:nable_ess/app/modules/manager/managerLateEarly/base/controller.dart';
import 'package:nable_ess/app/modules/manager/managerLateEarly/widgets/notification.dart';

class LateEarlybaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the controller
    final documentPageController = Get.put(LateEalryController());

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              // Listen for changes in selectedIndex
              return documentPageController.selectedIndex.value == 0
                  ? LateEarlyScreenM()
                  : LateEarlyNotification();
            }),
          ),
          // Bottom Navigation Bar with 2 items
          Obx(() {
            return BottomNavigationBar(
              currentIndex: documentPageController.selectedIndex.value,
              onTap: (index) {
                // Update the selected index when a tab is clicked
                documentPageController.changeTabIndex(index);
              },
              selectedItemColor: Colors.blue, // Color for selected item
              unselectedItemColor: Colors.grey, // Color for unselected items
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
