import 'package:shared_preferences/shared_preferences.dart';

class CheckUserSignIn {

  static String signinkey = "LOGIN_KEY";
  static String signinnumber = "PHONE_NUMBER";

  static Future<bool?> getUserSignInStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(signinkey);
  }
}