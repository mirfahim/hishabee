import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/marketing_shop/presentation/manager/marketing_shop_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MarketingShopPage extends GetView<MarketingShopController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketing Shop'),
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isConnected.value
              ? Container(
                  child: Builder(
                    builder: (BuildContext context) {
                      return WebView(
                        initialUrl: controller.url.value,
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
                          webViewController.loadUrl(controller.url.value,
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
                  child: Text('No connection'),
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
