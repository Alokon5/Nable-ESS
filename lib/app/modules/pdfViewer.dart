import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nable_ess/app/core/values/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfViewerWidget extends StatelessWidget {
  final String pdfUrl;

  PdfViewerWidget({required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    final pdfUrlNew = Uri.encodeFull(
        'http://192.168.1.3:8000/media/document_file/sample.pdf');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 45.h,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black45,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
              onPressed: () async {
                // _printWebView();
              },
              child: Center(
                  child: Text(
                'Print',
                style: GoogleFonts.poppins(),
              )),
            ),
          ),
        ],
      ),

      floatingActionButton: IconButton(
          onPressed: () async {
            await launch("$pdfUrlNew");
            //  FlutterWebBrowser.openWebPage(
            //                 url: "https://flutter.io/",
            //                 customTabsOptions: CustomTabsOptions(
            //                   colorScheme: CustomTabsColorScheme.dark,
            //                   darkColorSchemeParams: CustomTabsColorSchemeParams(
            //                     toolbarColor: Colors.deepPurple,
            //                     secondaryToolbarColor: Colors.green,
            //                     navigationBarColor: Colors.amber,
            //                     navigationBarDividerColor: Colors.cyan,
            //                   ),
            //                   // shareState: CustomTabsShareState.on,
            //                   instantAppsEnabled: true,
            //                   showTitle: true,
            //                   urlBarHidingEnabled: true,
            //                 ),
            //               );
          },
          icon: Icon(Icons.print)),
      //  body: webview.launch("https://example.com")
    );
  }
}
