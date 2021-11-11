import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_details_controller.dart';

import 'product_list_controller.dart';

class EditProductController extends GetxController {
  final IProductRepository productRepository;
  final IFileRepository fileRepository;

  final product = Rxn<Product>();
  final shop = Rxn<Shop>();
  final productCategoryList = <Category>[].obs;
  final subCatName = ''.obs;
  final catName = ''.obs;

  final selectedProductCategory = Rxn<Category>();
  final selectedSubCat = Rxn<SubCategory>();
  final productName = ''.obs;
  final vatApplicable = false.obs;
  final isOnline = false.obs;
  final vatAmount = 0.0.obs;
  final image = Rxn<File>();
  final price = 0.0.obs;
  final cost = 0.0.obs;
  final stockQuantity = 0.obs;
  final desc = ''.obs;
  final barcode = ''.obs;
  final productImageUrl = ''.obs;

  final formKey = GlobalKey<FormState>();

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
    await getCategoryList();
    getCategoryString();
    vatApplicable.value = product.value.vatApplicable;
    productImageUrl.value = product.value.imageUrl;
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
    product.value = Get.arguments["product"];
  }

  getCategoryList() async {
    final response = await productRepository.getProductCategories();
    productCategoryList.assignAll(response);
  }

  getCategoryString() {
    productCategoryList
        .forEach((Category c) => c.subCategory.forEach((SubCategory sc) {
              if (sc.id == product.value.subCategory) {
                subCatName.value = sc.name;
                catName.value = c.name;
                selectedSubCat.value = sc;
                selectedProductCategory.value = c;
              }
            }));
  }

  EditProductController(this.productRepository, this.fileRepository);

  Future<void> editProduct() async {
    String imageSource;
    if (image.value != null) {
      imageSource =
          await fileRepository.uploadFile(file: image.value, type: 'product');
    }

    final result = await productRepository.editProduct(
      id: product.value.id,
      barcode: barcode.value,
      variationId: product.value.productVarianceId,
      category: selectedSubCat.value.id,
      name: productName.value,
      varianceName: product.value.varianceName,
      sellingPrice: price.value,
      stock: stockQuantity.value,
      cost: cost.value,
      description: desc.value,
      vatApplicable: vatApplicable.value,
      vatPercentage: vatAmount.value ?? 0,
      imageSource: imageSource,
    );

    final plc = Get.find<ProductListController>();

    int index = plc.searchList.indexOf(
        plc.searchList.where((ele) => ele.id == result.product.id).first);
    plc.searchList.removeWhere((element) => element.id == result.product.id);
    plc.searchList.insert(index, result.product);
    plc.productList.assignAll(plc.searchList);

    try {
      final pdc = Get.find<ProductDetailsController>();

      pdc.product.value = result.product;
    } catch (e) {}
    return result;
  }

  Future<void> deleteProducts(int productId) async {
    CustomDialog.showLoadingDialog(message: "Deleting Product");
    final result = await productRepository.deleteProduct(
        shop.value.id, productId, product.value.shopProductVarianceId);
    if (Get.isDialogOpen) {
      Get.back();
    }
    if (result.code == 200) {
      final plc = Get.find<ProductListController>();
      plc.searchList.removeWhere((element) => element.id == product.value.id);
      plc.productList.assignAll(plc.searchList);
      Get.back();
    } else {
      CustomDialog.showStringDialog(result.message);
    }
  }

  removeProductImage() {
    productImageUrl.value = "";
  }
}
