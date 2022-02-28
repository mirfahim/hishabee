import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/_navigation/auth_routes.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/forgot_password_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/widgets/forget_pass_header.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/widgets/forget_pass_body.dart';

class ForgotPasswordPage extends GetResponsiveView<ForgotPasswordController> {
  @override
  Widget builder() {
    return Scaffold(
      backgroundColor: DEFAULT_YELLOW_BG,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            ForgetPinHeader(screen: screen),
            ForgetPinBody(screen: screen, controller: controller),
            Container(
              child: Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AuthRoutes.REGISTER);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'don_t_have_an_account'.tr,
                        style: TextStyle(color: Colors.black, fontSize: 16, fontFamily: 'Roboto'),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'sign_up'.tr,
                            style: TextStyle(color: DEFAULT_BLUE, fontSize: 16, fontFamily: 'Roboto'),
                          )
                        ],
                      ),
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
