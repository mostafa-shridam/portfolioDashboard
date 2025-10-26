import 'package:flutter/material.dart';

import '../../../../core/theme/style.dart';

class ToolbarItem extends StatelessWidget {
  const ToolbarItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.isSelected = false,
  });
  final VoidCallback onTap;
  final String title;
  final IconData icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 66,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: const EdgeInsets.only(top: 8, left: 4, right: 4),
        decoration: BoxDecoration(
          color: isDark ? greenSwatch.shade600 : greenSwatch.shade200,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withAlpha(60),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            colors: isSelected
                ? [
                    isDark ? greenSwatch.shade500 : greenSwatch.shade900,
                    isDark ? greenSwatch.shade200 : greenSwatch.shade400,
                  ]
                : [
                    isDark ? greenSwatch.shade900 : greenSwatch.shade500,
                    isDark ? greenSwatch.shade600 : greenSwatch.shade200,
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected
                    ? (isDark ? greenSwatch.shade800 : greenSwatch.shade50)
                    : (isDark ? greenSwatch.shade100 : greenSwatch.shade900),
              ),
              SizedBox(height: 2),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 6.7,
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? (isDark ? greenSwatch.shade800 : greenSwatch.shade50)
                      : (isDark ? greenSwatch.shade100 : greenSwatch.shade900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
