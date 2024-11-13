import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nable_ess/app/core/theme/text_theme.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
        color: Colors.transparent, toolbarHeight: 40.h, elevation: 0),
    textTheme: AppTextTheme.textTheme,
  );
}
