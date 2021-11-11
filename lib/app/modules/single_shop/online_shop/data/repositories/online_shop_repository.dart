import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/_utils/response_decoder.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/local/data_sources/local_online_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/data_sources/online_shop_provider.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/add_message_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/conversation_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/message_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_order_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_order_update_status_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_shop_info_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';

class OnlineShopRepository implements IOnlineShopRepository {
  final IOnlineShopProvider _onlineShopProvider;
  final ILocalOnlineShopProvider _localOnlineShopProvider;

  OnlineShopRepository(this._onlineShopProvider, this._localOnlineShopProvider);

  @override
  Future<AddMessageResponseModel> addMessage(
      int conversationId, String message) async {
    final response =
        await _onlineShopProvider.addMessage(conversationId, message);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<OnlineOrder>> getAllActiveOrder(int shopId) async {
    final response = await _onlineShopProvider.getAllActiveOrder(shopId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<OnlineOrder>> getAllCompletedOrder(int shopId) async {
    final response = await _onlineShopProvider.getAllCompletedOrder(shopId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<Conversation>> getAllConversation(int shopId) async {
    final response = await _onlineShopProvider.getAllConversation(shopId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<Message> getAllMessage(int conversationId) async {
    final response = await _onlineShopProvider.getAllMessage(conversationId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<OnlineOrder>> getAllNewOrder(int shopId) async {
    final response = await _onlineShopProvider.getAllNewOrder(shopId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<List<String>> getAllSampleBanner() async {
    final response = await _onlineShopProvider.getAllSampleBanner();

    return ResponseDecoder.decode(response);
  }

  @override
  Future<OnlineShopInfoResponseModel> getOnlineShopInfo(int shopId) async {
    final response = await _onlineShopProvider.getOnlineShopInfo(shopId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<OnlineOrder> getOrderDetails(int orderId) async {
    final response = await _onlineShopProvider.getOrderDetails(orderId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<OnlineShopInfoResponseModel> onlineShopPublishToggle(
      int shopId) async {
    final response = await _onlineShopProvider.onlineShopPublishToggle(shopId);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<OnlineShopInfoResponseModel> onlineShopUpdateBanner(
      int shopId, List<String> urls) async {
    final response =
        await _onlineShopProvider.onlineShopUpdateBanner(shopId, urls);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<OnlineShopInfoResponseModel> onlineShopUpdateLogo(
      int shopId, String url) async {
    final response =
        await _onlineShopProvider.onlineShopUpdateLogo(shopId, url);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<OnlineOrderUpdateResponseModel> onlineShopUpdateOrderStatus(
      int shopId, int orderId, String deliveryStatus) async {
    final response = await _onlineShopProvider.onlineShopUpdateOrderStatus(
        shopId, orderId, deliveryStatus);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<GenericResponseModel> onlineShopUpdateProducts(
      int shopId, List<Product> products) async {
    final response =
        await _onlineShopProvider.onlineShopUpdateProducts(shopId, products);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<OnlineShopInfoResponseModel> onlineShopUpdateSlug(
      int shopId, String slug) async {
    final response =
        await _onlineShopProvider.onlineShopUpdateSlug(shopId, slug);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<OnlineShopInfoResponseModel> onlineShopUpdateSocials(int shopId,
      {String fb, String ig, String yt}) async {
    final response = await _onlineShopProvider.onlineShopUpdateSocials(shopId,
        fb: fb, ig: ig, yt: yt);

    return ResponseDecoder.decode(response);
  }

  @override
  Future<void> addDeliveryCompanyUrl(int shopId, String value) {
    return _localOnlineShopProvider.addDeliveryCompanyUrl(shopId, value);
  }

  @override
  Future<List<String>> getDeliveryCompanyUrls(int shopId) {
    return _localOnlineShopProvider.getDeliveryCompanyUrls(shopId);
  }
}
