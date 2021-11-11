import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';

class OnlineProductController extends GetxController {
  final published = false.obs;

  final shop = Shop().obs;
  final products = <Product>[].obs;
  final categoryList = <Category>[].obs;

  final IProductRepository _productRepository;
  final IOnlineShopRepository _onlineShopRepository;

  OnlineProductController(this._productRepository, this._onlineShopRepository);

  @override
  void onInit() async {
    getArguments();
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllProducts();
    await getAllCategories();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
  }

  String getCatName(Product product) {
    var subCatName = '';
    categoryList
        .forEach((Category c) => c.subCategory.forEach((SubCategory sc) {
              if (sc.id == product.subCategory) {
                subCatName = sc.name;
              }
            }));
    return subCatName;
  }

  getAllProducts() async {
    final res = await _productRepository.getAllProduct(DataHolder.shopId);
    products.assignAll(res);
  }

  getAllCategories() async {
    final res = await _productRepository.getProductCategories();

    categoryList.assignAll(res);
  }

  publishToggle(Product product, bool isPublished) async {
    if (product.published != isPublished) {
      final updatedProduct = product.copyWith(
        published: isPublished,
      );
      CustomDialog.showLoadingDialog();
      final response = await _onlineShopRepository
          .onlineShopUpdateProducts(DataHolder.shopId, [updatedProduct]);
      CustomDialog.hideDialog();

      if (response.code == 200) {
        int index = products
            .indexOf(products.where((ele) => ele.id == product.id).first);
        products.removeWhere((element) => element.id == product.id);
        products.insert(index, updatedProduct);
      }
    }
  }
}
