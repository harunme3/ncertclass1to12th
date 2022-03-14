import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppBrowser extends StatefulWidget {
  const AppBrowser({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<AppBrowser> createState() => _AppBrowserState();
}

class _AppBrowserState extends State<AppBrowser> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.reload();
            },
            icon: Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url,
        onWebViewCreated: (controller) {
          this.controller = controller;
        },
      ),
    );
  }
}
