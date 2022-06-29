import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  String? url;

  WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WebViewPage();
}

class _WebViewPage extends State<WebViewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    String? url = widget.url;

    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      navigationDelegate: (NavigationRequest request) {
        return NavigationDecision.prevent;
      },
    );
  }
}
