import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/_navigation/home_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/domain/repositories/i_analytics_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_bindings/shop_main_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_navigation/shop_main_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/pages/select_shop_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/_binding/shop_features_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/pages/shop_features_page.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';

class SplashController extends GetxController {
  final IAuthRepository authRepository;
  final IShopRepository shopRepository;
  final IAnalyticsRepository analyticsRepository;
  final status = AppTrackingTransparency.requestTrackingAuthorization();
  final isLoggedIn = false.obs;
  final shop = Rxn<Shop>();

  SplashController(
      this.authRepository, this.shopRepository, this.analyticsRepository);

  onInit() async {
    await getLoggedInStatus();
    await getCurrentShop();
    await AnalyticsService.sendAnalyticsToServer(
        event: AnalyticsEvent.sessionStart);
    await navigateAfterSplash();

    super.onInit();
  }

  Future<void> getLoggedInStatus() async {
    final result = await authRepository.getCredentials();

    if (result?.accessToken != null) {
      isLoggedIn.value = true;
    }
  }

  Future<void> navigateAfterSplash() async {
    Timer(Duration(seconds: 3), () async {
      if (isLoggedIn.value) {
        if (shop.value != null) {
          Get.to(() => ShopFeatureShowCase(shop: shop.value),
              binding: ShopFeaturesBinding());
        } else {
          Get.off(() => SelectShopPage(), binding: ShopMainBinding());
          //Get.offNamed(ShopMainRoutes.SELECT_SHOP);
        }
      } else {
        Get.offAllNamed(HomeRoutes.WELCOME);
        // Get.offAllNamed(HomeRoutes.WELCOME);
      }
    });
  }

  Future<void> getCurrentShop() async {
    try {
      shop.value = await shopRepository.getCurrentShop();
    } catch (e) {}
  }
}
