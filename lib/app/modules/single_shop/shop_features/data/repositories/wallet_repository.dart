import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/data/remote/data_sources/wallet_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/data/remote/models/wallet_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/domain/repositories/wallet_repository.dart';

class WalletRepository implements IWalletRepository {
  final IWalletProvider _walletProvider;
  WalletRepository(this._walletProvider);

  @override
  Future<WalletResponse> getAllWalletItem(int shopId) async {
    final response = await _walletProvider.getAllWalletItem(shopId);
    return ResponseDecoder.decode(response);
  }
}
