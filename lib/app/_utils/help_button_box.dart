import 'package:hive/hive.dart';

class HelpButton {
  static Future<bool> getBox(String key) async {
    var box = await Hive.openBox("helpBox");
    return box.get(key) ?? true;
  }

  static Future setBox(String key) async {
    var box = await Hive.openBox("helpBox");
    box.put(key, false);
  }
}

class ButtonKey {
  static final dashKey = "dsKey";
  static final addProductKey = "pdKey";
  static final sellKey = "sellKey";
  static final expenseKey = "expenseKey";
  static final reportKey = "reportKey";
  static final tranKey = "transactionKey";
}
