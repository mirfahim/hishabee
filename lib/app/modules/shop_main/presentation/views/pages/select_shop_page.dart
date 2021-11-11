import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/manager/select_shop_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/widgets/select_shop_body.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/widgets/select_shop_footer.dart';
import 'package:hishabee_business_manager_fl/app/modules/shop_main/presentation/views/widgets/select_shop_header.dart';

class SelectShopPage extends GetResponsiveView<SelectShopController> {
  @override
  Widget builder() {
    return RefreshIndicator(
      onRefresh: controller.reload,
      child: Scaffold(
        backgroundColor: DEFAULT_YELLOW_BG,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectShopHeader(),
              SelectShopBody(
                screen: screen,
              ),
              SelectShopFooter(screen: screen),
            ],
          ),
        ),
      ),
    );
  }
}
