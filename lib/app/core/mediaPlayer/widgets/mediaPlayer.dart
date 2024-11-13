import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class ShortsPlayer extends StatefulWidget {
  final String shortsUrl;
  const ShortsPlayer({Key? key, required this.shortsUrl}) : super(key: key);

  @override
  State<ShortsPlayer> createState() => _ShortsPlayerState();
}

class _ShortsPlayerState extends State<ShortsPlayer> {
  late WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..loadRequest(Uri.parse(widget.shortsUrl));
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
