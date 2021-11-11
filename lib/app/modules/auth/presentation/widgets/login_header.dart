import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Welcome",
              style: TextStyle(
                fontSize: 14,
                color: DEFAULT_BLACK,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            "sign_in".tr,
            style: TextStyle(
              fontSize: 28,
              color: DEFAULT_BLUE,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
