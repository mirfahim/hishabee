import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_new_subscription_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/get_all_subscription_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/store_credentials_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_item_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_package_model.dart';

abstract class ISubscriptionProvider {
  Future<Response<AddNewSubscriptionResponseModel>> addSubscriptionPayment({
    int shopId,
    int duration,
    double amountPaid,
    String package,
    int subscriptionPackageId,
    int campaignId,
  });

  Future<Response<List<Subscription>>> getAllSubscription({int shopId});

  Future<Response<List<SubscriptionPackageResponseModel>>>
      getAllSubscriptionPackages({int shopId, String package});

  Future<Response<StoreCredentialsResponseModel>> getStoreCredential(
      {int shopId});

  Future<Response<List<SubscriptionItem>>> getAllSubscriptionItem(int shopId);
}

class SubscriptionProvider extends GetConnect implements ISubscriptionProvider {
  final IAuthRepository authRepository;

  SubscriptionProvider(this.authRepository);

  @override
  Future<Response<AddNewSubscriptionResponseModel>> addSubscriptionPayment({
    int shopId,
    int duration,
    double amountPaid,
    String package,
    int subscriptionPackageId,
    int campaignId,
  }) async {
    String url = '$BASE_URL/subscription/add';

    final body = {
      "shop_id": shopId,
      "duration": duration,
      "amount_paid": amountPaid,
      "package": package,
      "subscription_package_id": subscriptionPackageId,
      "campaign_id": campaignId,
    };

    final creds = await authRepository.getCredentials();

    final response = await post(
      url,
      body,
      decoder: addNewSubscriptionResponseModelFromRawJson,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
    );

    return response;
  }

  @override
  Future<Response<List<Subscription>>> getAllSubscription({int shopId}) async {
    String url = '$BASE_URL/subscription/all?shop_id=$shopId';

    final creds = await authRepository.getCredentials();

    final response = await get(
      url,
      decoder: getAllSubscriptionResponseFromRawJson,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
    );

    return response;
  }

  @override
  Future<Response<List<SubscriptionPackageResponseModel>>>
      getAllSubscriptionPackages({int shopId, String package}) async {
    String url =
        '$BASE_URL/subscription/packages?package=$package&shop_id=$shopId';

    final creds = await authRepository.getCredentials();

    final response = await get(
      url,
      decoder: subscriptionPackageResponseModelFromRawJson,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
    );

    return response;
  }

  @override
  Future<Response<StoreCredentialsResponseModel>> getStoreCredential(
      {int shopId}) async {
    String url = '$BASE_URL/pay/store?shop_id=$shopId';

    final creds = await authRepository.getCredentials();

    final response = await get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: storeCredentialsResponseModelFromRawJson,
    );

    return response;
  }

  @override
  Future<Response<List<SubscriptionItem>>> getAllSubscriptionItem(
      int shopId) async {
    String url = '$BASE_URL/subscription/all?shop_id=$shopId';

    final creds = await authRepository.getCredentials();

    final response = await get(
      url,
      headers: {'Authorization': 'Bearer ${creds.accessToken}'},
      decoder: subscriptionItemFromRawJson,
    );

    return response;
  }
}
