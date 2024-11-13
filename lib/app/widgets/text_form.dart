import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String lableText;
  final bool? isEditable;
  final int? maxLine;
  final int? maxLength;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final IconData? icon;
  final TextInputType? keyboardType;

  const AppTextField({
    required this.lableText,
    required this.controller,
    this.icon,
    this.validator,
    this.isEditable,
    this.maxLine = 1,
    this.maxLength,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: false,
      enabled: isEditable == null ? true : isEditable,
      validator: validator,
      maxLines: maxLine,
      maxLength: maxLength,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
        hintText: lableText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
      ),
    );
  }
}
