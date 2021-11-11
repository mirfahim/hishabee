import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/_bindings/store_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/chat_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/pages/chatting_page.dart';

class ChatUserPage extends GetView<ChatUserController> {
  const ChatUserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: DEFAULT_BLACK,
          ),
          elevation: 7,
          title: Text(
            "online_message".tr,
            style: TextStyle(
                color: DEFAULT_BLACK,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.conversationList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final conversation = controller.conversationList[index];

                    print(
                        " sender Id${conversation.senderId} - ${conversation.senderId.runtimeType}");
                    return InkWell(
                      onTap: () {
                        Get.to(() => ChattingPage(),
                            binding: StoreBinding(),
                            arguments: {"conversation": conversation});
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5.0, bottom: 5, left: 10),
                                        child: Text(
                                          "${conversation.name}",
                                          style: TextStyle(
                                            fontFamily: 'Rubik',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0, bottom: 5, left: 10),
                                          child: Container(
                                            child: Row(
                                              children: [
                                                conversation.lastMessage
                                                            .userId !=
                                                        conversation.senderId
                                                    ? Container(
                                                        height: 20,
                                                        width: 20,
                                                        child: SvgPicture.asset(
                                                          "images/svg_image/replay.svg",
                                                          color: DEFAULT_BLACK
                                                              .withOpacity(0.5),
                                                        ),
                                                      )
                                                    : Container(),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: size.width * 0.5,
                                                  child: Text(
                                                    "${conversation.lastMessage.message}",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontFamily: 'Rubik',
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK
                                                          .withOpacity(0.5),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Text(
                                      "${conversation.lastMessage.createdAt}",
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: DEFAULT_BLACK,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: DEFAULT_BLACK.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
