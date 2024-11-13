// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:nable_ess/app/core/values/images.dart';
import 'package:nable_ess/app/modules/authentication/controller.dart';
import 'package:nable_ess/app/modules/authentication/widgets/text_field.dart';
import 'package:nable_ess/app/routes/route.dart';
import 'package:nable_ess/app/widgets/button_field.dart';

class RegistorScreen extends StatelessWidget {
  RegistorScreen({super.key});

  final _controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 204.h,
              decoration: BoxDecoration(
                  color: ColorConstant.button,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(64))),
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
            Padding(
              padding: EdgeInsets.only(top: 40.h, left: 24.w),
              child: Text("REGISTER",
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AuthTextField(
                validator: (value) {},
                controller: TextEditingController(),
                labletext: "E-mail",
                icon: Icons.email_outlined,
                obscureText: false,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 43.h),
              child: Obx(
                () => AuthTextField(
                  validator: (value) {},
                  controller: TextEditingController(),
                  labletext: "Password",
                  icon: !_controller.isPasswordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  obscureText: !_controller.isPasswordVisible.value,
                  onPressed: () {
                    _controller.changePasswordVisibility();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: AppButtonField(text: "Register"),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t Have Account ?",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ColorConstant.primary),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offNamed(AppRoutes.loginScreen);
                    },
                    child: Text(
                      "Login",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: ColorConstant.primaryDark),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
