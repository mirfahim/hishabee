import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_shop_info_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';

class OnlineStoreDashboardController extends GetxController {
  final onlineShopInfoResponse = OnlineShopInfoResponseModel().obs;
  final IOnlineShopRepository _onlineShopRepository;

  OnlineStoreDashboardController(this._onlineShopRepository);

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
    await getOnlineShopInfo();
  }

  getOnlineShopInfo() async {
    final res =
        await _onlineShopRepository.getOnlineShopInfo(DataHolder.shopId);
    onlineShopInfoResponse.value = res;
  }
}
