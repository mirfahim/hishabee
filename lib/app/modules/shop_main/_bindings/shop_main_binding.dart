import 'package:get/get.dart';
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
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/create_shop_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/edit_shop_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/manage_shop_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/select_shop_controller.dart';

class ShopMainBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut<ISHopProvider>(() => ShopProvider(find()));
    Get.lazyPut<ILocalShopProvider>(() => LocalShopProvider());
    Get.lazyPut<IAreaProvider>(() => AreaProvider(find()));
    Get.lazyPut<ILocalAreaProvider>(() => LocalAreaProvider());
    Get.lazyPut<IFileProvider>(() => FileProvider(find()));

    Get.lazyPut<IShopRepository>(() => ShopRepository(find(), find(), find()));
    Get.lazyPut<IAreaRepository>(() => AreaRepository(find(), find(), find()));
    Get.lazyPut<IFileRepository>(() => FileRepository(find()));
    Get.lazyPut(() => CreateShopController(find(), find(), find()));
    Get.lazyPut(() => EditShopController(find(), find(), find()));
    Get.lazyPut(() => ManageShopController(find()));
    Get.lazyPut(() => SelectShopController(find(), find()));
  }
}
