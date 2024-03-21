import 'package:shared_preferences/shared_preferences.dart';

class AppCache {

  static const String _tokenKey = 'token';

  static Future<void> saveTokenToCache(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenKey, token);
  }

  static Future<String?> getTokenFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}