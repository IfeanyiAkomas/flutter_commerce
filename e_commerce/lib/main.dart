import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/screens/register_screen.dart';
import 'package:e_commerce/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ✅ Declare the key globally
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey, // Optional: only if you're using it
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => SplashScreen(),
        '/login': (_) => LoginScreen(),
        '/register': (_) => RegisterScreen(),
        '/home': (_) => HomeScreen(),
      },
    );
  }
}
