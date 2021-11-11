import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_item_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/transaction_and_refund/data/remote/models/transaction_model.dart';

class TransactionSellController extends GetxController {
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
  final transaction = Rxn<Transaction>();

  final cart = <Product>[].obs;
  final totalCartPrice = 0.0.obs;

  final animate = false.obs;

  final formKey = GlobalKey<FormState>();

  TextEditingController searchTextEditingController;

  final IProductRepository _productRepository;

  TransactionSellController(this._productRepository);

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
    transaction.value = Get.arguments['transaction'];
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
    cart.add(product);

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

  onConfirm() {
    print("TTP: ${transaction.value.totalPrice}");
    double totalPrice = 0.0;
    if (cart.isNotEmpty) {
      cart.forEach((element) {
        print("SP : ${element.sellingPrice}");
        var item = TransactionItem(
            id: element.id,
            createdAt: element.createdAt,
            discount: element.discount,
            imageSrc: element.imageUrl,
            name: element.name,
            price: element.basePrice,
            quantity: 1,
            sellingPrice: element.sellingPrice,
            shopProductId: element.shopProductId,
            shopProductVarianceId: element.shopProductVarianceId,
            subCategory: element.subCategory,
            transactionId: transaction.value.id,
            vat: element.vatPercent);
        transaction.value.transactionItems.add(item);
        totalPrice = totalPrice + element.sellingPrice;
      });
    }
    transaction.value.totalPrice += totalPrice;
    print("STP: $totalPrice");
    Get.back(result: transaction.value);
  }
}
