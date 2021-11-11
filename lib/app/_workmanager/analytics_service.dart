import 'dart:io';

import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/local/data_sources/local_analytics_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/remote/data_sources/analytics_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/repositories/analytics_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/domain/repositories/i_analytics_repository.dart';

class AnalyticsService {
  // static sync() async {
  //   Fluttertoast.showToast(msg: "Syncing analytics");
  //   print("Workman sync analytics");
  //   Get.put<ILocalAnalyticsProvider>(LocalAnalyticsProvider());
  //   Get.put<IAnalyticsProvider>(AnalyticsProvider(Get.find()));
  //   Get.put<IAnalyticsRepository>(AnalyticsRepository(Get.find(), Get.find()));
  //   print("Before repo init");
  //
  //   final IAnalyticsRepository analyticsRepository = Get.find();
  //
  //   print("After repo init");
  //
  //   final list = await analyticsRepository.getAllAnalytics();
  //
  //   print("After data get");
  //
  //   if (list.isNotEmpty) {
  //     print("Something to sync");
  //
  //     list.forEach((element) async {
  //       sendAnalytics(element.event);
  //     });
  //
  //     await analyticsRepository.clearAnalytics();
  //   } else {
  //     print("Nothing to sync");
  //   }
  // }

  static sendAnalytics({int shopId, String event, String platform}) async {
    Get.put<IAnalyticsProvider>(AnalyticsProvider(Get.find()));
    Get.put<ILocalAnalyticsProvider>(LocalAnalyticsProvider());
    final IAnalyticsRepository analyticsRepository =
        Get.put<IAnalyticsRepository>(
            AnalyticsRepository(Get.find(), Get.find()));

    /* await analyticsRepository.addAnalytics(
        AnalyticsModel(shopId: shopId, event: event, platform: platform));*/

    final FirebaseAnalytics _analytics = FirebaseAnalytics();

    FirebaseAnalyticsObserver getAnalyticsObserver() =>
        FirebaseAnalyticsObserver(analytics: _analytics);

    _analytics.logEvent(name: event);

    final facebookAppEvents = FacebookAppEvents();

    facebookAppEvents.logEvent(name: event);
  }

  static sendAnalyticsToServer({String event}) async {
    String platform = "ANDROID";
    if (Platform.isIOS) {
      platform = "IOS";
    }
    await sendAnalytics(
        shopId: DataHolder.shopId, event: event, platform: platform);
  }
}
