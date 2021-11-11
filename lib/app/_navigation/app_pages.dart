import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_navigation/auth_pages.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/_navigation/home_pages.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_navigation/shop_main_pages.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_navigation/settings_pages.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/contacts/_navigation/contact_pages.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/notification/_navigation/notification_pages.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/report/_navigation/report_pages.dart';

abstract class AppPages {
  static List<GetPage> pages = []
    ..addAll(HomePages.pages)
    ..addAll(AuthPages.pages)
    ..addAll(ShopMainPages.pages)
    ..addAll(ReportPages.pages)
    ..addAll(SettingsPages.pages)
    ..addAll(ContactPages.pages)
    ..addAll(NotificationPages.pages);
}
