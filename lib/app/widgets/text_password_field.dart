import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPasswordField extends StatelessWidget {
  final String labletext;
  final IconData? icon;
  final bool obscureText;

  const AppPasswordField({
    required this.labletext,
    this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          suffixIcon: Icon(icon, size: 20.spMax),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9.0),
          ),
          labelText: labletext,
        ),
      ),
    );
  }
}
