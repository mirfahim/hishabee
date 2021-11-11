import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';

class SellController extends GetxController {
  // final sell = "".obs;
  final isGrid = false.obs;
  final showCase = true.obs;
  final showHide = false.obs;
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

  final animate = false.obs;

  final productCount = 1.obs;
  final productPrice = 0.0.obs;

  final discountPercent = 0.obs;
  final discountTk = 0.0.obs;

  final formKey = GlobalKey<FormState>();

  TextEditingController searchTextEditingController;

  final IProductRepository _productRepository;

  SellController(this._productRepository);

  final animationX = 0.0.obs;
  final animationY = 0.0.obs;

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
  }

  @override
  void onClose() {
    super.onClose();
    searchTextEditingController.dispose();
  }

  getArguments() {
    shop.value = Get.arguments['shop'];
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
    cart.forEach((element) {
      totalPrice += element.sellingPrice;
    });

    totalCartPrice.value = totalPrice;
  }

  addToCart(Product product) {
    product.unit = 1;
    for (int i = 0; i < productCount.value; i++) {
      cart.add(product);
    }
    calculateTotalCartPrice();
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
}
