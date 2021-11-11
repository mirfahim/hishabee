import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/account_information_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/account_information_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_account_information_repository.dart';

class AccountInformationRepository implements IAccountInformationRepository {
  final IAccountInformationProvider accountInformationProvider;

  AccountInformationRepository(this.accountInformationProvider);

  @override
  Future<AccountInformationResponseModel> getAccountInformation() async {
    final response = await accountInformationProvider.getAccountInformation();

    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> saveAccountInformation(
      {int shopId,
      String accountType,
      String bKash,
      String accountName,
      String accountNumber,
      String bankName,
      String bankRoutingNumber}) async {
    final response = await accountInformationProvider.saveAccountInformation(
        shopId: shopId,
        accountType: accountType,
        bKash: bKash,
        accountName: accountName,
        accountNumber: accountNumber,
        bankName: bankName,
        bankRoutingNumber: bankRoutingNumber);
    return ResponseDecoder.decode(response);
  }
}
