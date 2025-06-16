import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double height;
  final double borderRadius;
  final Color color;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.height = 48,
    this.borderRadius = 12,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
