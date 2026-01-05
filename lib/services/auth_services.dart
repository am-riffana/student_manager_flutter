import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _key = 'isLoggedIn';

  static Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, true);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, false);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }
}
