import 'dart:io';

import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/_bindings/product_list_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/pages/product_list_page.dart';

import 'product_list_controller.dart';

class DuplicateProductController extends GetxController {
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

  final IProductRepository productRepository;
  final IFileRepository fileRepository;

  DuplicateProductController(this.productRepository, this.fileRepository);

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

  Future<void> duplicateProduct() async {
    CustomDialog.showLoadingDialog(message: "Updating Product");
    String imageUrl;
    if (image.value != null) {
      imageUrl =
          await fileRepository.uploadFile(file: image.value, type: 'product');
    }
    final result = await productRepository.addProduct(
      shopId: shop.value.id,
      subcategoryId: selectedSubCat.value.id,
      productName: productName.value,
      price: price.value,
      desc: desc.value,
      imageUrl: imageUrl,
      stockQuantity: stockQuantity.value,
      cost: cost.value,
      vatApplicable: vatApplicable.value,
      barcode: barcode.value,
      attribute: "{}",
      vatAmount: vatAmount.value ?? 0,
    );

    final plc = Get.find<ProductListController>();

    plc.searchList.add(result.product);

    plc.productList.assignAll(plc.searchList);
    CustomDialog.hideDialog();
    Get.off(() => ProductListPage(), binding: ProductListBinding());
  }
}
