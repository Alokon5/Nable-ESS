import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/values/colors.dart';

class AppButtonField extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const AppButtonField({required this.text,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed ,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: ColorConstant.backgroud),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstant.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
      ),
    );
  }
}
