import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static final _storage = FlutterSecureStorage();

  static Future<bool> register(String email, String password) async {
    // Simulated registration
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'password', value: password);
    await _storage.write(key: 'token', value: 'mock_token');
    return true;
  }

  static Future<bool> login(String email, String password) async {
    final storedEmail = await _storage.read(key: 'email');
    final storedPassword = await _storage.read(key: 'password');
    if (email == storedEmail && password == storedPassword) {
      await _storage.write(key: 'token', value: 'mock_token');
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    await _storage.delete(key: 'token');
  }

  static Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    return token != null;
  }
}
