import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class ForgetPinHeader extends GetResponsiveView {
  ForgetPinHeader({
    Key key,
    @required this.screen,
  });

  final ResponsiveScreen screen;

  @override
  Widget builder() {
    return Positioned(
      top: screen.height * 0.05,
      left: 15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "forgot_password".tr,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              color: DEFAULT_BLUE,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
