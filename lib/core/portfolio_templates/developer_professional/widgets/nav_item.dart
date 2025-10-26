import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../feature/settings/data/providers/settings.dart';

class NavItemMobile extends ConsumerWidget {
  const NavItemMobile({
    super.key,
    required this.index,
    required this.title,
    required this.selectedColor,
  });
  final double index;
  final String title;
  final int selectedColor;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(settingsProvider.notifier).scrollTo(index);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(bottom: 2),
        width: double.infinity,
        color: Color(selectedColor),
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class NavItem extends ConsumerWidget {
  const NavItem({super.key, required this.index, required this.title});
  final double index;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),

        focusNode: FocusNode(),
        onTap: () {
          ref.read(settingsProvider.notifier).scrollTo(index);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
