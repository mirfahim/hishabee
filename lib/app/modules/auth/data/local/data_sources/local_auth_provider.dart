import 'package:hishabee_business_manager_fl/app/modules/auth/data/remote/models/login_response_model.dart';
import 'package:hive/hive.dart';

abstract class ILocalAuthProvider {
  Future<LoginResponseModel> getCredentials();

  Future<void> saveCredentials(LoginResponseModel loginResponse);

  Future<void> removeCredentials();
}

class LocalAuthProvider implements ILocalAuthProvider {
  final String boxKey = 'authBox';
  final String authKey = 'authKey';

  @override
  Future<LoginResponseModel> getCredentials() async {
    LoginResponseModel loginResponseModel;
    final authBox = await Hive.openBox(boxKey);

    final str = authBox.get(authKey);

    if (str != null) {
      loginResponseModel = loginResponseModelFromJson(str);
    }
    return loginResponseModel;
  }

  @override
  Future<void> removeCredentials() async {
    final authBox = await Hive.openBox(boxKey);

    return await authBox.clear();
  }

  @override
  Future<void> saveCredentials(LoginResponseModel loginResponseModel) async {
    final authBox = await Hive.openBox(boxKey);

    return await authBox.put(
        authKey, loginResponseModelToJson(loginResponseModel));
  }
}
