import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String USER_NAME = "userName";

  Future<void> saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(USER_NAME, userName);
  }

  Future<String?> get getUserName async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_NAME);
  }
}
