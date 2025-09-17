import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_home/core/constants/preference_keys.dart';

class AppPreferences {
  AppPreferences._();

  /// Get access token
  static Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.accessToken) ?? '';
  }

  /// Save access token
  static Future<void> setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.accessToken, token);
  }

  /// Remove only access token
  static Future<void> removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PreferenceKeys.accessToken);
  }

  /// Clear all preferences (e.g. on logout)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
