// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';

import '../../controller.dart';

class otpVerification extends StatelessWidget {
  final String? email;
  otpVerification({super.key, this.email});

  AuthController _controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 167.0.h, bottom: 10.h),
                child: Text(
                  "OTP Verification",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(
                  "We just sent a code to-",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: ColorConstant.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 52.0.h),
                child: Text(
                  "${email}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      controller: _controller.otpEditingController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        hintText: "Enter your OTP",
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
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
                child: _controller.isLoading.value == false
                    ? SizedBox(
                        height: 42.h,
                        child: ElevatedButton(
                          onPressed: () {
                            _controller.forgotOtpVerification();
                          },
                          child: Center(
                            child: Text(
                              "Verify OTP",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.button,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11),
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: ColorConstant.button,
                        ),
                      ),
              ),
              InkWell(
                onTap: () {},
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
        ),
      ),
    );
  }
}
