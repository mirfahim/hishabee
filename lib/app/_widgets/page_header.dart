import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabee_business_manager_fl/app/_utils/default_values.dart';

Column buildPageHeader(String title, String subtitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 25,
              ),
              onPressed: () {
                navigator.pop();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Rubik',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: DEFAULT_BLACK,
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(
          top: 0.0,
          left: 15.0,
          bottom: 10,
        ),
        child: Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'Rubik-VariableFont_wght',
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: DEFAULT_BLUE,
          ),
        ),
      ),
    ],
  );
}

Column buildContactDetailsPageHeader(
    String title, String subtitle, Widget button) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.arrow_back,
              size: 25,
            ),
            onPressed: () {
              navigator.pop();
            },
          ),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Rubik',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          button,
        ],
      ),
      // Padding(
      //   padding: const EdgeInsets.only(
      //     top: 10.0,
      //     left: 10.0,
      //     bottom: 10,
      //   ),
      //   child: Text(
      //     subtitle,
      //     style: TextStyle(
      //       fontFamily: 'Rubik',
      //       fontSize: 18,
      //       fontWeight: FontWeight.w600,
      //       color: Colors.black,
      //     ),
      //   ),
      // ),
    ],
  );
}
