import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class EditShopHeader extends GetResponsiveView {
  EditShopHeader();

  @override
  Widget builder() {
    return Container(
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: DEFAULT_BLACK,
                    size: 25,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              'edit_shop'.tr,
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
