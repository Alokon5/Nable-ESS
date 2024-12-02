import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String lableText;
  final bool? isEditable;
  final int? maxLine;
  final int? maxLength;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool isPassword;

  const AppTextField({
    required this.lableText,
    required this.controller,
    this.icon,
    this.validator,
    this.isEditable,
    this.isPassword = false,
    this.maxLine = 1,
    this.maxLength,
    this.keyboardType,
  });

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword; // Initialize with the passed isPassword value
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _isObscured, // Toggle based on _isObscured
      enabled: widget.isEditable == null ? true : widget.isEditable,
      validator: widget.validator,
      maxLines: widget.maxLine,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
        hintText: widget.lableText,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                onPressed: _toggleVisibility, // Toggle visibility on click
              )
            : (widget.icon != null ? Icon(widget.icon) : null),
      ),
    );
  }
}
