import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/check_shop_subscription_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/create_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/edit_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_shop_all_type_response_model.dart';

abstract class IShopRepository {
  Future<List<Shop>> getAllShop();

  Future<CreateShopResponseModel> createShop({
    String name,
    int typeId,
    int areaId,
    String address,
    String referralCode,
    String logoUrl,
  });

  Future<dynamic> editShop({
    int shopId,
    String name,
    int typeId,
    String address,
    int id,
    num lat,
    num lng,
    int shopNumber,
    int floorNumber,
    int vatPercent,
    int areaId,
    String logoUrl,
    String publicNumber,
    String referralCode,
  });

  Future<List<ShopType>> getAllShopType();

  Future<CheckShopSubscriptionResponseModel> checkShopSubscription(
      {int shopId});

  Future<Shop> getCurrentShop();

  Future<void> saveCurrentShop(Shop shop);

  Future<void> clearCurrentShop();

  Future<DateTime> getCampaignDate();

  Future<void> setCampaignDate();
}
