import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum apiMethods { get, post, patch, delete }

class Utils {

  static showToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
