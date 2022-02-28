import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/login_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/widgets/login_body.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/widgets/login_header.dart';

import 'login_page_2.dart';

class LoginPage extends GetResponsiveView<LoginController> {
  @override
  Widget builder() {
    return Scaffold(
      // backgroundColor: DEFAULT_YELLOW_BG,
      body: SafeArea(
        child: LoginPageSecond(controller: controller),
      ),
    );
  }
}
