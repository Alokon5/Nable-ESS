import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CardField extends StatelessWidget {
  String? category;
  final String? image;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function()? onPressed;
  Color? cardColor;

  CardField({
    super.key,
    this.category,
    this.image,
    this.controller,
    this.validator,
    this.onPressed,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 84.h,
          width: 149.w,
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
          color: cardColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 17.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.h),
                      child: Text(category.toString(),
                          style: Theme.of(context).textTheme.bodySmall),
                    ),
                    SizedBox(
                      height: 36.h,
                      child: Image(image: AssetImage(image.toString())),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
