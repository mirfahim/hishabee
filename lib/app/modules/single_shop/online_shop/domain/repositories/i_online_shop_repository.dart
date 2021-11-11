import 'package:hishabee_business_manager_fl/app/_core/models/generic_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/add_message_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/conversation_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/message_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_order_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_order_update_status_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/online_shop_info_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/product_list/data/remote/models/product_response_model.dart';

abstract class IOnlineShopRepository {
  Future<List<OnlineOrder>> getAllNewOrder(int shopId);

  Future<List<OnlineOrder>> getAllActiveOrder(int shopId);

  Future<List<OnlineOrder>> getAllCompletedOrder(int shopId);

  Future<List<Conversation>> getAllConversation(int shopId);

  Future<Message> getAllMessage(int conversationId);

  Future<OnlineShopInfoResponseModel> getOnlineShopInfo(int shopId);

  Future<OnlineShopInfoResponseModel> onlineShopPublishToggle(int shopId);

  Future<OnlineShopInfoResponseModel> onlineShopUpdateLogo(
      int shopId, String url);

  Future<OnlineShopInfoResponseModel> onlineShopUpdateSlug(
      int shopId, String slug);

  Future<OnlineShopInfoResponseModel> onlineShopUpdateBanner(
      int shopId, List<String> urls);

  Future<OnlineShopInfoResponseModel> onlineShopUpdateSocials(int shopId,
      {String fb, String ig, String yt});

  Future<GenericResponseModel> onlineShopUpdateProducts(
      int shopId, List<Product> products);

  Future<OnlineOrderUpdateResponseModel> onlineShopUpdateOrderStatus(
      int shopId, int orderId, String deliveryStatus);

  Future<List<String>> getAllSampleBanner();

  Future<OnlineOrder> getOrderDetails(int orderId);

  Future<AddMessageResponseModel> addMessage(
      int conversationId, String message);

  Future<void> addDeliveryCompanyUrl(int shopId, String value);

  Future<List<String>> getDeliveryCompanyUrls(int shopId);
}
