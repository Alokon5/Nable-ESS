import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nable_ess/app/core/theme/theme.dart';

import 'package:nable_ess/app/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(); 
  await GetStorage.init();
  runApp(NableEss());
}

class NableEss extends StatelessWidget {
  NableEss({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            title: "Task Upload",
            initialRoute: '/',
            theme: AppTheme.lightTheme,
            getPages: GetPages.pages,
            // home: EditProfileStaff(),
          );
        });
  }
}
