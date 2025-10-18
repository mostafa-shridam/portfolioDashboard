import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  100: Color(0xFFE6F4EC),
  200: Color(0xFFCDE8D8),
  300: Color(0xFFAEDCC1),
  400: Color(0xFF8ED0A9),
  500: Color(0xFF1B653C), // اللون الأساسي
  600: Color(0xFF175232),
  700: Color(0xFF134028),
  800: Color(0xFF0F2E1F),
  900: Color(0xFF0A1F16),
});

ThemeData getLightTheme(String fontFamily, double fontSize) {
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
    fontSize: fontSize,
  );
}

ThemeData getDarkTheme(String fontFamily, double fontSize) {
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
    fontSize: fontSize,
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
  required double fontSize,
}) {
  final textTheme = TextTheme(
    bodyLarge: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: baseColor,
    ),
    bodyMedium: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: baseColor,
    ),
    bodySmall: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
      color: baseColor,
    ),
    labelLarge: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: baseColor,
    ),
    labelMedium: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: baseColor,
    ),
    labelSmall: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: baseColor,
    ),
    headlineLarge: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: baseColor,
    ),
    headlineMedium: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: baseColor,
    ),
    headlineSmall: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      color: baseColor,
    ),
  );

  return ThemeData(
    useMaterial3: false,

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
        fontSize: fontSize,
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
        fontSize: fontSize + 2,
        fontWeight: FontWeight.w500,
        color: navLabelColor,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
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
          fontSize: fontSize,
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
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: baseColor,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: fontSize,
            fontFamily: fontFamily,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
    tooltipTheme: TooltipThemeData(
      textStyle: TextStyle(
        fontSize: fontSize,
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
        fontSize: fontSize + 2,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
      dayStyle: TextStyle(
        fontSize: fontSize + 2,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
      yearStyle: TextStyle(
        fontSize: fontSize + 2,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
    ),
  );
}
