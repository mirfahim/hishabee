import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_bindings/shop_main_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_navigation/shop_main_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/pages/create_shop_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/pages/edit_shop_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/pages/manage_shop_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/pages/select_shop_page.dart';

abstract class ShopMainPages {
  static List<GetPage> pages = [
    GetPage(
      name: ShopMainRoutes.SELECT_SHOP,
      page: () => SelectShopPage(),
      binding: ShopMainBinding(),
    ),
    GetPage(
      name: ShopMainRoutes.CREATE_SHOP,
      page: () => CreateShopPage(),
      binding: ShopMainBinding(),
    ),
    GetPage(
      name: ShopMainRoutes.MANAGE_SHOP,
      page: () => ManageShopPage(),
      binding: ShopMainBinding(),
    ),
    GetPage(
      name: ShopMainRoutes.EDIT_SHOP,
      page: () => EditShopPage(),
      binding: ShopMainBinding(),
    ),
  ];
}
