import 'package:flutter/material.dart';

import '../../feature/auth/presentation/auth_page.dart';
import '../../feature/home/presentation/home_page.dart';
import '../../feature/settings/presentation/settings_page.dart';
import '../widgets/developer_template_demo.dart';

Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
  switch (settings.name) {
    case AuthPage.routeName:
      return MaterialPageRoute(builder: (context) => const AuthPage());
    case HomePage.routeName:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case SettingsPage.routeName:
      return MaterialPageRoute(builder: (context) => const SettingsPage());

    default:
      return null;
  }
};
