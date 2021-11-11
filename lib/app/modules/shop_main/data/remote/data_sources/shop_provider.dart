import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/check_shop_subscription_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/create_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/edit_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_all_shop_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/data/remote/models/get_shop_all_type_response_model.dart';

abstract class ISHopProvider {
  Future<Response<List<ShopType>>> getAllShopType();

  Future<Response<List<Shop>>> getAllShop();

  Future<Response<CreateShopResponseModel>> addShop({
    String name,
    int typeId,
    int areaId,
    String address,
    String referralCode,
    String logoUrl,
  });

  Future<Response<EditShopResponseModel>> editShop({
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

  Future<Response<CheckShopSubscriptionResponseModel>> checkShopSubscription(
      {int shopId});
}

class ShopProvider extends GetConnect implements ISHopProvider {
  final IAuthRepository authRepository;

  ShopProvider(this.authRepository);

  @override
  Future<Response<List<Shop>>> getAllShop() async {
    String url = "$BASE_URL/shop/all";

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      url,
      headers: headers,
      decoder: shopsFromRawJson,
    );
  }

  @override
  Future<Response<CreateShopResponseModel>> addShop({
    String name,
    int typeId,
    int areaId,
    String address,
    String referralCode,
    String logoUrl,
  }) async {
    String url = '$BASE_URL/shop/create';

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};
    final body = {
      'name': name,
      'address': address,
      'area': areaId,
      'type': typeId,
      'logo_url': logoUrl,
    };

    return post(
      url,
      body,
      headers: headers,
      decoder: createShopResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<EditShopResponseModel>> editShop({
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
  }) async {
    String url = '$BASE_URL/shop/edit';

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    final body = {
      'shop_id': shopId,
      'name': name,
      'type': typeId,
      'address': address,
      'id': id,
      'lat': lat,
      'lng': lng,
      'shop_number': shopNumber,
      'floor_number': floorNumber,
      'vat_percent': vatPercent,
      'area': areaId,
      'logo_url': logoUrl,
      'public_number': publicNumber,
      'referral_code': referralCode,
    };

    return put(
      url,
      body,
      headers: headers,
      decoder: editShopResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<List<ShopType>>> getAllShopType() async {
    String url = '$BASE_URL/shop/types';

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      url,
      headers: headers,
      decoder: shopTypeFromRawJson,
    );
  }

  @override
  Future<Response<CheckShopSubscriptionResponseModel>> checkShopSubscription(
      {int shopId}) async {
    String url = '$BASE_URL/subscription/verify?shop_id=$shopId';

    final creds = await authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      url,
      headers: headers,
      decoder: checkShopSubscriptionFromRawJson,
    );
  }
}
