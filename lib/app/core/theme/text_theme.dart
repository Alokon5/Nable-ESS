import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextTheme {
  static final textTheme = TextTheme(
    titleLarge: GoogleFonts.roboto(
      fontSize: 23.sp,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      color: Colors.black,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 19.sp,
      fontWeight: FontWeight.w400,
      // letterSpacing: 0.15,
      color: Colors.black,
    ),
    titleSmall: GoogleFonts.roboto(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      // letterSpacing: 0.1,
      color: Colors.black,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      // letterSpacing: 0.5,
      color: Colors.black,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      // letterSpacing: 0.25,
      color: Colors.black,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      // letterSpacing: 0.4,
      color: Colors.black,
    ),
    labelLarge: GoogleFonts.roboto(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      // letterSpacing: 1.25,
      color: Colors.black,
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: 10.sp,
      fontWeight: FontWeight.w500,
      // letterSpacing: 1.5,
      color: Colors.black,
    ),
  );
}
