import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/manager/welcome_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/widgets/welcome_body.dart';
import 'package:hishabee_business_manager_fl/app/modules/home/presentation/widgets/welcome_header.dart';

import 'onboardingScrren/onboardingPage.dart';

class WelcomePage extends GetResponsiveView<WelcomeController> {
  @override
  Widget builder() {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            OnboardingPage(),
            WelcomeHeader(
              controller: controller,
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: WelcomeBody(),
            // ),
          ],
        ),
      ),
    );
  }
}
