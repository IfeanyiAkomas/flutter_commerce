import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) => AuthNotifier());

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    state = await AuthService.isLoggedIn();
  }

  Future<bool> login(String email, String password) async {
    final success = await AuthService.login(email, password);
    state = success;
    return success;
  }

  Future<void> register(String email, String password) async {
    await AuthService.register(email, password);
    state = true;
  }

  Future<void> logout() async {
    await AuthService.logout();
    state = false;
  }
}
