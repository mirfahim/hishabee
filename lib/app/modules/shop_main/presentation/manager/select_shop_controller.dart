import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/user_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';

class SelectShopController extends GetxController with StateMixin<List<Shop>> {
  final IShopRepository shopRepository;
  final IAuthRepository authRepository;

  SelectShopController(this.shopRepository, this.authRepository);

  final user = User().obs;

  @override
  void onInit() async {
    super.onInit();
    await getUser();
    append(() => getAllShop);
  }

  Future<List<Shop>> getAllShop() async {
    return shopRepository.getAllShop();
  }

  Future<void> reload() async {
    append(() => getAllShop);
  }

  Future<void> getUser() async {
    final creds = await authRepository.getCredentials();

    user.value = creds.user;
  }

  Future<void> setCurrentShop(Shop shop) async {
    return await shopRepository.saveCurrentShop(shop);
  }
}
