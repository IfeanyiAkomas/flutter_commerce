import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final isLoggedIn = await AuthService.isLoggedIn();
    state = isLoggedIn;
  }

  Future<bool> login(String email, String password) async {
    final userExists = await AuthService.userExists(email);
    if (!userExists) {
      state = false;
      return false;
    }

    final success = await AuthService.login(email, password);
    state = success;
    return success;
  }

  Future<bool> register(String email, String password) async {
    final success = await AuthService.register(email, password);
    state = success;
    return success;
  }

  Future<void> logout() async {
    await AuthService.logout();
    state = false;
  }
}
