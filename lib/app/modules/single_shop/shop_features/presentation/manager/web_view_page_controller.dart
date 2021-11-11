import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/_services/localization_service.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';

class WebViewPageController extends GetxController {
  final isConnected = false.obs;
  final headers = Map<String, String>().obs;
  final shopId = 0.obs;
  //final IAuthRepository _authRepository;

  final INetworkInfo _networkInfo;
  WebViewPageController(this._networkInfo);

  @override
  void onInit() async {
    await getIsConnected();
    await init();
    super.onInit();
  }

  init() async {
    shopId.value = DataHolder.shopId;
    /*final creds = await _authRepository.getCredentials();
    headers.assignAll({'Authorization': 'Bearer ${creds.accessToken}'});*/
  }

  Future<void> getIsConnected() async {
    isConnected.value = await _networkInfo.isConnected();
  }
}
