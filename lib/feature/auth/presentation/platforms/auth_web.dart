import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:userportfolio/core/theme/style.dart';
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
    return Center(
      child: Card(
        elevation: 8,
        shadowColor: isDark
            ? primaryColor.withAlpha(120)
            : greenSwatch.shade100,
        color: isDark ? greenSwatch.shade900 : greenSwatch.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isDark ? greenSwatch.shade900 : greenSwatch.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 36,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.language, size: 40),
              ),

              Text(
                LocaleKeys.authWelcomeMessage.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              SvgPicture.asset(Assets.images.login, width: 160, height: 160),
              SizedBox(height: 16),
              SocialButton(
                icon: Assets.images.google,
                text: LocaleKeys.signInWithGoogle.tr(),
                isLoading: authState.isLoading ?? false,
                onPressed: () => ref
                    .read(authProvider.notifier)
                    .sginInWithGoogleWeb(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
