import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';

class DeliveryPageController extends GetxController {
  final IOnlineShopRepository _onlineShopRepository;

  DeliveryPageController(this._onlineShopRepository);

  final formKey = GlobalKey<FormState>();
  final deliveryCompanyUrl = "".obs;
  final deliveryCompanyUrls = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getDeliveryCompanyUrls();
  }

  Future<void> addDeliveryCompanyUrl() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      await _onlineShopRepository.addDeliveryCompanyUrl(
          DataHolder.shopId, deliveryCompanyUrl.value);
    }

    await getDeliveryCompanyUrls();

    Get.back();
  }

  Future<void> getDeliveryCompanyUrls() async {
    final res =
        await _onlineShopRepository.getDeliveryCompanyUrls(DataHolder.shopId);

    if (res.isNotEmpty) {
      deliveryCompanyUrls.assignAll(res);
    }
  }
}
