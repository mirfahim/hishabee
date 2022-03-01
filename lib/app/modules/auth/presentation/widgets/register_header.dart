import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  color: DEFAULT_BLACK,
                  size: 25,
                ),
                onPressed: () {
                  navigator.pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 30),
              child: Text(
                "welcome".tr,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: DEFAULT_BLACK,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            "sign_up".tr,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 20,
              color: DEFAULT_BLUE,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

/*Column SignUpHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: DEFAULT_BLACK,
                size: 25,
              ),
              onPressed: () {
                navigator.pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 30),
            child: Text(
              "welcome".tr,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                color: DEFAULT_BLACK,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Text(
          "sign_up".tr,
          style: TextStyle(
            fontFamily: 'Rubik',
            fontSize: 24,
            color: DEFAULT_BLUE,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ],
  );
}*/
