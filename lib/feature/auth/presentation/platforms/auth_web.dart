import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:userportfolio/core/theme/style.dart';
import 'package:userportfolio/feature/settings/data/providers/settings.dart';
import '../../../../core/extensions/language.dart';
import '../../../../core/extensions/theme_mode.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/providers/auth.dart';
import '../widgets/social_button.dart';

class AuthWeb extends ConsumerWidget {
  const AuthWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final authState = ref.watch(authProvider);
    final themeMode = ref.read(settingsProvider).themeMode ?? Thememode.system;
    Language language = ref.read(settingsProvider).language ?? Language.arabic;
    return Center(
      child: Card(
        elevation: 8,
        shadowColor: primaryColor.withAlpha(120),
        color: isDark ? greenSwatch.shade900 : greenSwatch.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.74,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isDark ? greenSwatch.shade900 : greenSwatch.shade200,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 36,
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: Language.getOppositeLanguageName(language),
                      onPressed: () async {
                        language = language == Language.arabic
                            ? Language.english
                            : Language.arabic;
                        await ref
                            .read(settingsProvider.notifier)
                            .changeLanguage(language);
                        if (context.mounted) {
                          await context.setLocale(
                            Locale(
                              Language.getLanguageLocale(language).languageCode,
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.language, size: 24),
                    ),
                    IconButton(
                      onPressed: () async {
                        await ref
                            .read(settingsProvider.notifier)
                            .changeThemeMode(
                              themeMode == Thememode.light
                                  ? Thememode.dark
                                  : Thememode.light,
                            );
                      },
                      icon: Icon(
                        themeMode == Thememode.light
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        size: 24,
                      ),
                    ),
                  ],
                ),

                Text(
                  LocaleKeys.authWelcomeMessage.tr(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(height: 1.2),

                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                SvgPicture.asset(Assets.images.login, width: 140, height: 140),
                SizedBox(height: 16),
                SocialButton(
                  icon: Assets.images.google,
                  text: LocaleKeys.signInWithGoogle.tr(),
                  isLoading: authState.isLoading ?? false,
                  onPressed: () =>
                      ref.read(authProvider.notifier).signInWithGoogle(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
