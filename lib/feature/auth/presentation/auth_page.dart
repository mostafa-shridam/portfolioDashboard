import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:userportfolio/feature/auth/presentation/platforms/auth_mobile.dart';
import '../../../core/theme/style.dart';
import 'platforms/auth_web.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});
  static const String routeName = '/auth';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [greenSwatch.shade900, greenSwatch.shade700]
                : [greenSwatch.shade400, greenSwatch.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: isDesktop && kIsWeb ? const AuthWeb() : const AuthMobile(),
      ),
    );
  }
}
