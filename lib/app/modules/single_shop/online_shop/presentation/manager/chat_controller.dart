import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/data_holder.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/conversation_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';

class ChatUserController extends GetxController {
  final IOnlineShopRepository _onlineShopRepository;

  ChatUserController(this._onlineShopRepository);

  final conversationList = <Conversation>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  onReady() async {
    await initData();
    super.onReady();
  }

  initData() async {
    await getAllConversation();
  }

  getAllConversation() async {
    final response =
        await _onlineShopRepository.getAllConversation(DataHolder.shopId);

    conversationList.assignAll(response);
  }
}
