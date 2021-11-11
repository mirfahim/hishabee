import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

abstract class ILocalizationService {
  Future<void> changeLocale();

  Future<void> toEnglish();

  Future<void> toBangla();

  Future<bool> isBangla();
}

class LocalizationService implements ILocalizationService {
  static final boxKey = 'langBox';
  static final isBanglaKey = 'isBangla';

  @override
  Future<void> changeLocale() async {
    final box = await Hive.openBox(boxKey);

    bool isBn = await isBangla();

    Locale locale;
    if (isBn) {
      locale = Locale('en', 'US');
      box.put(isBanglaKey, false);
    } else {
      locale = Locale('bn', 'BD');
      box.put(isBanglaKey, true);
    }
    Get.updateLocale(locale);
  }

  @override
  Future<bool> isBangla() async {
    final box = await Hive.openBox(boxKey);

    bool isBn = (box.get(isBanglaKey) ?? true);

    return isBn;
  }

  @override
  Future<void> toBangla() async {
    final box = await Hive.openBox(boxKey);

    Locale locale = Locale('bn', 'BD');

    Get.updateLocale(locale);

    box.put(isBanglaKey, true);
  }

  @override
  Future<void> toEnglish() async {
    final box = await Hive.openBox(boxKey);

    Locale locale = Locale('en', 'US');

    Get.updateLocale(locale);

    box.put(isBanglaKey, false);
  }
}
