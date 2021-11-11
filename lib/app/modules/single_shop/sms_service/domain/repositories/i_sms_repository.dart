import 'package:hishabee_business_manager_fl/app/modules/single_shop/sms_service/data/models/get_all_message_model.dart';

abstract class ISmsRespository {
  Future<GetAllMessage> getAllMessage({int shopId});
}
