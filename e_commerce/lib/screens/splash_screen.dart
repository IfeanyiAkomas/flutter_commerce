import 'package:e_commerce/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() async {
      final isLoggedIn = await AuthService.isLoggedIn();
      Navigator.pushReplacementNamed(context, isLoggedIn ? '/home' : '/login');
    });

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
