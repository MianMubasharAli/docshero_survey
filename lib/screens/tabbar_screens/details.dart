import 'dart:async';

import 'package:docshero/components/reuseable_widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: 'https://www.lipsum.com/feed/html',
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request){
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url){
          print("url is: $url");
          Get.dialog(CustomLoader());
        },
        onPageFinished: (String url){
          Get.back();
        },
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        },
      ),
      floatingActionButton: FutureBuilder<WebViewController>(
          future: _controller.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> controller) {
            if (controller.hasData) {
              return FloatingActionButton(
                backgroundColor: Colors.blue,
                  elevation: 5,
                  child: Icon(Icons.arrow_back,),
                  onPressed: () {
                    controller.data?.goBack();
                  });
            }

            return Container();
          }
      ),
        );
  }
}
