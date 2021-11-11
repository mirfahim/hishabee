import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/account_information_response_model.dart';

abstract class IAccountInformationRepository {
  Future<GenericResponseModel> saveAccountInformation({
    int shopId,
    String accountType,
    String bKash,
    String accountName,
    String accountNumber,
    String bankName,
    String bankRoutingNumber,
  });

  Future<AccountInformationResponseModel> getAccountInformation();
}
