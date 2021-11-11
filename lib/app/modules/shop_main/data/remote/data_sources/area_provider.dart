import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/area_response_model.dart';

abstract class IAreaProvider {
  Future<Response<List<Division>>> getAllArea();
}

class AreaProvider extends GetConnect implements IAreaProvider {
  final IAuthRepository authRepository;

  AreaProvider(this.authRepository);

  @override
  Future<Response<List<Division>>> getAllArea() async {
    String url = '$BASE_URL/area/all';

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      url,
      headers: headers,
      decoder: areaResponseFromRawJson,
    );
  }
}
