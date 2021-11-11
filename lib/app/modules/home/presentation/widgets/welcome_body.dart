import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/default_button.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_navigation/auth_routes.dart';

class WelcomeBody extends GetResponsiveView {
  @override
  Widget builder() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 11, right: 11),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "new_to_hishabee_family".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: screen.responsiveValue(mobile: 14, tablet: 20),
                color: DEFAULT_BLACK,
              ),
            ),
          ),
          DefaultButton(
            screen: screen,
            text: "register".tr,
            buttonColor: DEFAULT_YELLOW_BG,
            onPressed: () {
              Get.toNamed(AuthRoutes.REGISTER);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "or_p".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: screen.responsiveValue(mobile: 14, tablet: 20),
                color: DEFAULT_BLACK,
              ),
            ),
          ),
          Text(
            "if_you_already_have_an_account_p".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: screen.responsiveValue(mobile: 14, tablet: 20),
              color: Colors.black,
            ),
          ),
          DefaultButton(
            screen: screen,
            text: "login".tr,
            buttonColor: DEFAULT_BLACK,
            onPressed: () {
              Get.toNamed(AuthRoutes.LOGIN);
            },
          ),
        ],
      ),
    );
  }
}
