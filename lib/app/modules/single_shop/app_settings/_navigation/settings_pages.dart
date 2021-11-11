import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_bindings/app_settings_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/pages/settings_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/pages/withdraw_request_page.dart';

import 'settings_routes.dart';

abstract class SettingsPages {
  static List<GetPage> pages = [
    GetPage(
      name: SettingsRoutes.SETTINGS,
      page: () => SettingsPage(),
      binding: AppSettingsBinding(),
    ),
    GetPage(
      name: SettingsRoutes.WITHDRAW_REQUEST,
      page: () => WithdrawRequest(),
      binding: AppSettingsBinding(),
    ),
  ];
}
