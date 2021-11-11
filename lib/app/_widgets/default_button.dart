import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    @required this.screen,
    @required this.text,
    @required this.buttonColor,
    @required this.onPressed,
  }) : super(key: key);

  final ResponsiveScreen screen;
  final String text;
  final Color buttonColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 40,
        width: double.maxFinite,
        child: ElevatedButton(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: screen.responsiveValue(mobile: 16, tablet: 20),
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(primary: buttonColor),
        ),
      ),
    );
  }
}
