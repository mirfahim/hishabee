import 'package:flutter/material.dart';

const Color DEFAULT_BLUE = Color(0xff185ADB);
const Color DEFAULT_YELLOW_BG = Color(0xffffcb37);
const Color DEFAULT_YELLOW_Light = Color(0xffFFFDE7);
const Color DEFAULT_BODY_BG_COLOR = Colors.white;
const Color DEFAULT_BLACK = Color(0xff121212);
const Color DEFAULT_BLUE_DARK = Color(0xff25364F);

// returns a default blueish colored background button with white text ie: Sign Up or Sign In button
Widget getDefaultBlueButton(
  BuildContext context,
  String buttonName,
  Function onPressedFunction,
) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: DEFAULT_BLACK,
      ),
      onPressed: () {
        onPressedFunction();
      },
      child: Text(
        buttonName,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.normal,
          fontSize: 16,
        ),
      ),
    ),
  );
}
