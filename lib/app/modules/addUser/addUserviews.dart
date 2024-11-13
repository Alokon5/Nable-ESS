import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/modules/addUser/addUserController.dart';
import 'package:nable_ess/app/widgets/customTextField.dart';

// ignore: must_be_immutable
class AddUser extends StatelessWidget {
  AddUser({super.key});
  var addUserController = Get.find<AdduserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Text(
          "Create New User Here",
          style: TextStyle(
              color: ColorConstant.primaryDark,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp),
        ),
      ),
      backgroundColor: ColorConstant.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              CustomTextField(
                hintText: "Name",
                controller: addUserController.userName,
                prefexIcons: Icon(
                  Icons.person,
                  size: 25.sp,
                ),
              ),
              CustomTextField(
                hintText: "Email",
                controller: addUserController.userEmail,
                prefexIcons: Icon(
                  Icons.email,
                  size: 21.sp,
                ),
              ),
              CustomTextField(
                hintText: "Password",
                controller: addUserController.userPassword,
                prefexIcons: Icon(
                  Icons.lock,
                  size: 22.sp,
                ),
              ),
              SizedBox(
                height: 14.h,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Select Role",
                    style: GoogleFonts.poppins(),

                    // style: TextStyle(
                    //     fontSize: 15.sp,
                    //     fontWeight: FontWeight.w500,
                    //     color: Colors.black),
                  )),
              SizedBox(
                height: 14.h,
              ),
              SizedBox(
                height: 48.h,
                // width: 110.w,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: ColorConstant.complimentaryLight),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7.0),
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      items: ["Manager", "Staff"],
                      validator: (value) =>
                          value == null ? 'Field is empty' : null,
                      // selectedItem:""          ,
                      onChanged: (value) {
                        // Do something with the selected model
                        addUserController.role.value = value.toString();
                        print("value -=-=-=-=-=-=-=-${value}");
                      },

                      dropdownSearchDecoration: InputDecoration(
                        fillColor: Colors.transparent,
                        // fillColor: Colors.blue,
                        //  labelText: "Countries",
                        hintText: "Select Role",
                        hintStyle: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.primaryDark),

                        filled: true,

                        contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(
                              color: Colors.transparent, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1),
                        ),
                      ),
                      // dropdownSearchDecoration: InputDecoration(
                      //           labelText: "Menu mode",
                      //           hintText: "country in menu mode",
                      //           filled: true,
                      //           fillColor: Colors.blue
                      //         ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                height: 45.h,
                child: ElevatedButton(
                  onPressed: () {
                    print("object -=========================  this is object");
                    // addUserController.createUser();

                    final city = <String, String>{
                      "name": "Los Angeles",
                      "state": "CA",
                      "country": "USA"
                    };

                    FirebaseFirestore.instance
                        .collection("cities")
                        .doc("LA")
                        .set(city);
                  },
                  child: Center(
                    child: Text(
                      "Add User",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ColorConstant.backgroud),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
