import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static SharedPref to = SharedPref();
  initial() async {
    prefss = await SharedPreferences.getInstance();
  }

  SharedPreferences prefss;
  static String profileEmail;
  static bool loginState;
  static String profileName = "there";
}
//SharedPref.to.prefss.setString("email", profileEmail);
//SharedPref.to.prefss.getString("profileName");
