import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/theme_mode.dart';
import '../../../core/mixins/alert_utils.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../generated/locale_keys.g.dart';
import '../data/providers/settings.dart';
import '../../auth/data/providers/auth.dart';

class SettingsPage extends ConsumerWidget with AlertUtils {
  const SettingsPage({super.key});
  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(title: Text('الإعدادات')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          children: [
            SizedBox(height: 64),
            CustomButton(
              text: LocaleKeys.signOut.tr(),
              isLoading: authState.isLoading ?? false,
              onPressed: () {
                showWarningAlert(
                  context: context,
                  title: LocaleKeys.signOut.tr(),
                  message: LocaleKeys.signOutMessage.tr(),
                  onConfirm: () {
                    ref.read(authProvider.notifier).signOut(context);
                  },
                );
              },
            ),
            SizedBox(height: 16),
            Switch.adaptive(
              value: ref.watch(settingsProvider).themeMode == Thememode.dark,
              onChanged: (value) async {
                await ref
                    .read(settingsProvider.notifier)
                    .changeThemeMode(value ? Thememode.dark : Thememode.light);
              },
            ),
            CustomButton(
              text: LocaleKeys.deleteAccount.tr(),
              isLoading: authState.isLoading ?? false,
              color: Colors.red,
              onPressed: () {
                showDangerAlert(
                  context: context,
                  title: LocaleKeys.deleteAccount.tr(),
                  message: LocaleKeys.deleteAccountMessage.tr(),
                  onConfirm: () {
                    ref.read(authProvider.notifier).deleteAccont(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
