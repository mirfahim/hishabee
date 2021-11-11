import 'dart:io';

import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/analytics_event.dart';
import 'package:hishabee_business_manager_fl/app/_workmanager/analytics_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/add_product_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/domain/repositories/i_product_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/presentation/manager/product_list_controller.dart';

class WalkThroughAddProductController extends GetxController {
  var messageObs = ''.obs;
  final quickAddEnable = false.obs;
  final showCase = true.obs;
  final advancedShowCase = false.obs;
  final image = Rxn<File>();

  final isOnline = false.obs;

  final IProductRepository productRepository;
  final IFileRepository fileRepository;

  WalkThroughAddProductController(this.productRepository, this.fileRepository);

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
    String imageUrl;
    if (image.value != null) {
      imageUrl =
          await fileRepository.uploadFile(file: image.value, type: 'product');
    }
    final result = await productRepository.addProduct(
      shopId: shopId,
      subcategoryId: subcategoryId,
      productName: productName,
      price: price,
      desc: desc,
      imageUrl: imageUrl,
      stockQuantity: stockQuantity,
      cost: cost,
      vatApplicable: vatApplicable,
      barcode: barcode,
      attribute: attribute,
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
    print("ADD W ATTR");
    String imageUrl;
    if (image.value != null) {
      imageUrl =
          await fileRepository.uploadFile(file: image.value, type: 'product');
    }
    final result = await productRepository.addProductWithAttribute(
      shopId: shopId,
      subcategoryId: subcategoryId,
      productName: productName,
      price: price,
      desc: desc,
      imageUrl: imageUrl,
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
}
