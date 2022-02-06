import 'dart:io';

import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/category_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_list_controller.dart';

class AddProductController extends GetxController {
  var messageObs = ''.obs;
  final quickAddEnable = false.obs;
  final showCase = true.obs;
  final advancedShowCase = false.obs;
  final image = Rxn<File>();

  final isOnline = false.obs;

  final productCategoryList = <Category>[].obs;
  final searchProductCategoryList = <Category>[].obs;

  final IProductRepository productRepository;
  final IFileRepository fileRepository;

  AddProductController(this.productRepository, this.fileRepository);

  @override
  void onInit() {
    super.onInit();
    AnalyticsService.sendAnalyticsToServer(event: AnalyticsEvent.productCreate);
    Future.delayed(const Duration(seconds: 3), () {
      showCase.value = false;
    });
  }

  Future<AddProductResponseModel> addProduct({
    int shopId,
    int subcategoryId,
    String productName,
    double price,
    String desc,
    String imageUrl,
    int stockQuantity,
    double cost,
    bool vatApplicable,
    String barcode,
    String attribute,
    double vatAmount,
  }) async {
    //String imageUrl;
    String imageSrc;
    if (image.value != null) {
      imageUrl =
          await fileRepository.uploadFile(file: image.value, type: 'product');
      imageSrc =
          imageUrl
          .replaceAll("//", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }
    print("my image default image path  is $imageUrl");
    print("my image url is $imageSrc");
    final result = await productRepository.addProduct(
      shopId: shopId,
      subcategoryId: subcategoryId,
      productName: productName,
      price: price,
      desc: desc ?? null,
      imageUrl: imageSrc ?? null,
      stockQuantity: stockQuantity ?? 0,
      cost: cost ?? 0.0,
      vatApplicable: vatApplicable ?? null,
      barcode: barcode ?? null,
      attribute: attribute ?? null,
      vatAmount: vatAmount ?? 0,
    );

    if (result.code == 200) {
      AnalyticsService.sendAnalyticsToServer(
          event: AnalyticsEvent.productCreateComplete);
    }

    final plc = Get.find<ProductListController>();

    plc.searchList.add(result.product);

    plc.productList.assignAll(plc.searchList);

    return result;
  }

  Future<AddProductResponseModel> addProductWithAttribute({
    int shopId,
    int subcategoryId,
    String productName,
    double price,
    String desc,
    int stockQuantity,
    double cost,
    bool vatApplicable,
    String barcode,
    String attribute,
    double vatAmount,
  }) async {
    String imageUrl;
    String imageSrc;
    if (image.value != null) {
      imageUrl =
          await fileRepository.uploadFile(file: image.value, type: 'product');
      imageSrc = imageUrl
          .replaceAll("\\", "")
          .replaceAll('"', "")
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAllMapped('url:', (match) => "");
    }
    final result = await productRepository.addProductWithAttribute(
      shopId: shopId,
      subcategoryId: subcategoryId,
      productName: productName,
      price: price,
      desc: desc,
      imageUrl: imageSrc,
      stockQuantity: stockQuantity,
      cost: cost,
      vatApplicable: vatApplicable,
      barcode: barcode,
      attribute: attribute,
      vatAmount: vatAmount,
    );

    final plc = Get.find<ProductListController>();

    plc.searchList.add(result.product);
    plc.productList.assignAll(plc.searchList);

    return result;
  }

  @override
  void onReady() {
    searchProductCategoryList.assignAll(productCategoryList);
    super.onReady();
  }

  Future<void> searchCategory(String searchCatName) async {
    final result = productCategoryList
        .where((Category category) =>
            category.name.toLowerCase().contains(searchCatName.toLowerCase()))
        .toList();
    searchProductCategoryList.assignAll(result);
  }
}
