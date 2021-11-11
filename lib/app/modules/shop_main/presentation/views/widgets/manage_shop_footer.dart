import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class ManageShopFooter extends StatelessWidget {
  ManageShopFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DEFAULT_BODY_BG_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Center(
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'go_back'.tr,
                    style: TextStyle(
                      color: DEFAULT_BLUE,
                      fontFamily: 'Rubik',
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
