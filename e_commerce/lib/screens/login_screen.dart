import 'package:e_commerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    if (_emailCtrl.text.trim().isEmpty || _passCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2)); // mock login
    setState(() => _isLoading = false);
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Icon(Icons.lock_open_rounded, size: 100, color: Colors.blue),
              const SizedBox(height: 24),
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration('Email', Icons.email_outlined),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passCtrl,
                obscureText: true,
                decoration: _inputDecoration('Password', Icons.lock_outline),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: "Login",
                onPressed: _login,
                isLoading: _isLoading,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.push(context, RegisterScreen.route());
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.blue),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
