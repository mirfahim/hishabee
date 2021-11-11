import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/select_shop_controller.dart';

class SelectShopHeader extends GetResponsiveView<SelectShopController> {
  SelectShopHeader();

  @override
  Widget builder() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 40, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Text(
              "Hi, ${controller.user.value.name}",
              style: TextStyle(
                fontSize: 16,
                color: DEFAULT_BLACK,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "select_shop".tr,
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
