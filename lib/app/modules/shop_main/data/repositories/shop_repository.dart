import 'package:hishabee_business_manager_fl/app/_core/network/network_info.dart';
import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/local/data_sources/local_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/data_sources/shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/check_shop_subscription_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/create_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/edit_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_shop_all_type_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/domain/repositories/i_shop_repository.dart';

class ShopRepository implements IShopRepository {
  final ISHopProvider provider;
  final ILocalShopProvider localShopProvider;
  final INetworkInfo networkInfo;

  ShopRepository(this.provider, this.localShopProvider, this.networkInfo);

  @override
  Future<List<Shop>> getAllShop() async {
    final response = await provider.getAllShop();
    return ResponseDecoder.decode(response);
  }

  @override
  Future<CreateShopResponseModel> createShop(
      {String name,
      var typeId,
      var areaId,
      String address,
      String referralCode,
      String logoUrl}) async {
    final response = await provider.addShop(
        name: name,
        typeId: typeId,
        areaId: areaId,
        address: address,
        logoUrl: logoUrl);
    return ResponseDecoder.decode(response);
  }

  @override
  Future<dynamic> editShop({
    var shopId,
    String name,
    var typeId,
    String address,
    int id,
    num lat,
    num lng,
    var shopNumber,
    var floorNumber,
    var vatPercent,
    var areaId,
    String logoUrl,
    String publicNumber,
    String referralCode,
  }) async {
    final response = await provider.editShop(
      shopId: shopId,
      name: name,
      typeId: typeId,
      address: address,
      id: id,
      lat: lat,
      lng: lng,
      shopNumber: shopNumber,
      floorNumber: floorNumber,
      vatPercent: vatPercent,
      areaId: areaId,
      logoUrl: logoUrl,
      publicNumber: publicNumber,
      referralCode: referralCode,
    );
    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<ShopType>> getAllShopType() async {
    if (await networkInfo.isConnected()) {
      final response = await provider.getAllShopType();
      if (response.hasError) {
        return Future.error(response.statusText);
      }
      localShopProvider.saveAllShopType(response.body);
      return response.body;
    } else {
      try {
        final shopTypes = await localShopProvider.getAllShopType();
        return shopTypes;
      } catch (e) {
        return Future.error(e);
      }
    }
  }

  @override
  Future<void> clearCurrentShop() async {
    return await localShopProvider.clearCurrentShop();
  }

  @override
  Future<Shop> getCurrentShop() async {
    try {
      final result = await localShopProvider.getCurrentShop();

      return result;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> saveCurrentShop(Shop shop) async {
    return await localShopProvider.saveCurrentShop([shop]);
  }

  @override
  Future<CheckShopSubscriptionResponseModel> checkShopSubscription(
      {int shopId}) async {
    final response = await provider.checkShopSubscription(shopId: shopId);

    if (response.hasError) {
      return Future.error(response.statusText);
    }
    return ResponseDecoder.decode(response);
  }

  @override
  Future<DateTime> getCampaignDate() {
    return localShopProvider.getCampaignDate();
  }

  @override
  Future<void> setCampaignDate() {
    return localShopProvider.setCampaignDate();
  }
}
