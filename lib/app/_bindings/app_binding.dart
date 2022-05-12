import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/_services/localization_service.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/local/data_sources/local_auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/data_sources/auth_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/repositories/auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/file_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/repositories/file_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_file_repository.dart';
import 'package:hishabee_business_manager_fl/controllers/business_overview/bo_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/digital_payment/dp_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/due/due_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/emi/emi_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/expense/expense_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/sms/sms_controller.dart';
import 'package:hishabee_business_manager_fl/controllers/stock/stock_controller.dart';

class AppBinding extends Bindings {
  static final find = Get.find;

  @override
  void dependencies() {
    Get.lazyPut(() => Connectivity(), fenix: true);
    Get.lazyPut<INetworkInfo>(() => NetworkInfo(find()), fenix: true);
    Get.lazyPut<ILocalAuthProvider>(() => LocalAuthProvider(), fenix: true);
    Get.lazyPut<IAuthProvider>(() => AuthProvider(find()), fenix: true);
    Get.lazyPut<IAuthRepository>(() => AuthRepository(find(), find()),
        fenix: true);

    Get.lazyPut<ILocalizationService>(() => LocalizationService(), fenix: true);

    Get.lazyPut<IFileProvider>(() => FileProvider(find()), fenix: true);
    Get.lazyPut<IFileRepository>(() => FileRepository(find()), fenix: true);
    Get.put(BoController());
    Get.put(EmiController());
    Get.put(SmsController());
    Get.put(DpController());
    Get.put(ExpenseController());
    Get.put(StockController());
    Get.put(DueController());
  }
}
