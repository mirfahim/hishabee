import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_list_controller.dart';

class ProductDetailsController extends GetxController {
  final product = Rxn<Product>();
  final shop = Rxn<Shop>();
  final productCategoryList = <Category>[].obs;

  final productSubCategory = ''.obs;
  final stock = 0.obs;
  final productStock = 0.obs;

  final textEditingController = Rxn<TextEditingController>();

  final IProductRepository productRepository;

  ProductDetailsController(this.productRepository);

  @override
  void onInit() {
    getArguments();
    getCategoryString();
    stock.value = product.value.stock;
    productStock.value = product.value.stock;
    textEditingController.value =
        TextEditingController(text: stock.value.toString());
    super.onInit();
  }

  getArguments() {
    product.value = Get.arguments['product'];
    shop.value = Get.arguments['shop'];
    productCategoryList.assignAll(Get.arguments['catList']);
  }

  getCategoryString() {
    productCategoryList
        .forEach((Category c) => c.subCategory.forEach((SubCategory sc) {
              if (sc.id == product.value.subCategory) {
                productSubCategory.value = sc.name;
              }
            }));
  }

  incrementStock() {
    var temp = ++stock.value;
    textEditingController.value.value = TextEditingValue(text: temp.toString());
  }

  decrementStock() {
    var temp = stock.value > 0 ? --stock.value : 0;
    textEditingController.value.value = TextEditingValue(text: temp.toString());
  }

  Future<void> updateStock() async {
    final tempProduct = product.value;
    tempProduct.stock = stock.value;
    final result =
        await productRepository.updateStock(shop.value.id, [tempProduct]);

    if (result.code == 200) {
      product.update((val) {
        val.stock = stock.value;
        final plc = Get.find<ProductListController>();

        plc.searchList.removeWhere((element) => element.id == product.value.id);

        plc.searchList.add(product.value);
      });
    }

    Get.back();
  }
}
