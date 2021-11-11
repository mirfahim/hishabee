import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/web_view_page_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends GetView<WebViewPageController> {
  final String viewUrl;
  WebViewPage({this.viewUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hishabee Business Manager'),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isConnected.value
              ? Container(
                  child: Builder(
                    builder: (BuildContext context) {
                      String url =
                          '${viewUrl + "?shop_id=${controller.shopId.value}"}';
                      return WebView(
                        initialUrl: url,
                        navigationDelegate: (NavigationRequest request) {
                          if (request.url.startsWith('https:')) {
                            return NavigationDecision.navigate;
                          } else {
                            return NavigationDecision.prevent;
                          }
                        },
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          webViewController.loadUrl(viewUrl,
                              headers: controller.headers);
                        },
                        javascriptChannels: <JavascriptChannel>[
                          _toasterJavascriptChannel(context),
                        ].toSet(),
                        gestureNavigationEnabled: true,
                      );
                    },
                  ),
                )
              : Center(
                  child: Text('No internet connection'),
                ),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
