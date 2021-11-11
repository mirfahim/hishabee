import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/store_setting_controller.dart';

class OnlineShopLinkPage extends GetView<OnlineStoreSettingController> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: DEFAULT_BODY_BG_COLOR,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: size.height * 0.2,
                width: size.width,
                child: Image.asset(
                  "images/topBg.png",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        size: 25,
                        color: DEFAULT_BLACK,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Online Shop Link",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: DEFAULT_BLACK,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 20.0, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Change your shop url",
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: DEFAULT_BLACK,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                      child: Container(
                        height: 150,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "htps://hishabee.market/shop/",
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: DEFAULT_BLACK.withOpacity(0.6),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: Colors.grey, width: 1),
                                        color: Colors.white),
                                    child: Obx(
                                      () => TextFormField(
                                        cursorColor: DEFAULT_BLACK,
                                        onSaved: (val) {
                                          controller.storeLink.value = val;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintText:
                                              '${controller.onlineShopInfoResponse.value.shop.slug}',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Rubik',
                                            fontWeight: FontWeight.bold,
                                            color: DEFAULT_BLACK,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 25.0,
                                  right: 10,
                                  left: 10,
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.black,
                                      onPrimary: DEFAULT_BLUE,
                                    ),
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        formKey.currentState.save();

                                        await controller.updateStoreLink();
                                      }
                                    },
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Rubik',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
