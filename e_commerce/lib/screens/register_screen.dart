import 'package:e_commerce/providers/auth_provider.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterScreen());
  }

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmPassCtrl = TextEditingController();
  bool _isLoading = false;

  void _register() async {
    final email = emailCtrl.text.trim();
    final pass = passCtrl.text.trim();
    final confirmPass = confirmPassCtrl.text.trim();

    if (email.isEmpty || pass.isEmpty || confirmPass.isEmpty) {
      _showSnack('Please fill all fields');
      return;
    }
    if (pass != confirmPass) {
      _showSnack('Passwords do not match');
      return;
    }

    final auth = ref.read(authProvider.notifier);
    setState(() => _isLoading = true);
    try {
      await auth.register(email, pass);
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    } catch (e) {
      _showSnack('User already exists!');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 15,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.person_add_alt_1,
                      size: 60,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Create an Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(emailCtrl, "Email", Icons.email),
                    const SizedBox(height: 16),
                    _buildTextField(
                      passCtrl,
                      "Password",
                      Icons.lock,
                      obscure: true,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      confirmPassCtrl,
                      "Confirm Password",
                      Icons.lock_outline,
                      obscure: true,
                    ),
                    const SizedBox(height: 32),
                    CustomButton(
                      text: "Sign Up",
                      onPressed: _register,
                      isLoading: _isLoading,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String hint,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextField(
      controller: ctrl,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.blue),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
