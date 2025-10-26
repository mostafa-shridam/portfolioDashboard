import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../core/local_service/save_user.dart';
import '../../../core/models/user_model.dart';
import '../../auth/data/providers/auth.dart';
import 'platforms/home_mobile.dart';
import 'platforms/home_web.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel userData = UserModel();
    userData = ref.watch(authProvider.select((e) => e.user ?? UserModel()));
    userData = ref.watch(saveUserProvider).getUserData() ?? UserModel();
    final isDesktop = ResponsiveBreakpoints.of(context).isDesktop;
    return Scaffold(
      body: isDesktop && kIsWeb
          ? HomeWeb(userData: userData)
          : HomeMobile(userData: userData),
    );
  }
}
