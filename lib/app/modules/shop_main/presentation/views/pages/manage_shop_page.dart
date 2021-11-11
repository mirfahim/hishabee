import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/manage_shop_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/widgets/manage_shop_body.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/widgets/manage_shop_footer.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/widgets/manage_shop_header.dart';

class ManageShopPage extends GetResponsiveView<ManageShopController> {
  @override
  Widget builder() {
    return RefreshIndicator(
      onRefresh: controller.getAllShop,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: DEFAULT_YELLOW_BG,
          resizeToAvoidBottomInset: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ManageShopHeader(),
              ManageShopBody(),
              ManageShopFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
