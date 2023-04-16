import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/detail_model.dart';
import '../controllers/webview_movies_controller.dart';

class WebviewMoviesView extends StatefulWidget {
  const WebviewMoviesView({Key? key}) : super(key: key);

  @override
  State<WebviewMoviesView> createState() => _WebviewMoviesViewState();
}

class _WebviewMoviesViewState extends State<WebviewMoviesView> {
  DetailMovie? item = Get.arguments;
  late final WebViewController _controller;
  var loadingPercentage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DetailMovie? item = Get.arguments;
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) async {
            // Update loading bar.
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse("${item!.homepage}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: BackButton(
            color: Colors.black,
          ),
          title: Text('${item!.title}', style: TextStyle(color: Colors.red)),
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: _controller,
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          ],
        ));
  }
}
