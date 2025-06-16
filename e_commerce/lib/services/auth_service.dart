import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _usersKey = 'registered_users';
  static const _loggedInKey = 'is_logged_in';

  // Store user as a JSON-encoded map
  static Future<bool> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _getUsers();

    final exists = users.any((user) => user['email'] == email);
    if (exists) return false;

    users.add({'email': email, 'password': password});
    await prefs.setString(_usersKey, jsonEncode(users));
    await prefs.setBool(_loggedInKey, true);
    return true;
  }

  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await _getUsers();

    final match = users.any(
      (user) => user['email'] == email && user['password'] == password,
    );

    await prefs.setBool(_loggedInKey, match);
    return match;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  static Future<bool> userExists(String email) async {
    final users = await _getUsers();
    return users.any((user) => user['email'] == email);
  }

  static Future<List<Map<String, String>>> _getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_usersKey);
    if (jsonStr == null) return [];
    final List<dynamic> decoded = jsonDecode(jsonStr);
    return decoded.cast<Map<String, dynamic>>().map((user) => {
      'email': user['email'].toString(),
      'password': user['password'].toString()
    }).toList();
  }
}
