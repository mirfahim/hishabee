import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/local/data_sources/local_area_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/local/data_sources/local_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/area_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/area_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_area_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/local/data_sources/local_online_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/data_sources/online_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/repositories/online_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/chat_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/chatting_page_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/delivery_page_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/online_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/order_details_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/order_list_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/store_dashboard_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/store_setting_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/local/data_sources/local_products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/data_sources/products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/repositories/product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';

class StoreBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<IProductProvider>(() => ProductProvider(find()));
    Get.lazyPut<IAreaProvider>(() => AreaProvider(find()));
    Get.lazyPut<ILocalAreaProvider>(() => LocalAreaProvider());
    Get.lazyPut<ISHopProvider>(() => ShopProvider(find()));
    Get.lazyPut<ILocalShopProvider>(() => LocalShopProvider());
    Get.lazyPut<ILocalProductProvider>(() => LocalProductProvider());
    Get.lazyPut<IProductRepository>(
        () => ProductRepository(find(), find(), find()));
    Get.lazyPut<ILocalOnlineShopProvider>(() => LocalOnlineShopProvider());
    Get.lazyPut<IOnlineShopProvider>(() => OnlineShopProvider(find()));
    Get.lazyPut<IOnlineShopRepository>(
        () => OnlineShopRepository(find(), find()));
    Get.lazyPut<IAreaRepository>(() => AreaRepository(find(), find(), find()));
    Get.lazyPut<IShopRepository>(() => ShopRepository(find(), find(), find()));
    Get.lazyPut(() => OnlineStoreDashboardController(find()));
    Get.lazyPut(() => OnlineProductController(find(), find()));
    Get.lazyPut(() => OrderListController(find()));
    Get.lazyPut(() => OrderDetailsController(find()));
    Get.lazyPut(() => DeliveryPageController(find()));
    Get.lazyPut(() => ChatUserController(find()));
    Get.lazyPut(() => ChattingPageController(find()));
    Get.lazyPut(
        () => OnlineStoreSettingController(find(), find(), find(), find()));
  }
}
