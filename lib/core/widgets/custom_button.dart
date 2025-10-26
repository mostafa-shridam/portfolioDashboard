import 'package:flutter/material.dart';

import '../theme/style.dart';
import 'custom_progress.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.color,
    this.textColor,
  });
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? color, textColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: color != null
              ? null
              : LinearGradient(colors: [primaryColor, greenColor]),
          color: color ?? primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: isLoading
              ? CustomProgress()
              : Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}
