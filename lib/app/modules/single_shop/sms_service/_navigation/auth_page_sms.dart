import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/_bindings/sms_bindings.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/_navigation/sms_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/presentation/pages/sms_page.dart';

abstract class SmsAuth {
  static List<GetPage> pages = [
    GetPage(
      name: SMSRoutes.SMS,
      page: () => SmsPage(),
      binding: SMSBindings(),
    ),
  ];
}
