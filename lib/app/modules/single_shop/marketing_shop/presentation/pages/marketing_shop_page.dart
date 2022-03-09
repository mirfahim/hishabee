import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/marketing_shop/presentation/manager/marketing_shop_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MarketingShopPage extends StatefulWidget {
  @override
  State<MarketingShopPage> createState() => _MarketingShopPageState();
}

class _MarketingShopPageState extends State<MarketingShopPage> {
  MarketingShopController controller = Get.find();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.amber,
        title: Text('marketing_shop'.tr, style: TextStyle(
          color: Colors.black
        ),),
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

                        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy
                            .require_user_action_for_all_media_types,
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
