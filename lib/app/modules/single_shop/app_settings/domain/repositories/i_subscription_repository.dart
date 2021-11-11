import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/add_new_subscription_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/store_credentials_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_item_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/data/remote/models/subscription_package_model.dart';

abstract class ISubscriptionRepository {
  Future<AddNewSubscriptionResponseModel> addSubscriptionPayment({
    int shopId,
    int duration,
    double amountPaid,
    String package,
    int subscriptionPackageId,
    int campaignId,
  });

  Future<List<Subscription>> getAllSubscription({int shopId});

  Future<List<SubscriptionPackageResponseModel>> getAllSubscriptionPackages(
      {int shopId, String package});

  Future<StoreCredentialsResponseModel> getStoreCredential({int shopId});

  Future<List<SubscriptionItem>> getAllSubscriptionItem(int shopId);
}
