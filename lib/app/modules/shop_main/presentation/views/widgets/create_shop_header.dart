import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class CreateShopHeader extends GetResponsiveView {
  CreateShopHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    size: 25,
                    color: DEFAULT_BLACK,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Text(
                    "welcome".tr,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'create_shop'.tr,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 22,
                color: DEFAULT_BLUE,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
