import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/chatting_page_controller.dart';

class ChattingPage extends GetView<ChattingPageController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        elevation: 7,
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${controller.conversation.value.name}",
                style: TextStyle(
                    color: DEFAULT_BLACK,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${controller.conversation.value.number}",
                style: TextStyle(
                    color: DEFAULT_BLACK,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case 0:
                      Utility.launchURL(
                          "tel:${controller.conversation.value.number}");
                      break;
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                          value: 0,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.call,
                                color: DEFAULT_BLACK,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Call",
                                style: TextStyle(
                                    color: DEFAULT_BLACK,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),
                    ],
                child: Icon(
                  Icons.more_vert,
                  size: 30,
                  color: DEFAULT_BLACK,
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 48),
              child: Container(
                child: Obx(
                  () => controller.message.value.data == null
                      ? Container()
                      : ListView.builder(
                          reverse: true,
                          itemCount: controller.message.value.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = controller.message.value.data[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 20.0, top: 10, left: 10, right: 10),
                              child: Column(
                                  crossAxisAlignment: data.userId == null
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: data.userId == null
                                            ? Colors.white
                                            : DEFAULT_BLACK,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "${data.message}",
                                          style: TextStyle(
                                              color: data.userId == null
                                                  ? DEFAULT_BLACK
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("${data.createdAt}")
                                  ]),
                            );
                          }),
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width * 0.7,
                          child: Form(
                            key: controller.formKey,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                cursorColor: DEFAULT_BLACK,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                    hintText: "write_message".tr),
                                onSaved: (value) {
                                  controller.newMessage.value = value;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () async {
                                await controller.addMessage();
                              },
                              icon: Icon(
                                Icons.send_rounded,
                                color: DEFAULT_BLACK.withOpacity(0.7),
                                size: 30,
                              )))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
