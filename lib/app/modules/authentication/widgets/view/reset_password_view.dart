import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/values/colors.dart';
import '../../controller.dart';

class PasswordResetScreen extends StatelessWidget {
  final String email;
  PasswordResetScreen({super.key, required this.email});

  final _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 167.0.h, bottom: 10.h),
                child: Text("Set new password",
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(
                  "Your new password must be different \n to previously used passwords.",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: ColorConstant.grey,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 32.0.h),
                child: Text(
                  "${email}",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      controller: _controller.passwordEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        hintText: "Enter your new password",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: Obx(() {
                      return TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
                        controller:
                            _controller.confirmPasswordEditingController,
                        obscureText: !_controller.isPasswordVisible.value,
                        decoration: InputDecoration(
                          suffixIcon: !_controller.isPasswordVisible.value
                              ? InkWell(
                                  onTap: () {
                                    _controller.changePasswordVisibility();
                                  },
                                  child: Icon(Icons.visibility_off_outlined))
                              : InkWell(
                                  onTap: () {
                                    _controller.changePasswordVisibility();
                                  },
                                  child: Icon(Icons.visibility_outlined)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9.0),
                          ),
                          hintText: "Re-enter your new password",
                        ),
                      );
                    }),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
                child: SizedBox(
                  height: 42.h,
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.forgotAsConfirmPassword(email.toString());
                    },
                    child: Center(
                      child: Text(
                        "Reset Password",
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
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 15.sp,
                      color: ColorConstant.grey,
                    ),
                  ),
                  Text(
                    "Back to Log in",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: ColorConstant.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
