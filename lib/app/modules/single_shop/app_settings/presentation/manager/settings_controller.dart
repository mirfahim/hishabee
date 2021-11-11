import 'dart:io';

import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_services/localization_service.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/login_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/_navigation/home_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/main.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class SettingsController extends GetxController {
  final ILocalizationService localizationService;
  final IAuthRepository authRepository;

  final cred = Rxn<LoginResponseModel>();

  final shop = Shop().obs;
  final token = ''.obs;

  SettingsController(this.localizationService, this.authRepository);

  @override
  onInit() async {
    getArguments();

    super.onInit();
  }

  @override
  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getToken();
    await getCred();
  }

  getArguments() {
    shop.value = Get.arguments["shop"];
  }

  Future<void> getToken() async {
    final creds = await authRepository.getCredentials();
    token.value = creds.accessToken;
  }

  Future<void> logout() async {
    await authRepository.removeCredentials();
    await clearDb();
    Get.offAllNamed(HomeRoutes.WELCOME);
    Get.snackbar('Logout successful', '');
  }

  Future<void> changeLanguageToEnglish() async {
    await localizationService.toEnglish();
  }

  Future<void> changeLanguageToBangla() async {
    await localizationService.toBangla();
  }

  Future<void> clearDb() async {
    Hive.close();

    final appDir = await getApplicationDocumentsDirectory();

    final hiveDb = Directory('${appDir.path}/$hiveDbDirectory');

    hiveDb.delete(recursive: true);
  }

  getCred() async {
    final result = await authRepository.getCredentials();
    cred.value = result;
  }
}
