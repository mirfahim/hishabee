import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/local/data_sources/local_analytics_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/remote/data_sources/analytics_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/data/repositories/analytics_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/domain/repositories/i_analytics_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/splash_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/welcome_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/local/data_sources/local_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';

class HomeBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<ILocalAnalyticsProvider>(() => LocalAnalyticsProvider());
    Get.lazyPut<IAnalyticsProvider>(() => AnalyticsProvider(find()));
    Get.lazyPut<IAnalyticsRepository>(
        () => AnalyticsRepository(find(), find()));

    Get.lazyPut<ILocalShopProvider>(() => LocalShopProvider());
    Get.lazyPut<ISHopProvider>(() => ShopProvider(find()));
    Get.lazyPut<IShopRepository>(() => ShopRepository(find(), find(), find()));

    Get.lazyPut(() => SplashController(find(), find(), find()));

    Get.lazyPut(() => WelcomeController(find()));
  }
}
