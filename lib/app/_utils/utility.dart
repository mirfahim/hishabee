import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Utility {
  static Future<String> getImageFromPreferences(String key) async {
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    final box = await Hive.openBox('imageBox');

    return box.get(key);
  }

  static Future<void> saveImageToPreferences(String key, String value) async {
    final box = await Hive.openBox('imageBox');
    box.put(key, value);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static final dateFormat = DateFormat('DD MMM YYYY');
  static final dateTimeFormat = DateFormat('DD/MMM/yyyy \n kk:mm a');
  static final timeFormat = DateFormat('kk:mm a').format(DateTime.now());

  static final date = DateFormat('yyyy-MM-dd');
  static final time = DateFormat('HH:mm');

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    return diff == 0 && now.day == date.day;
  }

  static bool isYesterDay(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    return diff == 1 && now.day + 1 == date.day;
  }

  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    return diff <= 7;
  }

  static bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return now.year == date.year && now.month == date.month;
  }

  static bool isInRange(DateTime startDate, DateTime endDate, DateTime date) {
    return date.isAfter(startDate) &&
        date.isBefore(endDate.add(Duration(days: 1)));
  }
}
