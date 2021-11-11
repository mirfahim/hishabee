import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_shop_all_type_response_model.dart';
import 'package:hive/hive.dart';

abstract class ILocalShopProvider {
  Future<List<ShopType>> getAllShopType();

  Future<void> saveAllShopType(List<ShopType> shopTypes);

  Future<Shop> getCurrentShop();

  Future<void> saveCurrentShop(List<Shop> shops);

  Future<void> clearCurrentShop();

  Future<DateTime> getCampaignDate();

  Future<void> setCampaignDate();
}

class LocalShopProvider implements ILocalShopProvider {
  static final boxKey = 'shopBox';
  final shopTypesKey = 'shopTypes';
  final currentShopKey = 'currentShop';
  final campaignDateKey = 'campaignDate';

  @override
  Future<List<ShopType>> getAllShopType() async {
    final shopBox = await Hive.openBox(boxKey);

    final shopTypes = shopBox.get(shopTypesKey);

    if (shopTypes != null) {
      return shopTypeFromJson(shopTypes);
    } else {
      return Future.error("Catch error");
    }
  }

  @override
  Future<void> saveAllShopType(List<ShopType> shopTypes) async {
    final shopBox = await Hive.openBox(boxKey);

    return await shopBox.put(shopTypesKey, shopTypeToJson(shopTypes));
  }

  @override
  Future<void> clearCurrentShop() async {
    final shopBox = await Hive.openBox(boxKey);

    return shopBox.delete(currentShopKey);
  }

  @override
  Future<Shop> getCurrentShop() async {
    final shopBox = await Hive.openBox(boxKey);
    final currentShop = shopBox.get(currentShopKey);

    if (currentShop != null) {
      final shops = shopsFromJson(currentShop);
      return shops.first;
    } else {
      return Future.error("Catch error");
    }
  }

  @override
  Future<void> saveCurrentShop(List<Shop> shops) async {
    final shopBox = await Hive.openBox(boxKey);

    return await shopBox.put(currentShopKey, shopsToJson(shops));
  }

  @override
  Future<DateTime> getCampaignDate() async {
    final shopBox = await Hive.openBox(boxKey);
    final campaignDate = shopBox.get(campaignDateKey);

    if (campaignDate != null) {
      return DateTime.parse(campaignDate);
    } else {
      return null;
    }
  }

  @override
  Future<void> setCampaignDate() async {
    final shopBox = await Hive.openBox(boxKey);

    final now = DateTime.now();

    final nowStr = Utility.dateFormat.format(now);

    return await shopBox.put(campaignDateKey, nowStr);
  }
}
