import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCardContainer extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;

  const CustomCardContainer(
      {Key key, @required this.child, this.width, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: child,
      ),
      margin: EdgeInsets.only(
        left: 10,
        top: 10,
        right: 10,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
