import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/add_message_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/conversation_response_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/data/remote/models/message_model.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/domain/repositories/i_online_shop_repository.dart';

class ChattingPageController extends GetxController {
  final IOnlineShopRepository _onlineShopRepository;

  ChattingPageController(this._onlineShopRepository);

  final formKey = GlobalKey<FormState>();

  final conversation = Conversation().obs;
  final message = Message().obs;
  final addMessageResponse = AddMessageResponseModel().obs;
  final newMessage = Rxn<String>();

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  @override
  void onReady() async {
    await getAllMessage(conversation.value.id);
    super.onReady();
  }

  getArguments() {
    conversation.value = Get.arguments["conversation"];
  }

  getAllMessage(int conversationId) async {
    final response = await _onlineShopRepository.getAllMessage(conversationId);

    message.value = response;
  }

  addMessage() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      if (newMessage.value != null && newMessage.value != "") {
        final response = await _onlineShopRepository.addMessage(
            conversation.value.id, newMessage.value);
        addMessageResponse.value = response;
        formKey.currentState.reset();
        await getAllMessage(conversation.value.id);
      }
    }
  }
}
