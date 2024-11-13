import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nable_ess/app/data/providers/apis_provider.dart';

import '../../../../core/values/images.dart';

// ignore: must_be_immutable
class VideoContainer extends StatelessWidget {
  String? user_name;
  String? profileImage;
  String? status;

  VideoContainer({
    super.key,
    this.user_name,
    this.profileImage,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    print("profileImage---=-=-=-=${profileImage}");

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r)),
                // decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                        width: double.infinity,
                        // decoration: BoxDecoration(border: Border.all()),
                        child: profileImage == null || profileImage == ''
                            ? CircleAvatar(
                                radius: 35.r,
                                child: Image(
                                    image:
                                        AssetImage(ImageConstant.maleProfile)),
                              )
                            : CircleAvatar(
                                radius: 40.r,
                                backgroundColor: Colors.white,
                                child: Image(
                                  image: NetworkImage(
                                    APIsProvider.mediaBaseUrl +
                                        profileImage.toString(),
                                  ),
                                  fit: BoxFit.fill,
                                ))),
                    Expanded(
                      child: Card(
                        elevation: 1,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              // border: Border.all(),
                              ),
                          child: Center(
                            child: Text(
                              user_name.toString(),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 0,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              // border: Border.all(),
                              ),
                          child: Center(
                            child: Text(
                              "$status",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
