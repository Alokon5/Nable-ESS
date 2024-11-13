import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/modules/management/home/widgets/create_manager.dart';
import 'package:nable_ess/app/modules/management/home/widgets/create_staff_form.dart';
import 'package:nable_ess/app/routes/route.dart';

import '../../../core/values/images.dart';
import '../../../data/providers/apis_provider.dart';
import 'controller.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({super.key});

  final userDetailsController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        // color: Colors.amber,
        height: 80.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(() {
              return userDetailsController.addButtonEnabled.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            userDetailsController.addButtonTrueFalse();
                            Get.to(() => CreateManagerForm(),
                                transition: Transition.leftToRight);
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.r)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorConstant.primary,
                                  borderRadius: BorderRadius.circular(13.r)),
                              height: 30.h,
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 13.w),
                                  child: Text(
                                    "Add reporting officer",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        InkWell(
                          onTap: () {
                            userDetailsController.addButtonTrueFalse();
                            Get.to(() => StaffForm(),
                                transition: Transition.leftToRight);
                          },
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.r)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorConstant.primary,
                                  borderRadius: BorderRadius.circular(13.r)),
                              height: 30.h,
                              child: Center(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 13.w),
                                  child: Text(
                                    "Add staff",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox();
            }),
            SizedBox(
              width: 8.w,
            ),
            InkWell(
              onTap: () {
                userDetailsController.addButtonTrueFalse();
              },
              child: CircleAvatar(
                radius: 25.r,
                backgroundColor: ColorConstant.primary,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: ColorConstant.primary,
        title: Text(
          "   Employees",
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, top: 5.h, bottom: 5.h),
              child: SizedBox(
                width: 160.w,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(color: Colors.white, width: 1.w)),
                  child: Obx(() {
                    return Center(
                      child: DropdownSearch<String>(
                        maxHeight: 130.h,
                        mode: Mode.MENU,
                        items: ["Manager", "Staff", "All"],
                        validator: (value) =>
                            value == null ? 'Field is empty' : null,

                        dropdownBuilder: (context, selectedItem) {
                          return Text(
                            selectedItem.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.sp),
                            // style: Theme.of(context)
                            //     .textTheme
                            //     .bodyMedium, // Customize the text style here
                          );
                        },
                        popupItemBuilder: (context, item, isSelected) {
                          return ListTile(
                            title: Text(
                              item.toString(),

                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium, // Customize the text style here
                            ),
                          );
                        },
                        // selectedItem:""          ,
                        onChanged: (value) {
                          userDetailsController.selectedUserFileter.value =
                              value.toString();
                          if (value == "Manager") {
                            userDetailsController.getAllManagers();
                          } else if (value == "Staff") {
                            userDetailsController.getAllStaffs();
                          } else if (value == "All") {
                            userDetailsController.getAllEmployees();
                          }

                          // Do something with the selected model
                          // addUserController.role.value = value.toString();

                          print("value -=-=-=-=-=-=-=-${value}");
                        },
                        selectedItem: userDetailsController
                            .selectedUserFileter.value
                            .toString(),

                        dropdownSearchDecoration: InputDecoration(
                          fillColor: Colors.transparent,
                          // fillColor: Colors.blue,
                          //  labelText: "Countries",
                          // hintText: "   Filter User",
                          // hintStyle: TextStyle(
                          //     fontSize: 13.sp,
                          //     fontWeight: FontWeight.w500,
                          //     color: Colors.white),

                          filled: false,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 7.w, vertical: 0.h),
                          // border: OutlineInputBorder(

                          //   // borderSide: BorderSide(color: Colors.white,),
                          //   borderSide:BorderSide(color: Colors.white,width: 2.w),
                          //   borderRadius: BorderRadius.circular(5),
                          // ),
                        ),
                        // dropdownSearchDecoration: InputDecoration(
                        //           labelText: "Menu mode",
                        //           hintText: "country in menu mode",
                        //           filled: true,
                        //           fillColor: Colors.blue
                        //         ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          return userDetailsController.allEmployeesList.length != 0
              ? Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                    ),
                    itemCount: userDetailsController.allEmployeesList.length,
                    itemBuilder: (context, index) {
                      // return VideoContainer(user_name: "Kuldeep");

                      return InkWell(
                        onTap: () async {
                          await userDetailsController.getUserDetails(
                              userDetailsController.allEmployeesList[index].id);
                          if (userDetailsController
                                  .allEmployeesList[index].userType ==
                              "Manager") {
                            await userDetailsController.getStaffViaId(
                                userDetailsController
                                    .allEmployeesList[index].id);
                          }
                          userDetailsController.selectedUserFileter.value =
                              "All";
                          Get.toNamed(
                            AppRoutes.userProfileVideos,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.r)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: userDetailsController
                                                    .allEmployeesList[index]
                                                    .profileImage ==
                                                null ||
                                            userDetailsController
                                                    .allEmployeesList[index]
                                                    .profileImage ==
                                                ""
                                        ? CircleAvatar(
                                            radius: 35.r,
                                            child: Image(
                                                image: AssetImage(
                                                    ImageConstant.maleProfile)),
                                          )
                                        : CircleAvatar(
                                            radius: 40.r,
                                            backgroundColor: Colors.white,
                                            // backgroundImage: NetworkImage(
                                            //     APIsProvider.mediaBaseUrl +
                                            //         userDetailsController
                                            //             .allEmployeesList[
                                            //                 index]
                                            //             .profileImage
                                            //             .toString(),
                                            //     scale: 50.r),
                                            child: Image(
                                              image: NetworkImage(
                                                APIsProvider.mediaBaseUrl +
                                                    userDetailsController
                                                        .allEmployeesList[index]
                                                        .profileImage
                                                        .toString(),
                                              ),
                                              fit: BoxFit.fill,
                                            )),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 1,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          // border: Border.all(),
                                          ),
                                      child: Center(
                                        child: Text(
                                          "${userDetailsController.allEmployeesList[index].firstName} ${userDetailsController.allEmployeesList[index].lastName}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: 0,
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          // border: Border.all(),
                                          ),
                                      child: Center(
                                        child: Text(
                                          "${userDetailsController.allEmployeesList[index].status}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: ColorConstant.primaryDark,
                ));
        }),
      ),
    );
  }
}
