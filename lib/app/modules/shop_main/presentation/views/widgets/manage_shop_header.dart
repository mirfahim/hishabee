import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/manage_shop_controller.dart';

class ManageShopHeader extends GetResponsiveView<ManageShopController> {
  ManageShopHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 40, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Hi ${controller.user.value.name ?? "User"}",
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 16,
              color: DEFAULT_BLACK,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "edit_shop".tr,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              color: DEFAULT_BLUE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
