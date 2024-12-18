import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/values/colors.dart';
import '../../core/values/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.buttonText,
        body: Center(
          child: Container(
            height: 119.h,
            width: 119.w,
            child: Image(image: AssetImage(ImageConstant.Logo)),
          ),
        ));
  }
}
