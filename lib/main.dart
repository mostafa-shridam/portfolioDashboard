import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userportfolio/core/services/life_cycle_manager.dart';
import 'package:userportfolio/core/theme/style.dart';
import 'package:userportfolio/feature/auth/presentation/auth_page.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/constants.dart';
import 'core/extensions/font_family.dart';
import 'core/extensions/theme_mode.dart';
import 'core/services/app_routing.dart';
import 'core/enum/constants.dart';
import 'core/local_service/local_storage.dart';
import 'core/services/helper.dart';
import 'core/services/scroll_behavior.dart';
import 'feature/home/presentation/home_page.dart';
import 'firebase_options.dart';
import 'generated/codegen_loader.g.dart';
import 'providers/settings.dart';

Future<void> init() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await LocalStorage.instance.initHive();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: supportedLocales,
        path: translationsPath,
        useOnlyLangCode: true,
        useFallbackTranslations: true,
        fallbackLocale: Locale(getLanguageCodeHelper()),
        startLocale: Locale(getLanguageCodeHelper()),
        assetLoader: const CodegenLoader(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontFamily =
        ref.watch(settingsProvider).fontFamily ?? FontFamily.cairo;
    final fontSize = ref.watch(settingsProvider).fontSizes;
    final themeMode = ref.watch(settingsProvider).themeMode ?? Thememode.system;

    final isLogin =
        LocalStorage.instance.getData(key: Constants.loginKey.name) ?? false;
    return GestureDetector(
      onTap: unfocusCurrent,

      child: ResponsiveBreakpoints(
        breakpoints: [
          Breakpoint(start: 0, end: 600, name: MOBILE),
          Breakpoint(start: 601, end: 1200, name: TABLET),
          Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
        ],
        child: LifeCycleManager(
          child: MaterialApp(
            title: 'Portfolio',
            scrollBehavior: CustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: getLightTheme(fontFamily.toStr, fontSize?.size ?? 1),
            darkTheme: getDarkTheme(fontFamily.toStr, fontSize?.size ?? 1),
            themeMode: themeMode.flutterThemeMode,
            initialRoute: !isLogin ? HomePage.routeName : AuthPage.routeName,
            onGenerateRoute: onGenerateRoute,
            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);
              return ResponsiveScaledBox(
                width: ResponsiveValue<double?>(
                  context,
                  conditionalValues: [
                    const Condition.equals(name: MOBILE, value: 450),
                    const Condition.between(start: 601, end: 800, value: 800),
                    Condition.between(
                      start: 801,
                      end: 1200,
                      value: mediaQueryData.size.width,
                    ),
                    Condition.largerThan(
                      name: TABLET,
                      value: mediaQueryData.size.width,
                    ),
                  ],
                ).value,
                child: MediaQuery(
                  data: mediaQueryData.copyWith(
                    textScaler: TextScaler.linear(fontSize?.size ?? 1),
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: child,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
