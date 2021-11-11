import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/data/models/get_all_message_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';

abstract class ISmsProvider {
  Future<Response<GetAllMessage>> getAllSms({int shopId});
}

class SMSProvider extends GetConnect implements ISmsProvider {
  final IAuthRepository authRepository;

  SMSProvider(this.authRepository);

  @override
  Future<Response<GetAllMessage>> getAllSms({int shopId}) async {
    String url = "https://dev.hishabee.business/api/V2/sms?shop_id=$shopId";

    final creds = await authRepository.getCredentials();

    return get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      // decoder: getAllMessageFromJson,
    );
  }
}
