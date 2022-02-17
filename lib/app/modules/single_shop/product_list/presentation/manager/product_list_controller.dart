import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/local/data_sources/local_products_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';

class ProductListController extends GetxController {
  final IProductRepository productRepository;
  ILocalProductProvider localProductProvider;
  var productList = <Product>[].obs;
  final searchList = <Product>[].obs;
  final catList = Rxn<Category>();
  var loading = false.obs;
  var isChecked = <bool>[].obs;
  var flag = 0.obs;
  var totalProductsCost = 0.obs;
  var totalProductCount = 0.obs;

  final shop = Rxn<Shop>();
  final productCategoryList = <Category>[].obs;
  final unitList = <Category>[].obs;
  final filterCategory = <SubCategory>[].obs;
  final checkedFilterCategory = <SubCategory>[].obs;
  final tempSubCatList = <SubCategory>[].obs;

  ProductListController(this.productRepository);

  @override
  void onInit() async {
    getArguments();
    AnalyticsService.sendAnalyticsToServer(event: AnalyticsEvent.productList);
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getCategories();
    await getAllProduct();
    productList.forEach((element) {
      getSubcategoryName(element.subCategory);
    });

    totalProductsCost.value = productList.value
        .map((e) => e.stock > 0 ? e.costPrice * e.stock : 0)
        .fold(0, (previousValue, element) => element + previousValue)
        .toInt();
    filterCategory.assignAll(tempSubCatList.toSet().toList());

    var tic = List<bool>.filled(filterCategory.length, false);

    isChecked.assignAll(tic);
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
  }

  getCategories() async {
    final result = await productRepository.getProductCategories();
    productCategoryList.assignAll(result);
  }

  getAllProduct() async {
    var list = await productRepository.getAllProduct(shop.value.id);
    totalProductCount.value = list.length;
    print(totalProductCount.value);
    if (list != null) {
      productList.assignAll(list);
      searchList.assignAll(list);
      loading.value = true;
    }
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

  Future<void> searchProduct(String searchProductName) async {
    final result = productList
        .where((Product product) => product.productName
            .toLowerCase()
            .contains(searchProductName.toLowerCase()))
        .toList();
    searchList.assignAll(result);
  }

  Future<void> scanProduct() async {
    String barcodeScanRes;
    try {
      List<String> list = [];
      for (int i = 0; i < 2; i++) {
        var res = await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", true, ScanMode.DEFAULT);

        list.add(res);
        print("Working .................... 11111 $res");
      }
      if (list[0] == list[1]) {
        barcodeScanRes = list[1];
        print("Working .................... 22222 $barcodeScanRes");
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      print("Working .................... 33333 $barcodeScanRes");
    }

    final result = productList
        .where((Product product) => product.barcode == barcodeScanRes)
        .toList();
    if (result.isNotEmpty) {
      print("my scan list is $result");
      searchList.assignAll(result);
    } else {
      print("vulval");
      CustomDialog.showStringDialog("No Product Found");

      searchList.assignAll(productList);
    }
  }

  Future<void> filterProduct(int catId) async {
    final result = productList
        .where((Product product) => product.subCategory == catId)
        .toList();
    searchList.assignAll(result);
  }

  Future<void> updateStock(int shopId, Product product, int stock) async {
    final tempProduct = product;
    tempProduct.stock = stock;
    final result = await productRepository.updateStock(shopId, [tempProduct]);

    if (result.code == 200) {
      searchList.removeWhere((element) => element.id == product.id);

      searchList.add(product);
    }

    Get.back();
  }

  checkFilterCategory(int index, bool value) {
    print(checkedFilterCategory.length);

    isChecked[index] = value;
    if (isChecked[index]) {
      checkedFilterCategory.add(filterCategory[index]);
    } else {
      checkedFilterCategory.remove(filterCategory[index]);
    }
    print(checkedFilterCategory.length);
  }

  filterProductsByCategory() {
    if (checkedFilterCategory.length > 0) {
      searchList.clear();
      checkedFilterCategory.toSet().toList().forEach((element) {
        print(element.name);
        productList.forEach((product) {
          if (product.subCategory == element.id) {
            searchList.add(product);
          }
        });
      });

      searchList.assignAll(searchList.toSet().toList());
    } else {
      searchList.assignAll(productList);
    }
  }
}
