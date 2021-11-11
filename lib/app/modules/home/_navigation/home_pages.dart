import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/_bindings/advance_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/_bindings/home_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/_bindings/standard_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/pages/advance_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/pages/splash_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/pages/standard_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/pages/welcome_page.dart';

import 'home_routes.dart';

abstract class HomePages {
  static List<GetPage> pages = [
    GetPage(
      name: HomeRoutes.SPLASH,
      page: () => SplashPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: HomeRoutes.WELCOME,
      page: () => WelcomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: HomeRoutes.STANDARD,
      page: () => StandardPage(),
      binding: StandardBinding(),
    ),
    GetPage(
      name: HomeRoutes.ADVANCE,
      page: () => AdvancePage(),
      binding: AdvanceBinding(),
    ),
  ];
}
