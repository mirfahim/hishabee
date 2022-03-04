import 'dart:io';
import 'dart:math';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/presentation/manager/shop_features_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/add_transaction_request.dart';
import 'package:uuid/uuid.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/quick_sell_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/domain/repositories/i_transaction_repository.dart';

class SellController extends GetxController {
  // final sell = "".obs;
  final isGrid = false.obs;
  final showCase = true.obs;
  final amountCal = 0.0.obs;
  final showHide = false.obs;
  final sms = false.obs;
  final shop = Rxn<Shop>();
  final categoryList = <Category>[].obs;
  final productList = <Product>[].obs;
  final searchList = <Product>[].obs;
  final subCategoryList = <SubCategory>[].obs;
  final subCategoryNames = <String>['Quick Sell', 'All Category'].obs;
  final customProductName = ''.obs;
  final customProductPrice = ''.obs;

  final cart = <Product>[].obs;
  final totalCartPrice = 0.0.obs;
  final filterCategory = <SubCategory>[].obs;
  var isChecked = <bool>[].obs;
  final checkedFilterCategory = <SubCategory>[].obs;

  final animate = false.obs;

  final discount1 = 0.0.obs;
  final discount2 = 0.0.obs;
  final totalCartProductPrice = 0.0.obs;

  ///quick sell
  final customerField = true.obs;
  final profitField = true.obs;
  final smsField = true.obs;
  final selectedStartDate = DateTime.now().obs;
  final customerName = ''.obs;
  final customerPhone = ''.obs;
  final customerAddress = ''.obs;
  final productDetails = ''.obs;
  final amount = 0.0.obs;
  final profit = 0.obs;
  final sellType = 0.obs;

  ///

  final productCount = 1.obs;
  final productPrice = 0.0.obs;

  final discountPercent = 0.obs;
  final discountTk = 0.0.obs;

  final formKey = GlobalKey<FormState>();

  final dis1EditingController = TextEditingController().obs;
  final dis2EditingController = TextEditingController().obs;

  TextEditingController searchTextEditingController;

  final IProductRepository _productRepository;
  final ITransactionRepository transactionRepository;
  final IShopRepository _shopRepository;
  SellController(this._productRepository, this.transactionRepository,
      this._shopRepository);

  final animationX = 0.0.obs;
  final animationY = 0.0.obs;
  ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(microseconds: 100));

  @override
  void onInit() async {
    getArguments();
    searchTextEditingController = TextEditingController();

    Future.delayed(const Duration(seconds: 3), () {
      showCase.value = false;
      showHide.value = true;
    });

    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllCategories();

    await getAllProducts();

    productList.forEach((element) {
      getSubcategoryName(element.subCategory);
    });
    searchList.assignAll(productList);

    var scs = subCategoryList.toSet().toList();
    subCategoryList.assignAll(scs);

    subCategoryList.forEach((element) {
      subCategoryNames.add(element.name);
    });
    filterCategory.assignAll(subCategoryList.toSet().toList());

    var tic = List<bool>.filled(filterCategory.length, false);

    isChecked.assignAll(tic);
  }

  @override
  void onClose() {
    super.onClose();
    searchTextEditingController.dispose();
  }

  getArguments() async {
    shop.value = Get.arguments["shop"];
  }

  getAllProducts() async {
    final response = await _productRepository.getAllProduct(shop.value.id);
    productList.assignAll(response);
  }

  getAllCategories() async {
    final response = await _productRepository.getProductCategories();

    categoryList.assignAll(response);
  }

  getSubcategoryName(int id) {
    categoryList.forEach((element) {
      element.subCategory.forEach((e) {
        if (e.id == id) {
          subCategoryList.add(e);
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
      }
      if (list[0] == list[1]) {
        barcodeScanRes = list[1];
      }
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

  checkFilterCategory(int index, bool value) {
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

  List<Product> getProductsByCategory(int catId) {
    final result = productList
        .where((Product product) => product.subCategory == catId)
        .toList();
    searchList.assignAll(result);
    return result;
  }

  animateButton() {
    animate.value = true;
    Future.delayed(const Duration(seconds: 1), () {
      animate.value = false;
    });
  }

  calculateTotalCartPrice() {
    var totalPrice = 0.0;
    var d1Price = 0.0;
    var d2Price = 0.0;
    cart.forEach((element) {
      totalPrice += element.sellingPrice;
    });
    totalCartProductPrice.value = totalPrice;
    d1Price = totalPrice - ((totalPrice * discount1.value) / 100);
    d2Price = d1Price - discount2.value;
    totalCartPrice.value = d2Price;
  }

  addToCart(Product product) {
    product.unit = 1;
    for (int i = 0; i < productCount.value; i++) {
      cart.add(product);
    }
    print('UNIT :${product.unit}');
    calculateTotalCartPrice();
  }

  increaseCartItem(int index, Product product) {
    cart.removeAt(index);
    product.unit = product.unit + 1;
    product.sellingPrice = product.basePrice * product.unit;
    cart.insert(index, product);
    calculateTotalCartPrice();
  }

  decreaseCartItem(int index, Product product) {
    if (product.unit > 1) {
      cart.removeAt(index);
      product.unit = product.unit - 1;
      product.sellingPrice = product.basePrice * product.unit;
      cart.insert(index, product);
      calculateTotalCartPrice();
    }
  }

  removeFromCart(Product product) {
    cart.removeWhere((element) => element.id == product.id);
    calculateTotalCartPrice();
  }

  clearCart() {
    cart.clear();
    calculateTotalCartPrice();
  }

  calculateProductPrice(Product product) {
    var price = product.sellingPrice.toDouble() * productCount.value;
    var discountFromPercent = (price * discountPercent.value) / 100;
    productPrice.value = price - (discountFromPercent + discountTk.value);
  }

  quickSell() async {
    formKey.currentState.save();
    var uuid = Uuid();
    String tUniqueId = shop.value.id.toString() +
        uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString();
    String uniqueId = shop.value.id.toString() +
        uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString();
    String funiqueId = uniqueId.replaceAll("'", "");
    String sellUniqueId = uuid.v1().toString() +
        DateTime.now().microsecondsSinceEpoch.toString() +
        shop.value.id.toString();
    String fSellUniqueId = sellUniqueId.replaceAll("'", "");
    QuickSellRequest quickSellRequest = QuickSellRequest(
      createdAt: DateTime.now().toString(),
      shopId: shop.value.id,
      details: productDetails.value,
      price: amount.value,
      version: 0,
      uniqueId: funiqueId,
      transactionUniqueId: fSellUniqueId,
      updatedAt: DateTime.now().toString(),
      profit: profit.value,
    );
    AddTransactionRequest transaction = AddTransactionRequest(
      shopId: shop.value.id,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      version: 0,
      changeAmount: 0.toString(),
      message: '',
      paymentMethod: 1,
      note: productDetails.value,
      smsCount: 0,
      totalItem: 1,
      totalProfit: profit.value.toString(),
      totalPrice: amount.value.toString(),
      totalVat: 0,
      transactionBarcode: '',
      receivedAmount: amount.value.toString(),
      totalDiscount: 0,
      customerMobile: customerPhone.value,
      customerAddress: '',
      uniqueId: tUniqueId,
      transaction_type: "QUICK_SELL",
    );
    final response = await transactionRepository.quickSell(quickSellRequest);
    print("${response.code}");
    if (response.code == 200) {
      final response = await transactionRepository.addTransaction(transaction);
      if (response.code == 200) {
        formKey.currentState.reset();
        clearCart();
        Get.find<ShopFeaturesController>().initData();
        Get.dialog(Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 250.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 200,
                  width: 250,
                  child: ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality.explosive,
                    // don't specify a direction, blast randomly
                    shouldLoop: true,
                    // start again as soon as the animation is finished
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                    // manually specify the colors to be used
                    createParticlePath: drawStar, // define a custom shape/path.
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ScaleAnimatedWidget.tween(
                enabled: true,
                duration: Duration(milliseconds: 800),
                scaleDisabled: 0.5,
                scaleEnabled: 1,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.lightBlueAccent, width: 5),
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ));
        _controllerCenter.play();
        Future.delayed(Duration(seconds: 3), () {
          _controllerCenter.stop();
          Get.back();
        });
      }
    }
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}
