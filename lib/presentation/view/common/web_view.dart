import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class CustomWebView extends StatefulWidget {
  CustomWebView({Key? key, required this.url, this.appBarTitle}) : super(key: key);

  URLRequest url;
  String? appBarTitle;

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(useHybridComposition: true, domStorageEnabled: true),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  double progress = 0;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  final urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBarTitle == null
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title:
                  Text(widget.appBarTitle!, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              centerTitle: true,
              leading: GestureDetector(
                child: const Icon(Icons.close, color: Colors.black),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              shape: const Border(bottom: BorderSide(color: Colors.black12)),
            ),
      body: Stack(
        children: [
          InAppWebView(
              key: webViewKey,
              initialUrlRequest: widget.url,
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;

                /// javaScript 주소 검색 결과
                webViewController!.addJavaScriptHandler(
                    handlerName: 'handlerFoo',
                    callback: (args) {
                      debugPrint('args = ' + args.toString());
                      var address = args[1];
                      if (args[2] != '') address + ' (${args[2]})';
                      print('address = ' + address);
                      Get.back(result: address);
                    });
              },
              androidOnPermissionRequest: (controller, origin, resources) async {
                return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
              },
              onLoadStart: (controller, url) {
                setState(() {
                  widget.url.url = url;
                  urlController.text = url.toString();
                });
              },
              onLoadStop: (controller, url) async {
                pullToRefreshController.endRefreshing();
                setState(() {
                  widget.url.url = url;
                  urlController.text = url.toString();
                });
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                  urlController.text = widget.url.url.toString();
                });
              }),
          progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
        ],
      ),
    );
  }
}
