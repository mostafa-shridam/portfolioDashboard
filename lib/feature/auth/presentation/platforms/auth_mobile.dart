import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/providers/auth.dart';
import '../widgets/social_button.dart';

class AuthMobile extends ConsumerWidget {
  const AuthMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          Text(
            LocaleKeys.authWelcomeMessage.tr(),
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 60),
          Center(
            child: SvgPicture.asset(
              Assets.images.login,
              width: 200,
              height: 200,
            ),
          ),
          SizedBox(height: 60),
          SocialButton(
            icon: Assets.images.google,
            isLoading: authState.isLoading ?? false,
            text: LocaleKeys.signInWithGoogle.tr(),
            onPressed: () =>
                ref.read(authProvider.notifier).signInWithGoogle(context),
          ),
        ],
      ),
    );
  }
}
