import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '_lang/app_translations.dart';
import '_navigation/app_pages.dart';
import '_themes/theme_data.dart';
import 'modules/home/_navigation/home_routes.dart';

class MyApp extends StatefulWidget {
  final bool isBangla;

  MyApp({this.isBangla});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        /* if (snapshot.hasError) {
          return ;
        }*/

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            navigatorKey: Get.key,
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
            ],
            translations: AppTranslations(),
            locale: widget.isBangla ? Locale('bn', 'BD') : Locale('en', 'US'),
            fallbackLocale: Locale('bn', 'BD'),
            debugShowCheckedModeBanner: false,
            title: 'Hishabee Business Manager',
            getPages: AppPages.pages,
            initialRoute: HomeRoutes.SPLASH,
            theme: themeData,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );
  }
}
