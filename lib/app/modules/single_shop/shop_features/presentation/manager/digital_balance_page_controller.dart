import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/login_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/data/remote/models/wallet_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/domain/repositories/wallet_repository.dart';

class DigitalBalancePageController extends GetxController {
  final IWalletRepository _walletRepository;
  final IAuthRepository _authRepository;
  DigitalBalancePageController(this._walletRepository, this._authRepository);

  final walletResponse = Rxn<WalletResponse>();
  final cred = Rxn<LoginResponseModel>();

  @override
  void onInit() async {
    await getAllWalletItem();
    getCred();
    super.onInit();
  }

  getAllWalletItem() async {
    final result = await _walletRepository.getAllWalletItem(DataHolder.shopId);
    walletResponse.value = result;
  }

  getCred() async {
    final result = await _authRepository.getCredentials();
    cred.value = result;
  }
}
