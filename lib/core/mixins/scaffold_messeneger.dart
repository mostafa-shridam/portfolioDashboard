import 'package:flutter/material.dart';

mixin ScaffoldMessengerMixin {
  void showSnackBar({
    required BuildContext context,
    required String message,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
        backgroundColor: color ?? Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
