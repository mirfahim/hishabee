import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/data/remote/models/wallet_response.dart';

abstract class IWalletProvider {
  Future<Response<WalletResponse>> getAllWalletItem(int shopId);
}

class WalletProvider extends GetConnect implements IWalletProvider {
  final IAuthRepository _authRepository;
  WalletProvider(this._authRepository);

  @override
  Future<Response<WalletResponse>> getAllWalletItem(int shopId) async {
    final creds = await _authRepository.getCredentials();
    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get("$BASE_URL/wallet/all?shop_id=$shopId",
        headers: headers, decoder: walletResponseFromRawJson);
  }
}
