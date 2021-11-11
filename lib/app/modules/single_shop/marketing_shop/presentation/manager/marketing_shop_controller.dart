import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/_services/localization_service.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';

class MarketingShopController extends GetxController {
  final url = 'https://hishabee.market/marketing/'.obs;

  final headers = Map<String, String>().obs;

  final isConnected = false.obs;

  final IAuthRepository _authRepository;
  final ILocalizationService _localizationService;
  final INetworkInfo _networkInfo;

  MarketingShopController(
      this._authRepository, this._localizationService, this._networkInfo);

  @override
  void onInit() async {
    await init();
    await getIsConnected();
    super.onInit();
  }

  init() async {
    final shopId = DataHolder.shopId;

    var language = 'bn';

    final creds = await _authRepository.getCredentials();

    headers.assignAll({'Authorization': 'Bearer ${creds.accessToken}'});

    final isBn = await _localizationService.isBangla();

    if (!isBn) {
      language = 'en';
    }
    url.value =
        'https://hishabee.market/marketing/index?shop_id=$shopId&language=$language';
  }

  Future<void> getIsConnected() async {
    isConnected.value = await _networkInfo.isConnected();
  }
}
