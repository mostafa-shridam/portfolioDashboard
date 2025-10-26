import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../extensions/font_family.dart';

const primaryColor = Color(0XFF1B5E37);
const greenColor = Color(0xFF05D510);
const Color whiteColor = Colors.white;
const Color successGreen = Color(0xFF043D18);
const Color warningYellow = Color(0xFFFFC100);
const Color dangerRed = Color(0xFFFE5960);
const Color accentColor = Color(0XFFFFB400);
const Color infoColor = Color(0xFF007AFF);

const MaterialColor greenSwatch = MaterialColor(0XFF000000, {
  50: Color(0xFFF3FAF6), // خلفية فاتحة جدًا فيها لمسة خضار
  100: Color(0xFFF0F0F0),
  200: Color(0xFFD9E9CF),
  300: Color(0xFFB6CEB4),
  400: Color(0xFF96A78D),
  500: Color(0xFF27391C), // اللون الأساسي
  600: Color(0xFF191919),
  700: Color(0xFF191A19),
  800: Color(0xFF161616),
  900: Color(0xFF0F0E0E),
});

ThemeData getLightTheme(String fontFamily) {
  return _buildTheme(
    brightness: Brightness.light,
    fontFamily: fontFamily,
    baseColor: greenSwatch.shade900,
    backgroundColor: whiteColor,
    surfaceColor: whiteColor,
    dividerColor: greenSwatch.shade200,
    iconColor: greenSwatch.shade600,
    navLabelColor: greenSwatch.shade900,
    navUnselectedColor: greenSwatch.shade600,
    appBarColor: whiteColor,
    overlayBrightness: Brightness.dark,
  );
}

ThemeData getDarkTheme(String fontFamily) {
  return _buildTheme(
    brightness: Brightness.dark,
    fontFamily: fontFamily,
    baseColor: greenSwatch.shade50,
    backgroundColor: greenSwatch.shade900,
    surfaceColor: greenSwatch.shade800,
    dividerColor: greenSwatch.shade600,
    iconColor: primaryColor,
    navLabelColor: greenSwatch.shade100,
    navUnselectedColor: greenSwatch.shade300,
    appBarColor: greenSwatch.shade900,
    overlayBrightness: Brightness.light,
  );
}

ThemeData _buildTheme({
  required Brightness brightness,
  required String fontFamily,
  required Color baseColor,
  required Color backgroundColor,
  required Color surfaceColor,
  required Color dividerColor,
  required Color iconColor,
  required Color navLabelColor,
  required Color navUnselectedColor,
  required Color appBarColor,
  required Brightness overlayBrightness,
}) {
  final alpha = fontFamily == FontFamily.cairo.toStr ? -3.0 : 0.0;
  final textTheme = TextTheme(
    displayLarge: TextStyle(
      color: baseColor,
      fontSize: 32 + alpha,
      fontWeight: FontWeight.w600,
    ),
    displayMedium: TextStyle(
      color: baseColor,
      fontSize: 28 + alpha,
      fontWeight: FontWeight.w600,
    ),
    displaySmall: TextStyle(
      color: baseColor,
      fontSize: 24 + alpha,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: TextStyle(
      color: baseColor,
      fontSize: 20 + alpha,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      color: baseColor,
      fontSize: 18 + alpha,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      color: baseColor,
      fontSize: 16 + alpha,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: baseColor,
      fontSize: 18 + alpha,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: baseColor,
      fontSize: 16 + alpha,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: baseColor,
      fontSize: 14 + alpha,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      color: baseColor,
      fontSize: 20 + alpha,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: baseColor,
      fontSize: 18 + alpha,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: baseColor,
      fontSize: 16 + alpha,
      fontWeight: FontWeight.w500,
    ),
    headlineLarge: TextStyle(
      color: baseColor,
      fontSize: 30 + alpha,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: TextStyle(
      color: baseColor,
      fontSize: 26 + alpha,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: TextStyle(
      color: baseColor,
      fontSize: 22 + alpha,
      fontWeight: FontWeight.w600,
    ),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    fontFamily: fontFamily,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    dividerColor: dividerColor,
    dividerTheme: DividerThemeData(color: dividerColor, thickness: 0.67),
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: primaryColor,
      secondary: accentColor,
      surface: surfaceColor,
      error: dangerRed,
      onPrimary: whiteColor,
      onSecondary: whiteColor,
      onSurface: baseColor,
      onError: whiteColor,
    ),
    iconTheme: IconThemeData(color: iconColor, size: 24),
    primaryIconTheme: IconThemeData(color: iconColor, size: 24),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      toolbarHeight: 64,
      actionsIconTheme: IconThemeData(color: iconColor),
      iconTheme: IconThemeData(color: iconColor),
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        color: baseColor,
        fontSize: 20 + alpha,
        fontWeight: FontWeight.w700,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: appBarColor,
        statusBarIconBrightness: overlayBrightness,
        statusBarBrightness: overlayBrightness,
        systemNavigationBarColor: appBarColor,
        systemNavigationBarIconBrightness: overlayBrightness,
        systemNavigationBarContrastEnforced: true,
        systemNavigationBarDividerColor: appBarColor,
        systemStatusBarContrastEnforced: true,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: backgroundColor,
      elevation: 1,
      selectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w500,
        color: navLabelColor,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18 + alpha,
        fontWeight: FontWeight.w500,
        color: navUnselectedColor,
      ),
      selectedItemColor: navLabelColor,
      unselectedItemColor: navUnselectedColor,
      selectedIconTheme: IconThemeData(color: navLabelColor),
      unselectedIconTheme: IconThemeData(color: navUnselectedColor),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
    textTheme: textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: whiteColor,
        textStyle: TextStyle(
          fontSize: 18 + alpha,
          fontWeight: FontWeight.w500,
          fontFamily: fontFamily,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      labelStyle: TextStyle(
        fontSize: 18 + alpha,
        fontFamily: fontFamily,
        color: baseColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: 18 + alpha,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    tooltipTheme: TooltipThemeData(
      textStyle: TextStyle(
        fontSize: 18 + alpha,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      textColor: primaryColor,
      iconColor: primaryColor,
      collapsedIconColor: iconColor,
      collapsedTextColor: baseColor,
    ),
    datePickerTheme: DatePickerThemeData(
      weekdayStyle: TextStyle(
        fontSize: 18 + alpha + 2,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
      dayStyle: TextStyle(
        fontSize: 18 + alpha + 2,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
      yearStyle: TextStyle(
        fontSize: 18 + alpha + 2,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
    ),
  );
}
