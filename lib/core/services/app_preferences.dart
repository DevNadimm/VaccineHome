import 'package:shared_preferences/shared_preferences.dart';
import 'package:vaccine_home/core/constants/preference_keys.dart';

class AppPreferences {
  AppPreferences._();

  /// Access Token
  static Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.accessToken) ?? '';
  }

  static Future<void> setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.accessToken, token);
  }

  static Future<void> removeAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PreferenceKeys.accessToken);
  }

  /// User Avatar
  static Future<String?> getUserAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userAvatar);
  }

  static Future<void> setUserAvatar(String? avatar) async {
    final prefs = await SharedPreferences.getInstance();
    if (avatar != null) {
      await prefs.setString(PreferenceKeys.userAvatar, avatar);
    } else {
      await prefs.remove(PreferenceKeys.userAvatar);
    }
  }

  /// User Name
  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userName);
  }

  static Future<void> setUserName(String? name) async {
    final prefs = await SharedPreferences.getInstance();
    if (name != null) {
      await prefs.setString(PreferenceKeys.userName, name);
    } else {
      await prefs.remove(PreferenceKeys.userName);
    }
  }

  /// User Email
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userEmail);
  }

  static Future<void> setUserEmail(String? email) async {
    final prefs = await SharedPreferences.getInstance();
    if (email != null) {
      await prefs.setString(PreferenceKeys.userEmail, email);
    } else {
      await prefs.remove(PreferenceKeys.userEmail);
    }
  }

  /// User Phone
  static Future<String?> getUserPhone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userPhone);
  }

  static Future<void> setUserPhone(String? phone) async {
    final prefs = await SharedPreferences.getInstance();
    if (phone != null) {
      await prefs.setString(PreferenceKeys.userPhone, phone);
    } else {
      await prefs.remove(PreferenceKeys.userPhone);
    }
  }

  /// User Date of Birth
  static Future<String?> getUserDOB() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userDOB);
  }

  static Future<void> setUserDOB(String? dob) async {
    final prefs = await SharedPreferences.getInstance();
    if (dob != null) {
      await prefs.setString(PreferenceKeys.userDOB, dob);
    } else {
      await prefs.remove(PreferenceKeys.userDOB);
    }
  }

  /// User Gender
  static Future<String?> getUserGender() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userGender);
  }

  static Future<void> setUserGender(String? gender) async {
    final prefs = await SharedPreferences.getInstance();
    if (gender != null) {
      await prefs.setString(PreferenceKeys.userGender, gender);
    } else {
      await prefs.remove(PreferenceKeys.userGender);
    }
  }

  /// User Address
  static Future<String?> getUserAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(PreferenceKeys.userAddress);
  }

  static Future<void> setUserAddress(String? address) async {
    final prefs = await SharedPreferences.getInstance();
    if (address != null) {
      await prefs.setString(PreferenceKeys.userAddress, address);
    } else {
      await prefs.remove(PreferenceKeys.userAddress);
    }
  }

  /// Clear all preferences (e.g., on logout)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
