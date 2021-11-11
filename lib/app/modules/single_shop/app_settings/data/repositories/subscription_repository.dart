import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/data_sources/subscription_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_new_subscription_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/store_credentials_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_item_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_package_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/domain/repositories/i_subscription_repository.dart';

class SubscriptionRepository implements ISubscriptionRepository {
  final ISubscriptionProvider subscriptionProvider;

  SubscriptionRepository(this.subscriptionProvider);

  @override
  Future<AddNewSubscriptionResponseModel> addSubscriptionPayment({
    int shopId,
    int duration,
    double amountPaid,
    String package,
    int subscriptionPackageId,
    int campaignId,
  }) async {
    final response = await subscriptionProvider.addSubscriptionPayment(
      shopId: shopId,
      duration: duration,
      amountPaid: amountPaid,
      package: package,
      subscriptionPackageId: subscriptionPackageId,
      campaignId: campaignId,
    );

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<Subscription>> getAllSubscription({int shopId}) async {
    final response =
        await subscriptionProvider.getAllSubscription(shopId: shopId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<SubscriptionPackageResponseModel>> getAllSubscriptionPackages(
      {int shopId, String package}) async {
    final response = await subscriptionProvider.getAllSubscriptionPackages(
        shopId: shopId, package: package);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<StoreCredentialsResponseModel> getStoreCredential({int shopId}) async {
    final response =
        await subscriptionProvider.getStoreCredential(shopId: shopId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<SubscriptionItem>> getAllSubscriptionItem(int shopId) async {
    final response = await subscriptionProvider.getAllSubscriptionItem(shopId);

    return ResponseDecoder.decode(response);
  }
}
