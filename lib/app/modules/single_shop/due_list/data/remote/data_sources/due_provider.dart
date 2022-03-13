import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_item_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_item_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_request.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/add_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_item_by_uniq_id.dart';
// import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_item_by_unuque_id.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/get_all_due_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/due_list/data/remote/models/update_due_response_model.dart';

abstract class IDueProvider {
  Future<Response<AddDueResponseModel>> addDue({
    int userId,
    int shopId,
    num amount,
    int version,
    String image,
    String contactType,
    int customerId,
    String customerMobile,
    String customerName,
    String customerAddress,
  });

  Future<Response<GetAllDueResponseModel>> getAllDue({int shopId});

  Future<Response<AddDueResponse>> addNewDue(AddDueRequest addDueRequest);
  Future<Response<AddDueItemResponse>> addNewDueItem(
      AddDueItemRequest addDueItemRequest);

  Future<Response<List<GetAllDueItemByUid>>> getAllDueItemByUid({String uid});

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
    String image,
    int version,
    String contactType,
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
    String url = "$BASE_URL/due/all?shop_id=$shopId&page=1";

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

  @override
  Future<Response<List<GetAllDueItemByUid>>> getAllDueItemByUid(
      {String uid}) async {
    String url = "$BASE_URL/due/items?unique_id=$uid";

    final creds = await authRepository.getCredentials();

    return get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: getAllDueItemByUidFromRawJson,
    );
  }

  @override
  Future<Response<AddDueResponse>> addNewDue(
      AddDueRequest addDueRequest) async {
    String url = "$BASE_URL/due/add";
    final creds = await authRepository.getCredentials();

    var body = {
      "amount": addDueRequest.amount,
      "shop_id": addDueRequest.shopId,
      "unique_id": addDueRequest.uniqueId,
      "contact_type": addDueRequest.contactType,
      "contact_mobile": addDueRequest.contactMobile,
      "contact_name": addDueRequest.contactName,
      "version": addDueRequest.version,
      "updated_at": addDueRequest.createdAt,
      "created_at": addDueRequest.updatedAt
    };

    return post(
      url,
      body,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: addDueResponseFromRawJson,
    );
  }

  @override
  Future<Response<AddDueItemResponse>> addNewDueItem(
      AddDueItemRequest addDueItemRequest) async {
    String url = "$BASE_URL/due_item/add";
    final creds = await authRepository.getCredentials();

    var body = {
      "amount": addDueItemRequest.amount,
      "shop_id": addDueItemRequest.shopId,
      "unique_id": addDueItemRequest.uniqueId,
      "due_unique_id": addDueItemRequest.dueUniqueId,
      "due_left": addDueItemRequest.dueLeft,
      "version": addDueItemRequest.version,
      "updated_at": addDueItemRequest.updatedAt,
      "created_at": addDueItemRequest.createdAt
    };

    return post(
      url,
      body,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: addDueItemResponseFromRawJson,
    );
  }
}
