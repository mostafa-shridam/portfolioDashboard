import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/language.dart';
import '../../../../core/theme/style.dart';
import '../../../settings/data/providers/settings.dart';
import '../../data/providers/home_provider.dart';

class ToogleButton extends ConsumerWidget {
  const ToogleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(settingsProvider).language == Language.arabic;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        ref.read(homeProviderProvider.notifier).toggleSidebar();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDark ? greenSwatch.shade900 : greenSwatch.shade100,
          border: Border.all(
            color: isDark ? greenSwatch.shade700 : greenSwatch.shade200,
          ),
          borderRadius: BorderRadius.horizontal(
            left: language ? Radius.circular(12) : Radius.circular(0),
            right: language ? Radius.circular(0) : Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withAlpha(20),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.menu,
          color: isDark ? greenSwatch.shade100 : greenSwatch.shade900,
        ),
      ),
    );
  }
}
