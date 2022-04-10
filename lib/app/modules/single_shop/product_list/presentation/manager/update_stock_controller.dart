import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';

import 'product_list_controller.dart';

class UpdateStockController extends GetxController {
  final IProductRepository productRepository;
  var productList = <Product>[].obs;
  final searchList = <Product>[].obs;
  final catList = Rxn<Category>();
  var loading = false.obs;
  var productToUpdateList = <Product>[].obs;

  UpdateStockController(this.productRepository);

  final textEditingController = Rxn<TextEditingController>();
  final shop = Rxn<Shop>();
  final productCategoryList = <Category>[].obs;
  final filterCategory = <SubCategory>[].obs;
  final tempSubCatList = <SubCategory>[].obs;

  @override
  void onInit() {
    // fetchProduct();
    getArguments();
    AnalyticsService.sendAnalyticsToServer(event: AnalyticsEvent.stockList);
    productList.forEach((element) {
      getSubcategoryName(element.subCategory);
    });
    filterCategory.assignAll(tempSubCatList.toSet().toList());

    //getCategories();

    super.onInit();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
    productCategoryList.assignAll(Get.arguments["catList"]);
    productList.assignAll(Get.arguments["productList"]);
    searchList.assignAll(Get.arguments["productList"]);
  }

  getCategories() async {
    final result = await productRepository.getProductCategories();
    productCategoryList.assignAll(result);
  }

  getSubcategoryName(int id) {
    productCategoryList.forEach((element) {
      element.subCategory.forEach((e) {
        if (e.id == id) {
          tempSubCatList.add(e);
        }
      });
    });
  }

  incrementStock(Product product) {
    AnalyticsService.sendAnalyticsToServer(event: AnalyticsEvent.updateStock);
    product.stock++;
    productToUpdateList.add(product);
    int index = searchList
        .indexOf(searchList.where((ele) => ele.id == product.id).first);
    searchList.removeWhere((element) => element.id == product.id);
    searchList.insert(index, product);
  }

  decrementStock(Product product) {
    AnalyticsService.sendAnalyticsToServer(event: AnalyticsEvent.updateStock);
    product.stock--;
    productToUpdateList.add(product);
    int index = searchList
        .indexOf(searchList.where((ele) => ele.id == product.id).first);
    searchList.removeWhere((element) => element.id == product.id);
    searchList.insert(index, product);
  }

  Future<void> searchProduct(String searchProductName) async {
    final result = productList
        .where((Product product) => product.name
            .toLowerCase()
            .contains(searchProductName.toLowerCase()))
        .toList();
    searchList.assignAll(result);
  }

  Future<void> scanProduct() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.DEFAULT);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    final result = productList
        .where((Product product) => product.barcode == barcodeScanRes)
        .toList();
    print(result);
    print(barcodeScanRes);
    if (result != null) {
      searchList.assignAll(result);
    } else {
      CustomDialog.showStringDialog("No Product Found");
    }
  }

  Future<void> filterProduct(int catId) async {
    final result = productList
        .where((Product product) => product.subCategory == catId)
        .toList();
    searchList.assignAll(result);
  }

  Future<void> updateStock() async {
    final result =
        await productRepository.updateStock(shop.value.id, productToUpdateList);

    if (result.code == 200) {
      AnalyticsService.sendAnalyticsToServer(
          event: AnalyticsEvent.updateStockComplete);
      productToUpdateList.forEach((element) {
        searchList.removeWhere((e) => e.id == element.id);
      });
      productToUpdateList.forEach((el) {
        searchList.add(el);
      });

      final plc = Get.find<ProductListController>();

      await plc.getAllProduct();
    }
    Get.back();
  }
}
