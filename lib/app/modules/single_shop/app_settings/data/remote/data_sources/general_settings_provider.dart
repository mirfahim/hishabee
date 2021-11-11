import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/app_version_check_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/store_credentials_response_model.dart';

abstract class IGeneralSettingsProvider {
  Future<Response<AppVersionCheckResponseModel>> checkAppVersion();

  Future<Response<StoreCredentialsResponseModel>> getStoreCredential();
}

class GeneralSettingsProvider extends GetConnect
    implements IGeneralSettingsProvider {
  final IAuthRepository authRepository;

  GeneralSettingsProvider(this.authRepository);

  @override
  Future<Response<AppVersionCheckResponseModel>> checkAppVersion() async {
    String url = '$BASE_URL}/version/android';

    final creds = await authRepository.getCredentials();

    return post(
      url,
      {},
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
    );
  }

  @override
  Future<Response<StoreCredentialsResponseModel>> getStoreCredential() async {
    String url = '$BASE_URL}/pay/store';

    final creds = await authRepository.getCredentials();

    return get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
    );
  }
}
