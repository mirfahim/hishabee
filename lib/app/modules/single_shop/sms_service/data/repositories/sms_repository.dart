import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/data/data_sources/sms_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/data/models/get_all_message_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/domain/repositories/i_sms_repository.dart';

class SmsRepository implements ISmsRespository {
  final ISmsProvider smsProvider;

  SmsRepository(this.smsProvider);

  @override
  Future<GetAllMessage> getAllMessage({int shopId}) async {
    final response = await smsProvider.getAllSms(shopId: shopId);

    print("From sms repository REB : ${response.bodyString}");
    return ResponseDecoder.decode(response);
  }
}
