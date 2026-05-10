import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const _secureStorage = FlutterSecureStorage();

  // ── SENSIBLE: flutter_secure_storage ──────────────
  static Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
  }

  static Future<String?> getToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  static Future<void> deleteToken() async {
    await _secureStorage.delete(key: 'access_token');
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ── NO SENSIBLE: shared_preferences ───────────────
  static Future<void> saveUserInfo({
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
  }

  static Future<Map<String, String?>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('user_name'),
      'email': prefs.getString('user_email'),
    };
  }

  static Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    await prefs.remove('user_email');
  }

  // ── LOGOUT COMPLETO ───────────────────────────────
  static Future<void> logout() async {
    await deleteToken();
    await clearUserInfo();
  }
}
