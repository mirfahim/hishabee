import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_navigation/auth_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';

abstract class ResponseDecoder {
  static decode(Response response) {
    if (response.unauthorized) {
      Get.find<IAuthRepository>().removeCredentials();
      Get.offAllNamed(AuthRoutes.LOGIN);
    }

    if (response.hasError) {
      // return Future.error(response.statusText);
    } else {
      return response.body;
    }
  }
}
