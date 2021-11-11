import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/manager/store_dashboard_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/widgets/store_body.dart';
import 'package:hishabee_business_manager_fl/app/modules/single_shop/online_shop/presentation/widgets/store_header.dart';

class StoreDashBoard extends GetResponsiveView<OnlineStoreDashboardController> {
  @override
  Widget builder() {
    return Obx(
      () => controller.onlineShopInfoResponse.value.shop == null
          ? Scaffold(
              backgroundColor: Colors.white,
            )
          : Scaffold(
              backgroundColor: DEFAULT_YELLOW_BG,
              body: SafeArea(
                child: ListView(
                  children: [
                    StoreHeader(),
                    StoreBody(),
                  ],
                ),
              ),
            ),
    );
  }
}
