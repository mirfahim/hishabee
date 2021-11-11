import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/store_setting_controller.dart';

class OnlineShopSocialMediaLinkPage
    extends GetView<OnlineStoreSettingController> {
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
                      "Update Social Media Links",
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 15, right: 10, left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Facebook",
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK.withOpacity(0.7),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 10),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.indigo,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  FontAwesomeIcons.facebookF,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: size.width * 0.7,
                                              child: Obx(
                                                () => TextFormField(
                                                  cursorColor: DEFAULT_BLACK,
                                                  onChanged: (val) {
                                                    controller.fb.value = val;
                                                  },
                                                  decoration: InputDecoration(
                                                    focusColor: DEFAULT_BLACK,
                                                    hoverColor: DEFAULT_BLACK,
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    hintText:
                                                        "${controller.onlineShopInfoResponse.value.shop.facebook ?? ""}",
                                                    hintStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "Instagram",
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK.withOpacity(0.7),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 10),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  FontAwesomeIcons.instagram,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: size.width * 0.7,
                                              child: Obx(
                                                () => TextFormField(
                                                  cursorColor: DEFAULT_BLACK,
                                                  onChanged: (val) {
                                                    controller.ig.value = val;
                                                  },
                                                  decoration: InputDecoration(
                                                    focusColor: DEFAULT_BLACK,
                                                    hoverColor: DEFAULT_BLACK,
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    hintText:
                                                        "${controller.onlineShopInfoResponse.value.shop.instagram ?? ""}",
                                                    hintStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        "Youtube",
                                        style: TextStyle(
                                          fontFamily: 'Rubik',
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: DEFAULT_BLACK.withOpacity(0.7),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, bottom: 10),
                                            child: Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  FontAwesomeIcons.youtube,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: size.width * 0.7,
                                              child: Obx(
                                                () => TextFormField(
                                                  cursorColor: DEFAULT_BLACK,
                                                  onSaved: (val) {
                                                    controller.yt.value = val;
                                                  },
                                                  decoration: InputDecoration(
                                                    focusColor: DEFAULT_BLACK,
                                                    hoverColor: DEFAULT_BLACK,
                                                    contentPadding:
                                                        EdgeInsets.all(10),
                                                    hintText:
                                                        "${controller.onlineShopInfoResponse.value.shop.youtube ?? ""}",
                                                    hintStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'Rubik',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: DEFAULT_BLACK,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
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

                                          await controller
                                              .updateSocialMediaLinks();
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
