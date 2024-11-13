import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';

import '../../controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _controller = Get.put(AuthController());
  final apiProvider = Get.put(APIsProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 167.0.h, bottom: 10.h),
                child: Text(
                  "Forgot Password?",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 52.0.h),
                child: Text(
                  "No worries, we’ll send you reset instruction",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorConstant.grey),
                ),
              ),
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 28.w),
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyMedium,
                          controller: _controller.emailEditingController,
                          obscureText: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            hintText: "Enter your Email",
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
                    child: Obx(() {
                      return _controller.isLoading.value == false
                          ? SizedBox(
                              height: 42.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  _controller.forgotEmailRequest();
                                },
                                child: Center(
                                  child: Text(
                                    "Send OTP",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange[900],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                              ))
                          : Center(
                              child: CircularProgressIndicator(
                                color: Colors.orange[900],
                              ),
                            );
                    }),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 15.sp,
                          color: ColorConstant.grey,
                        ),
                        Text(
                          "Back to Log in",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: ColorConstant.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
