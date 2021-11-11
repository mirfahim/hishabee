import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';

class TabsController extends GetxController {
  final productList = <Product>[].obs;
  final searchList = <Product>[].obs;

  search(String keyword) {
    final result = productList
        .where((element) =>
            element.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    searchList.assignAll(result);
  }

  init(List<Product> products) {
    productList.assignAll(products);
    if (searchList.isEmpty) {
      searchList.assignAll(products);
    }
  }

  clearSearch(int index) {
    searchList.assignAll(productList);
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
    if (result != null) {
      searchList.assignAll(result);
    } else {
      CustomDialog.showStringDialog("No Product Found");

      searchList.assignAll(productList);
    }
  }
}
