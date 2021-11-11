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
        child: Container(
          height: screen.context.height,
          width: screen.context.width,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                // LoginHeader(),
                LoginBody(controller: controller),
                // LoginPageSecond(controller: controller)
                ///TODO built by samin
              ],
            ),
          ),
        ),
      ),
    );
  }
}
