import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/tvdetail_model.dart';
import '../controllers/webview_t_v_controller.dart';

class WebviewTVView extends StatefulWidget {
  const WebviewTVView({Key? key}) : super(key: key);

  @override
  State<WebviewTVView> createState() => _WebviewTVViewState();
}

class _WebviewTVViewState extends State<WebviewTVView> {
  TvDetails? item = Get.arguments;
  late final WebViewController _controller;
  var loadingPercentage = 0;
  @override
  void initState() {
    TvDetails? item = Get.arguments;
    // TODO: implement initState
    super.initState();

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
          title: Text('${item!.name}', style: TextStyle(color: Colors.red)),
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
