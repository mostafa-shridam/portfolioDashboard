import 'package:flutter/material.dart';
import 'package:userportfolio/core/theme/style.dart';

mixin ScaffoldMessengerMixin {
  void showSnackBar({
    required BuildContext context,
    required String message,
    int? color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: Theme.of(context).textTheme.bodyMedium),
        backgroundColor: Color(
          color ?? primaryColor.toARGB32(),
        ).withValues(alpha: 0.8),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        padding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
