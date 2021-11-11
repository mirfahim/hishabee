import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/strings.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/domain/repositories/i_auth_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/add_message_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/conversation_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/message_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_order_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_order_update_status_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_shop_info_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';

// To parse this JSON data, do
//
//     final sampleBannerResponseModel = sampleBannerResponseModelFromJson(jsonString);

import 'dart:convert';

List<String> sampleBannerResponseModelFromRawJson(dynamic json) =>
    List<String>.from((json as List<dynamic>).map((x) => x));

abstract class IOnlineShopProvider {
  Future<Response<List<OnlineOrder>>> getAllNewOrder(int shopId);

  Future<Response<List<OnlineOrder>>> getAllActiveOrder(int shopId);

  Future<Response<List<OnlineOrder>>> getAllCompletedOrder(int shopId);

  Future<Response<List<Conversation>>> getAllConversation(int shopId);

  Future<Response<Message>> getAllMessage(int conversationId);

  Future<Response<OnlineShopInfoResponseModel>> getOnlineShopInfo(int shopId);

  Future<Response<OnlineShopInfoResponseModel>> onlineShopPublishToggle(
      int shopId);

  Future<Response<OnlineShopInfoResponseModel>> onlineShopUpdateLogo(
      int shopId, String url);

  Future<Response<OnlineShopInfoResponseModel>> onlineShopUpdateSlug(
      int shopId, String slug);

  Future<Response<OnlineShopInfoResponseModel>> onlineShopUpdateBanner(
      int shopId, List<String> urls);

  Future<Response<OnlineShopInfoResponseModel>> onlineShopUpdateSocials(
      int shopId,
      {String fb,
      String ig,
      String yt});

  Future<Response<GenericResponseModel>> onlineShopUpdateProducts(
      int shopId, List<Product> products);

  Future<Response<OnlineOrderUpdateResponseModel>> onlineShopUpdateOrderStatus(
      int shopId, int orderId, String deliveryStatus);

  Future<Response<List<String>>> getAllSampleBanner();

  Future<Response<OnlineOrder>> getOrderDetails(int orderId);

  Future<Response<AddMessageResponseModel>> addMessage(
      int conversationId, String message);
}

class OnlineShopProvider extends GetConnect implements IOnlineShopProvider {
  final IAuthRepository _authRepository;

  OnlineShopProvider(this._authRepository);
  // @override
  // void onInit() {
  //   httpClient.baseUrl = "https://dev.hishabee.business/api/V2";
  //   super.onInit();
  // }

  @override
  Future<Response<AddMessageResponseModel>> addMessage(
      int conversationId, String message) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return post(
        "$BASE_URL_2/message/add?conversation_id=$conversationId&message=$message",
        {},
        headers: headers,
        decoder: addMessageResponseModelFromMap);
  }

  @override
  Future<Response<List<OnlineOrder>>> getAllActiveOrder(int shopId) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      "$BASE_URL_2/online-shop/orders/active?shop_id=$shopId",
      headers: headers,
      decoder: onlineOrdersFromRawJson,
    );
  }

  @override
  Future<Response<List<OnlineOrder>>> getAllCompletedOrder(int shopId) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      "$BASE_URL_2/online-shop/orders/complete?shop_id=$shopId",
      headers: headers,
      decoder: onlineOrdersFromRawJson,
    );
  }

  @override
  Future<Response<List<Conversation>>> getAllConversation(int shopId) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      "$BASE_URL_2/conversation/all?shop_id=$shopId",
      headers: headers,
      decoder: conversationResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<Message>> getAllMessage(int conversationId) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      "$BASE_URL_2/message/all?conversation_id=$conversationId",
      headers: headers,
      decoder: messageFromRawJson,
    );
  }

  @override
  Future<Response<List<OnlineOrder>>> getAllNewOrder(int shopId) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      "$BASE_URL_2/online-shop/orders/new?shop_id=$shopId",
      headers: headers,
      decoder: onlineOrdersFromRawJson,
    );
  }

  @override
  Future<Response<List<String>>> getAllSampleBanner() async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      "$BASE_URL_2/online-shop/sample-banners",
      headers: headers,
      decoder: sampleBannerResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<OnlineShopInfoResponseModel>> getOnlineShopInfo(
      int shopId) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get(
      "$BASE_URL_2/online-shop?shop_id=$shopId",
      headers: headers,
      decoder: onlineShopInfoResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<OnlineOrder>> getOrderDetails(int orderId) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return get("$BASE_URL_2/online-shop/orders/details?order_id=$orderId",
        headers: headers, decoder: onlineOrderFromMap);
  }

  @override
  Future<Response<OnlineShopInfoResponseModel>> onlineShopPublishToggle(
      int shopId) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return post(
      "$BASE_URL_2/online-shop/publish?shop_id=$shopId",
      {},
      headers: headers,
      decoder: onlineShopInfoResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<OnlineShopInfoResponseModel>> onlineShopUpdateBanner(
      int shopId, List<String> urls) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return post(
      "$BASE_URL_2/online-shop/banner?shop_id=$shopId&url=$urls",
      {},
      headers: headers,
      decoder: onlineShopInfoResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<OnlineShopInfoResponseModel>> onlineShopUpdateLogo(
      int shopId, String url) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return post(
      "$BASE_URL_2/online-shop/logo?shop_id=$shopId&url=$url",
      {},
      headers: headers,
      decoder: onlineShopInfoResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<OnlineOrderUpdateResponseModel>> onlineShopUpdateOrderStatus(
      int shopId, int orderId, String deliveryStatus) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return post(
      "$BASE_URL_2/online-shop/orders/update?shop_id=$shopId&order_id=$orderId&delivery_status=$deliveryStatus",
      {},
      headers: headers,
      decoder: onlineOrderUpdateResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<GenericResponseModel>> onlineShopUpdateProducts(
      int shopId, List<Product> products) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return post(
      "$BASE_URL_2/online-shop/products?shop_id=$shopId",
      {"products": productResponseModelToJson(products)},
      headers: headers,
      decoder: genericResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<OnlineShopInfoResponseModel>> onlineShopUpdateSlug(
      int shopId, String slug) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return post(
      "$BASE_URL_2/online-shop/slug?shop_id=$shopId&slug=$slug",
      {},
      headers: headers,
      decoder: onlineShopInfoResponseModelFromRawJson,
    );
  }

  @override
  Future<Response<OnlineShopInfoResponseModel>> onlineShopUpdateSocials(
    int shopId, {
    String fb,
    String ig,
    String yt,
  }) async {
    final creds = await _authRepository.getCredentials();

    final headers = {'Authorization': 'Bearer ${creds.accessToken}'};

    return post(
      "$BASE_URL_2/online-shop/socials?shop_id=$shopId&fb=$fb&ig=$ig&yt=$yt",
      {},
      headers: headers,
      decoder: onlineShopInfoResponseModelFromRawJson,
    );
  }
}
