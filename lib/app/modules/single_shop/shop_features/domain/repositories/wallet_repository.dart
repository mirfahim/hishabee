import 'package:hishabee_business_manager_fl/app/modules/single_shop/shop_features/data/remote/models/wallet_response.dart';

abstract class IWalletRepository {
  Future<WalletResponse> getAllWalletItem(int shopId);
}
