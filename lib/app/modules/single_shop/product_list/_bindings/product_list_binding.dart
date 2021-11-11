import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/local/data_sources/local_products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/data_sources/products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/repositories/product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/add_category_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/add_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/categories_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/duplicate_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/edit_product_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_details_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_list_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/update_stock_controller.dart';

class ProductListBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut(() => AddCategoryController(find()));

    Get.lazyPut<INetworkInfo>(() => NetworkInfo(find()));
    Get.lazyPut<IProductProvider>(() => ProductProvider(find()));
    Get.lazyPut<ILocalProductProvider>(() => LocalProductProvider());
    Get.lazyPut<IProductRepository>(
        () => ProductRepository(find(), find(), find()));

    Get.lazyPut(() => ProductListController(find()));
    Get.lazyPut(() => AddProductController(find(), find()));
    Get.lazyPut(() => EditProductController(find(), find()));
    Get.lazyPut(() => DuplicateProductController(find(), find()));
    Get.lazyPut(() => ProductDetailsController(Get.find()));
    Get.lazyPut(() => CategoriesController(find()));
    Get.lazyPut(() => UpdateStockController(find()));
    // Get.lazyPut(() => )
  }
}
