import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';
import 'package:hishabee_business_manager_fl/app/_utils/utility.dart';

class WithdrawFooter extends StatelessWidget {
  WithdrawFooter();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 20, right: 20),
          child: Container(
            child: Text(
              "need_assistance".tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: DEFAULT_BLACK,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
          child: GestureDetector(
            onTap: () {
              Utility.launchURL("tel:+88 09613829088");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        FontAwesomeIcons.phoneAlt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "call_us_for_emergency_support".tr,
                          style: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "+88 09613829088",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(
                        0,
                        2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
          child: GestureDetector(
            onTap: () {
              Utility.launchURL("https://www.messenger.com/t/HishaBee");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.pink[200],
                      child: Icon(
                        FontAwesomeIcons.comment,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "live_support".tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(
                        0,
                        2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
