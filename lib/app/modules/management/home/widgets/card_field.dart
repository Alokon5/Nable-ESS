// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/values/images.dart';

// class CardField extends StatelessWidget {
//   String category;
//   final String image;

//   CardField({
//     super.key,
//     required this.category,
//     required this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       child: Container(
//         height: 84.h,
//         width: 149.w,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: 17.h),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 5.h),
//                     child: Text(category,
//                         style: Theme.of(context).textTheme.bodySmall),
//                   ),
//                   SizedBox(
//                     height: 36.h,
//                     child: Image(image: AssetImage(image)),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
