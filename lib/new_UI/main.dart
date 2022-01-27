import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart'; // for date format
import 'package:intl/date_symbol_data_local.dart';

import 'business_overview/business_over_view.dart';
import 'login_page/login_page.dart';

// void main() {
//   runApp(MyApp());
//   var now = DateTime.now();
//   var month = DateFormat.yMMMMd().format(now);
// }

class MyApp extends StatelessWidget {

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          focusColor: Colors.black,
        ),
        home: LoginPageSecond()
        // CustomDialogBox('samin', 'yeaser', 'nehal'),
        );
  }
}
