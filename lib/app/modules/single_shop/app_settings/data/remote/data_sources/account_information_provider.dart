import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/account_information_response_model.dart';

abstract class IAccountInformationProvider {
  Future<Response<GenericResponseModel>> saveAccountInformation({
    int shopId,
    String accountType,
    String bKash,
    String accountName,
    String accountNumber,
    String bankName,
    String bankRoutingNumber,
  });

  Future<Response<AccountInformationResponseModel>> getAccountInformation();
}

class AccountInformationProvider extends GetConnect
    implements IAccountInformationProvider {
  final IAuthRepository authRepository;

  AccountInformationProvider(this.authRepository);

  @override
  Future<Response<AccountInformationResponseModel>>
      getAccountInformation() async {
    String url = '$BASE_URL/account_information/show';

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      url,
      headers: headers,
      decoder: accountInformationResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<GenericResponseModel>> saveAccountInformation({
    int shopId,
    String accountType,
    String bKash,
    String accountName,
    String accountNumber,
    String bankName,
    String bankRoutingNumber,
  }) async {
    String url =
        '$BASE_URL/account_information/store?shop_id=$shopId&account_type=$accountType&bkash=$bKash&account_name=$accountName&account_number=$accountNumber&bank_name=$bankName&bank_routing_number=$bankRoutingNumber';
    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return post(
      url,
      {},
      headers: headers,
      decoder: genericResponseModelFromRawJson,
    );
  }
}
