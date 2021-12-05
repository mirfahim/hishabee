/*import 'package:facebook_analytics/facebook_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';*/

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/_bindings/app_binding.dart';
import 'app/_services/localization_service.dart';
import 'app/app.dart';

const hiveDbDirectory = 'hishabee-db';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'Hishabee-channel', // id
    'Hishabee Notification', // title
    // 'This channel is used for Hishabee Notification.', // description
    importance: Importance.high,
    showBadge: true,
    enableVibration: true,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  await GetStorage.init('sms');
  await GetStorage.init('smsCount');
  WidgetsFlutterBinding.ensureInitialized();
  AppBinding().dependencies();
  var androidInitialize =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
  var iOInitialize = new IOSInitializationSettings();
  var initializationSetting =
      InitializationSettings(android: androidInitialize, iOS: iOInitialize);
  flutterLocalNotificationsPlugin.initialize(
    initializationSetting,
  );

  await Firebase.initializeApp();
  FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
    final IAuthRepository authRepository = Get.find();

    await authRepository.updateFcmToken(fcmToken: event);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    }
  });

  await Hive.initFlutter(hiveDbDirectory);

  ILocalizationService localizationService = Get.find();

  bool isBangla = await localizationService.isBangla();

  // InAppPurchaseConnection.enablePendingPurchases();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: DEFAULT_YELLOW_BG));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      MyApp(
        isBangla: isBangla,
      ),
      //   OnboardingPage()
    );
  });
}
