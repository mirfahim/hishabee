import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/manager/register_controller.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/widgets/register_body.dart';
import 'package:hishabee_business_manager_fl/app/modules/auth/presentation/widgets/register_header.dart';

class RegisterPage extends GetResponsiveView<RegisterController> {
  @override
  Widget builder() {
    return Scaffold(
      backgroundColor: DEFAULT_YELLOW_BG,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 120,
                child: SignUpHeader(),
              ),
              SignUpBody(
                controller: controller,
                screen: screen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
