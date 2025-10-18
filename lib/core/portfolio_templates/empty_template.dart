import 'package:flutter/material.dart';
import '../theme/style.dart';

class EmptyTemplate extends StatelessWidget {
  const EmptyTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? greenSwatch.shade900 : Colors.grey[50],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.web, size: 120, color: Colors.grey[400]),
            SizedBox(height: 24),
            Text(
              'No Template Selected',
              style: textTheme.headlineMedium?.copyWith(
                color: Colors.grey[600],
                fontSize: 24,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Choose a template from the Design section to preview',
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.grey[500],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
