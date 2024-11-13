import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';
import 'package:nable_ess/app/modules/management/clockIn/controller.dart';

class SingleProfile extends StatelessWidget {
  SingleProfile({
    super.key,
  });
  // final int? userId;
  final clockInController = Get.put(ClockInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Obx(() {
        return clockInController.isLoading == false
            ? Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                height: 60.h,
                width: 60.h,
                child: clockInController.singleUserData().profileImage ==
                            null ||
                        clockInController.singleUserData().profileImage == ""
                    ? CircleAvatar(
                        radius: 35.r,
                        child:
                            Image(image: AssetImage(ImageConstant.maleProfile)),
                      )
                    : CircleAvatar(
                        backgroundImage: NetworkImage(
                        APIsProvider.mediaBaseUrl +
                            clockInController
                                .singleUserData()
                                .profileImage
                                .toString(),
                      )),
              )
            : CircularProgressIndicator(
                color: ColorConstant.primaryDark,
              );
      }), title: Obx(() {
        return clockInController.isLoading == false
            ? Text(
                "${clockInController.singleUserData().firstName} ${clockInController.singleUserData().lastName}",
                style: Theme.of(context).textTheme.bodyMedium)
            : CircularProgressIndicator(
                color: ColorConstant.primaryDark,
              );
      })),
      body: Column(
        children: [
          Divider(),
          // Container(
          //   color: Colors.amber,
          //   height: 40.h,
          //   width: double.infinity,
          //   child: Row(
          //     children: [
          //       Padding(
          //         padding: EdgeInsets.only(left: 10.w),
          //         child: InkWell(
          //           onTap: () async {
          //             final currentDate = DateTime.now();
          //             final selectedDate = await showDatePicker(
          //               context: context,
          //               initialDate: currentDate,
          //               firstDate: currentDate.subtract(Duration(days: 40)),
          //               lastDate: DateTime(2100),
          //             );
          //             if (selectedDate != null) {
          //               var date = selectedDate.toString().split(' ')[0];
          //               clockInController.startDateFilter.text =
          //                   date.toString();
          //               // leaveController.leaveFormKey.currentState!.validate();
          //               // _controller.updateSelectedDate(selectedDate.toString());
          //               print(
          //                   "Selected Date -=-=-------------------${clockInController.startDateFilter.text}");
          //             }
          //           },
          //           child: IgnorePointer(
          //             child: TextFormField(
          //               controller: clockInController.startDateFilter,
          //               validator: (value) {
          //                 if (value == null || value == "") {
          //                   return "Please Select Date";
          //                 }
          //               },
          //               // controller: leaveController.leaveDescription,
          //               keyboardType: TextInputType.multiline,
          //               minLines: 1,
          //               style: Theme.of(context).textTheme.titleSmall,
          //               decoration: InputDecoration(
          //                 hintText: "Select Date...",
          //                 border: OutlineInputBorder(
          //                     borderSide:
          //                         BorderSide(width: 1, color: Colors.black)),
          //                 enabledBorder: OutlineInputBorder(
          //                     borderSide:
          //                         BorderSide(width: 1, color: Colors.black)),
          //                 contentPadding: EdgeInsets.only(left: 12.w),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.only(left: 10.w),
          //         child: InkWell(
          //           onTap: () async {
          //             final currentDate = DateTime.now();
          //             final selectedDate = await showDatePicker(
          //               context: context,
          //               initialDate: currentDate,
          //               firstDate: currentDate.subtract(Duration(days: 40)),
          //               lastDate: DateTime(2100),
          //             );
          //             if (selectedDate != null) {
          //               var date = selectedDate.toString().split(' ')[0];
          //               clockInController.endDateFilter.text = date.toString();
          //               // leaveController.leaveFormKey.currentState!.validate();
          //               // _controller.updateSelectedDate(selectedDate.toString());
          //               print(
          //                   "Selected Date -=-=-------------------${clockInController.endDateFilter.text}");
          //             }
          //           },
          //           child: IgnorePointer(
          //             child: TextFormField(
          //               controller: clockInController.endDateFilter,
          //               validator: (value) {
          //                 if (value == null || value == "") {
          //                   return "Please Select Date";
          //                 }
          //               },
          //               // controller: leaveController.leaveDescription,
          //               keyboardType: TextInputType.multiline,
          //               minLines: 1,
          //               style: Theme.of(context).textTheme.titleSmall,
          //               decoration: InputDecoration(
          //                 hintText: "Select Date...",
          //                 border: OutlineInputBorder(
          //                     borderSide:
          //                         BorderSide(width: 1, color: Colors.black)),
          //                 enabledBorder: OutlineInputBorder(
          //                     borderSide:
          //                         BorderSide(width: 1, color: Colors.black)),
          //                 contentPadding: EdgeInsets.only(left: 12.w),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Text("data"),
          // Text("data"),
          // Text("data"),
          // Text("data"),
          // Text("data"),
          // Text("data"),
        ],
      ),
    );
  }
}
