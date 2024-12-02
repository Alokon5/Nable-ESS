// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/modules/authentication/controller.dart';
import 'package:nable_ess/app/modules/authentication/widgets/view/forgot_password_view.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     APIsProvider a = APIsProvider();
      //     await a.loginAsManagement("admin@gmail.com", "admn");
      //   },
      //   child: Text("sdf"),
      // ),
      // body: Obx(() {
      //   return SingleChildScrollView(
      //     child: Form(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Container(
      //             height: 204.h,
      //             decoration: BoxDecoration(
      //                 color: ColorConstant.button,
      //                 borderRadius:
      //                     BorderRadius.only(bottomRight: Radius.circular(64))),
      //             child: Center(
      //               child: Container(
      //                 height: 119.h,
      //                 width: 119.w,
      //                 child: Image(
      //                   image: AssetImage(ImageConstant.Logo),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.only(top: 40.h, left: 24.w),
      //             child: Text("Welcome To Nable ESS",
      //                 style: Theme.of(context).textTheme.titleLarge),
      //           ),
      //           SizedBox(height: 14.h),
      //           // Container(
      //           //   padding:
      //           //       EdgeInsets.only(right: 24.w, left: 24.w, bottom: 24.w),
      //           //   width: double.infinity,
      //           //   child: DropdownButton(
      //           //     isExpanded: true,
      //           //     hint: Text(
      //           //       "Choose Your Role",
      //           //       style: Theme.of(context).textTheme.bodyMedium,
      //           //     ),
      //           //     value: _controller.role.value,
      //           //     items: [
      //           //       DropdownMenuItem(
      //           //           value: KeyRoles.management,
      //           //           child: Text(
      //           //             KeyRoles.management,
      //           //             style: Theme.of(context).textTheme.bodyMedium,
      //           //           )),
      //           //       DropdownMenuItem(
      //           //           value: KeyRoles.manager,
      //           //           child: Text(
      //           //             KeyRoles.manager,
      //           //             style: Theme.of(context).textTheme.bodyMedium,
      //           //           )),
      //           //       DropdownMenuItem(
      //           //           value: KeyRoles.staff,
      //           //           child: Text(
      //           //             KeyRoles.staff,
      //           //             style: Theme.of(context).textTheme.bodyMedium,
      //           //           )),
      //           //     ],
      //           //     underline: Container(
      //           //       height: 1,
      //           //       decoration: BoxDecoration(
      //           //         border: Border(
      //           //           bottom: BorderSide(
      //           //             color: Colors.grey,
      //           //             width: 1.0,
      //           //           ),
      //           //         ),
      //           //       ),
      //           //     ),
      //           //     onChanged: (String? value) {
      //           //       _controller.role.value = value!;
      //           //     },
      //           //   ),
      //           // ),
      //           Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 24.w),
      //             child: AuthTextField(
      //               validator: (value) {
      //                 if (value == "" || value == null) {
      //                   return "Please enter email";
      //                 } else if (!EmailValidator.validate(value)) {
      //                   return "Email is incorrect";
      //                 }
      //               },
      //               controller: _controller.emailEditingController,
      //               labletext: "E-mail",
      //               icon: Icons.email_outlined,
      //               obscureText: false,
      //               onPressed: () {},
      //             ),
      //           ),
      //           Padding(
      //             padding:
      //                 EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
      //             child: Obx(
      //               () => AuthTextField(
      //                 controller: _controller.passwordEditingController,
      //                 validator: (value) {
      //                   if (value == null || value == "") {
      //                     return "Password can't empty";
      //                   }
      //                 },
      //                 labletext: "Password",
      //                 icon: !_controller.isPasswordVisible.value
      //                     ? Icons.visibility_off_outlined
      //                     : Icons.visibility_outlined,
      //                 obscureText: !_controller.isPasswordVisible.value,
      //                 onPressed: () {
      //                   _controller.changePasswordVisibility();
      //                 },
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding: EdgeInsets.symmetric(horizontal: 24.w),
      //             child: _controller.isLoading != true
      //                 ? AppButtonField(
      //                     text: "Login",
      //                     onPressed: () {
      //                       print("klshofoshroehwg");
      //                       _controller.login();
      //                       // Get.toNamed(AppRoutes.managementBaseScreen);
      //                     },
      //                   )
      //                 : Center(
      //                     child: CircularProgressIndicator(
      //                       color: ColorConstant.primaryDark,
      //                     ),
      //                   ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // }),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange.shade900,
              Colors.orange.shade800,
              Colors.orange.shade400
            ],
          ),
        ),
        child: Form(
          key: _controller.login2FormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // SizedBox(height: 80,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(64))),
                      child: Center(
                        child: Container(
                          height: 119.h,
                          width: 119.w,
                          child: Image(
                            image: AssetImage(ImageConstant.Logo),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Welcome To Nable ESS",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(225, 95, 27, .3),
                                      blurRadius: 20,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: TextField(
                                    controller:
                                        _controller.emailEditingController,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      suffixIcon: Icon(Icons.email_outlined),
                                    ),
                                  ),
                                ),
                                Obx(() {
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey.shade200))),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        suffixIcon: !_controller
                                                .isPasswordVisible.value
                                            ? InkWell(
                                                onTap: () {
                                                  _controller
                                                      .changePasswordVisibility();
                                                },
                                                child: Icon(Icons
                                                    .visibility_off_outlined))
                                            : InkWell(
                                                onTap: () {
                                                  _controller
                                                      .changePasswordVisibility();
                                                },
                                                child: Icon(
                                                    Icons.visibility_outlined)),
                                      ),
                                      obscureText:
                                          !_controller.isPasswordVisible.value,
                                      controller:
                                          _controller.passwordEditingController,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            child: TextButton(
                              onPressed: () {
                                Get.to(ForgotPasswordScreen());
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Obx(() {
                            return InkWell(
                              onTap: () {
                                _controller.login();
                              },
                              child: _controller.isLoading.value == false
                                  ? Container(
                                      height: 50,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.orange[900]),
                                      child: Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.orange[900],
                                      ),
                                    ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
