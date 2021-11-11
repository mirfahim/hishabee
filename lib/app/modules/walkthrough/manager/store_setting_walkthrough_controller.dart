import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';

class StoreSettingWalkThroughController extends GetxController {
  final shop = Rxn<Shop>();

  final publishShop = true.obs;
  final addProduct = true.obs;
  final sellNow = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getArgument() {
    shop.value = Get.arguments["shop"];
  }
}
