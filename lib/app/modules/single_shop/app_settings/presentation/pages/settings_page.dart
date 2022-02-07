import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/dialog.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_background.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/page_header.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_bindings/shop_main_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/pages/select_shop_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_bindings/app_settings_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/_navigation/settings_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/manager/settings_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/pages/set_qr_code_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/pages/subscription_page.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/app_settings/presentation/pages/training_video_page.dart';

import 'contact_us_page.dart';

class SettingsPage extends GetResponsiveView<SettingsController> {
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
              Column(
                children: [
                  buildPageHeader('setting'.tr, controller.shop.value.name),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(1, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              InkWell(
                                onTap: () {
                                  _showMaterialDialog(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8, bottom: 5),
                                      child: Text(
                                        'language'.tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: Text(
                                        "language_type".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    SetQRCodePage(),
                                    arguments: {
                                      "shop": controller.shop.value,
                                      "type": "set"
                                    },
                                    binding: AppSettingsBinding(),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8, bottom: 5),
                                      child: Text(
                                        "set_qr_code".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20,
                                        color: DEFAULT_BLACK.withOpacity(0.7),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    TrainingVideoPage(),
                                    binding: AppSettingsBinding(),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8, bottom: 5),
                                      child: Text(
                                        "training_video".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 20,
                                          color:
                                              DEFAULT_BLACK.withOpacity(0.7)),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    SelectShopPage(),
                                    binding: ShopMainBinding(),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8, bottom: 5),
                                      child: Text(
                                        "switch_shop".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 20,
                                          color:
                                              DEFAULT_BLACK.withOpacity(0.7)),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SubscriptionPage(
                                            shop: controller.shop.value,
                                          )));
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8, bottom: 5),
                                      child: Text(
                                        "payment".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 20,
                                          color:
                                              DEFAULT_BLACK.withOpacity(0.7)),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller.cred.value.user.nidVerified ==
                                      0) {
                                    CustomDialog.showNidVerigyDialog();
                                  } else {
                                    Get.toNamed(
                                      SettingsRoutes.WITHDRAW_REQUEST,
                                      arguments: {
                                        "shop": controller.shop.value
                                      },
                                    );
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8, bottom: 5),
                                      child: Text(
                                        "withdraw_request".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 20,
                                          color:
                                              DEFAULT_BLACK.withOpacity(0.7)),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  Get.to(
                                    ContactUsPage(),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, top: 8, bottom: 8),
                                      child: Text(
                                        "contact_us".tr,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: DEFAULT_BLACK,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 20,
                                          color:
                                              DEFAULT_BLACK.withOpacity(0.7)),
                                    )
                                  ],
                                ),
                              ),
                              // Divider(
                              //   color: Colors.black,
                              //   thickness: 1,
                              // ),
                              // InkWell(
                              //   onTap: () {
                              //     Get.isDarkMode
                              //         ? Get.changeTheme(ThemeData.light())
                              //         : Get.changeTheme(ThemeData.dark());
                              //   },
                              //   child: Row(
                              //     mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Padding(
                              //         padding: const EdgeInsets.only(
                              //             left: 12.0, top: 8, bottom: 8),
                              //         child: Text(
                              //           "Dark Mode",
                              //           style: TextStyle(
                              //             fontSize: 16,
                              //             fontWeight: FontWeight.normal,
                              //             color: DEFAULT_BLACK,
                              //           ),
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding:
                              //         const EdgeInsets.only(right: 18.0),
                              //         child: Icon(Icons.arrow_forward_ios,
                              //             size: 20,
                              //             color:
                              //             DEFAULT_BLACK.withOpacity(0.7)),
                              //       )
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 18.0, right: 15, left: 15),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffF44336), // background
                          // foreground
                        ),
                        onPressed: () async {
                          await controller.logout();
                        },
                        child: Text(
                          'sign_out'.tr,
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
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
      ),
    );
  }

  void _showMaterialDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    try {
      if (Platform.isIOS) {
        showDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            content: Container(
              height: size.height * 0.08,
              width: size.width * 0.8,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.changeLanguageToEnglish();
                      navigator.pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        height: size.height * 0.06 / 2,
                        child: Text(
                          "English",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.5,
                    color: Colors.grey,
                    thickness: 0.4,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller.changeLanguageToBangla();
                      navigator.pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height: size.height * 0.06 / 2,
                        child: Text(
                          "বাংলা",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Container(
              height: size.height * 0.08,
              width: size.width * 0.8,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.changeLanguageToEnglish();
                      navigator.pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        height: size.height * 0.06 / 2,
                        child: Text(
                          "English",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1.5,
                    color: Colors.grey,
                    thickness: 0.4,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller.changeLanguageToBangla();
                      navigator.pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        height: size.height * 0.06 / 2,
                        child: Text(
                          "বাংলা",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: DEFAULT_BLACK,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    } catch (e) {}
  }
}
