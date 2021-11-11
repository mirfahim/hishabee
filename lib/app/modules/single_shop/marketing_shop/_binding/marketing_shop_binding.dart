import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_services/localization_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/data_sources/auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/marketing_shop/presentation/manager/marketing_shop_controller.dart';

class MarketingShopBinding extends Bindings {
  final find = Get.find;
  @override
  void dependencies() {
    Get.lazyPut<ILocalAuthProvider>(() => LocalAuthProvider());
    Get.lazyPut<IAuthProvider>(() => AuthProvider(find()));
    Get.lazyPut<IAuthRepository>(() => AuthRepository(find(), find()));
    Get.lazyPut<ILocalizationService>(() => LocalizationService());
    Get.lazyPut(() => MarketingShopController(find(), find(), find()));
  }
}
