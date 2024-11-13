// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class AppTextField extends StatelessWidget {
//   final String lableText;
//   final bool? isEditable;
//   final int? maxLine;
//   final TextEditingController controller;
//   final FormFieldValidator<String>? validator;
//   final IconData? icon;

//   const AppTextField({
//     required this.lableText,
//     required this.controller,
//     this.icon,
//     this.validator,
//     this.isEditable,
//     this.maxLine,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       style: Theme.of(context).textTheme.bodyMedium,
//       controller: controller,
//       obscureText: false,
//       enabled: isEditable == null ? true : isEditable,
//       validator: validator,
//       maxLines: maxLine,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(9.0),
//         ),
//         hintText: lableText,
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(9.0),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(9.0),
//         ),
//       ),
//     );
//   }
// }
