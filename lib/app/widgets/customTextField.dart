

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nable_ess/app/core/values/colors.dart';

class CustomTextField extends StatelessWidget {
  
  final String? text;
  final bool? editTable;
  final String? hintText;
  final Color? color;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final int? maxlines;
  final FormFieldValidator<String>? validator;
  final Icon? prefexIcons;
  final Color? prefexIconColors;
  const CustomTextField(
      {Key? key,
      this.prefexIcons,
      this.prefexIconColors,
      this.editTable,
      this.controller,
      this.color = ColorConstant.complimentaryLight,
      this.text,
      this.hintText,
      this.keyboardType,
      this.maxlines = 1,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _controller = Get.put(QuatationController());
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hintText ?? '',
              style: GoogleFonts.poppins(),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              enabled: editTable,
              validator: validator,
              keyboardType: keyboardType,
              controller: controller,
              maxLines: maxlines,
              onChanged: (value) {
               
              },
              
              decoration: InputDecoration(
                fillColor: color,
                hintText: hintText,
                prefixIcon: prefexIcons,
                prefixIconColor: prefexIconColors,
                hintStyle: GoogleFonts.poppins(),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: maxlines! >= 2 ? 10 : 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
              ),
            ),
          ],
        ));
  }
}