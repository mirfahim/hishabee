import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/data_sources/auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/local/data_sources/local_area_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/local/data_sources/local_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/area_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/file_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/area_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_area_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/local/data_sources/local_online_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/data_sources/online_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/repositories/online_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/local/data_sources/local_products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/data_sources/products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/repositories/product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/local/data_sources/local_transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/data_sources/transaction_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/repositories/transaction_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/walkthrough/manager/store_publish_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/walkthrough/manager/store_setting_walkthrough_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/walkthrough/manager/walkthrough_product_list_controller.dart';

class WalkThroughBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<INetworkInfo>(() => NetworkInfo(find()));

    Get.lazyPut<IOnlineShopProvider>(() => OnlineShopProvider(find()));
    Get.lazyPut<ILocalOnlineShopProvider>(() => LocalOnlineShopProvider());
    Get.lazyPut<IOnlineShopRepository>(
        () => OnlineShopRepository(find(), find()));

    Get.lazyPut<ILocalAuthProvider>(() => LocalAuthProvider());
    Get.lazyPut<IAuthProvider>(() => AuthProvider(find()));
    Get.lazyPut<IAuthRepository>(() => AuthRepository(find(), find()));
    Get.lazyPut<ILocalAreaProvider>(() => LocalAreaProvider());
    Get.lazyPut<IAreaProvider>(() => AreaProvider(find()));
    Get.lazyPut<IAreaRepository>(() => AreaRepository(find(), find(), find()));

    Get.lazyPut<ILocalShopProvider>(() => LocalShopProvider());
    Get.lazyPut<ISHopProvider>(() => ShopProvider(find()));
    Get.lazyPut<IShopRepository>(() => ShopRepository(find(), find(), find()));

    Get.lazyPut<IFileProvider>(() => FileProvider(find()));
    Get.lazyPut<IFileRepository>(() => FileRepository(find()));

    Get.lazyPut(() => StorePublishController(find(), find(), find(), find()));
    Get.lazyPut(() => StoreSettingWalkThroughController());

    Get.lazyPut<ILocalProductProvider>(() => LocalProductProvider());
    Get.lazyPut<IProductProvider>(() => ProductProvider(find()));
    Get.lazyPut<IProductRepository>(
        () => ProductRepository(find(), find(), find()));
    Get.lazyPut(() => WalkThroughProductListController(find()));
  }
}
