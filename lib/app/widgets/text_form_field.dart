import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final String labletext;

  const AppTextField({
    required this.labletext,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: TextFormField(
        obscureText: false,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9.0),
          ),
          labelText: labletext,
        ),
      ),
    );
  }
}
