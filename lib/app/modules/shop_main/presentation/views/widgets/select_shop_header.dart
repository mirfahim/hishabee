import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/_navigation/shop_main_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/select_shop_controller.dart';

class SelectShopHeader extends GetResponsiveView<SelectShopController> {
  SelectShopHeader();

  @override
  Widget builder() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 40, bottom: 30, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
          GestureDetector(
            onTap: (){
              Get.toNamed(ShopMainRoutes.CREATE_SHOP);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: DEFAULT_BLUE)
              ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.add, color: DEFAULT_BLUE,),
                  Text('new_shop'.tr, style: TextStyle(
                    color: DEFAULT_BLUE
                  ),)
                ],
              ),
            ),
          ),
          )
        ],
      ),
    );
  }
}
