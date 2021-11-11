import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/update_due_response_model.dart';

abstract class IDueProvider {
  Future<Response<AddDueResponseModel>> addDue({
    int userId,
    int shopId,
    num amount,
    int customerId,
    String customerMobile,
    String customerName,
    String customerAddress,
  });

  Future<Response<GetAllDueResponseModel>> getAllDue({int shopId});

  Future<Response<UpdateDueResponseModel>> updateDue({
    int shopId,
    int customerId,
    num dueLeft,
    String customerMobile,
  });
}

class DueProvider extends GetConnect implements IDueProvider {
  final IAuthRepository authRepository;

  DueProvider(this.authRepository);

  @override
  Future<Response<AddDueResponseModel>> addDue({
    int userId,
    int shopId,
    num amount,
    int customerId,
    String customerMobile,
    String customerName,
    String customerAddress,
  }) async {
    String url = "$BASE_URL/due/lend";

    final creds = await authRepository.getCredentials();

    final body = {
      "user_id": userId,
      "shop_id": shopId,
      "amount": amount,
      "customer_id": customerId,
      "customer_mobile": customerMobile,
      "customer_name": customerMobile,
      "customer_address": customerMobile,
    };
    return post(
      url,
      body,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: addDueResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<GetAllDueResponseModel>> getAllDue({int shopId}) async {
    String url = "$BASE_URL/due/all?shop_id=$shopId";

    final creds = await authRepository.getCredentials();

    return get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: getAllDueResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<UpdateDueResponseModel>> updateDue({
    int shopId,
    int customerId,
    num dueLeft,
    String customerMobile,
  }) async {
    String url =
        "$BASE_URL/due/receive?shop_id=$shopId&customer_id=$customerId&amount=$dueLeft&customer_mobile=$customerMobile";

    final creds = await authRepository.getCredentials();

    return post(
      url,
      {},
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: updateDueResponseModelFromRawJson,
    );
  }
}
