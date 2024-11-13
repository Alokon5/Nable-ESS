import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatelessWidget {
  final String labletext;
  final IconData? icon;
  final bool obscureText;
  final Function() onPressed;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const AuthTextField({
    required this.labletext,
    this.icon,
    required this.obscureText,
    required this.onPressed,
    this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
          ),
          hintText: labletext,
        ),
      ),
    );
  }
}
