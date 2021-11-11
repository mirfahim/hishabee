import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_widgets/default_button.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_navigation/shop_main_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/select_shop_controller.dart';

class SelectShopFooter extends GetResponsiveView<SelectShopController> {
  SelectShopFooter({
    @required this.screen,
  });

  final ResponsiveScreen screen;

  @override
  Widget builder() {
    return Container(
      width: screen.context.width,
      color: DEFAULT_BODY_BG_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultButton(
                screen: screen,
                text: "create_shop".tr,
                buttonColor: DEFAULT_BLACK,
                onPressed: () {
                  Get.toNamed(ShopMainRoutes.CREATE_SHOP);
                }),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.toNamed(ShopMainRoutes.MANAGE_SHOP,
                      arguments: {"user": controller.user.value});
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'manage_shops'.tr,
                    style: TextStyle(
                      color: DEFAULT_BLUE,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
