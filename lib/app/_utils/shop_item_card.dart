import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const SHOP_ITEM_DECORATION = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(4),
      topRight: Radius.circular(4),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(4),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        spreadRadius: 1,
        blurRadius: 3,
        offset: Offset(0, 3),
      )
    ]);
