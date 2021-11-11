import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_bindings/shop_main_binding.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/pages/create_shop_page.dart';

class FreeTrialDialog {
  static void freeTrialDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) => KeyboardAwareDialog(
              child: Container(
                height: size.height * 0.85,
                width: size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "welcome".tr,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_BLACK),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            child: Image.asset(
                              "images/bee.png",
                              fit: BoxFit.fill,
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: RichText(
                            text: TextSpan(
                              children: const <TextSpan>[
                                TextSpan(
                                    text: 'HISHA',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_BLACK,
                                        fontSize: 35)),
                                TextSpan(
                                    text: 'BEE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: DEFAULT_YELLOW_BG,
                                        fontSize: 35)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "family_welcomes_you".tr,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: DEFAULT_BLACK),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "create_your_first_shop_and_get".tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: DEFAULT_BLACK),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "as_an_welcome_gift".tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: DEFAULT_BLACK),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "14day_free".tr,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: DEFAULT_YELLOW_BG),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "free_subscription".tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: DEFAULT_BLACK),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "create_shop_for_claim_the_gift".tr,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: DEFAULT_BLACK),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          Get.to(() => CreateShopPage(),
                              binding: ShopMainBinding());
                        },
                        child: Container(
                          height: 40,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: DEFAULT_BLACK,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                "create_shop".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
