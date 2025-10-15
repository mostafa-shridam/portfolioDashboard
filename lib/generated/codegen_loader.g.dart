// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "home": "الرئيسية",
  "settings": "الإعدادات",
  "projects": "المشاريع",
  "skills": "المهارات",
  "courses": "الدورات",
  "experience": "الخبرة",
  "education": "التعليم",
  "light": "نهاري",
  "dark": "ليلي",
  "system": "النظام",
  "languages": "اللغات",
  "arabic": "العربية",
  "english": "الإنجليزية",
  "authWelcomeMessage": "أهلا بك في بورتفوليو \nيمكنك تسجيل الدخول بواسطة حساب جوجل",
  "signInWithGoogle": "تسجيل الدخول بواسطة جوجل",
  "confirmButton": "موافق",
  "cancelButton": "الغاء",
  "signOut": "تسجيل الخروج",
  "signOutMessage": "هل أنت متأكد من تسجيل الخروج؟",
  "deleteAccount": "مسح الحساب",
  "deleteAccountMessage": "هل أنت متأكد من مسح الحساب؟"
};
static const Map<String,dynamic> _en = {
  "home": "Home",
  "settings": "Settings",
  "projects": "Projects",
  "skills": "Skills",
  "courses": "Courses",
  "experience": "Experience",
  "education": "Education",
  "light": "Light",
  "dark": "Dark",
  "system": "System",
  "languages": "Languages",
  "arabic": "Arabic",
  "english": "English",
  "authWelcomeMessage": "Welcome to Portfoliyo \nYou can sign in with your Google account",
  "signInWithGoogle": "Sign in with Google",
  "confirmButton": "Confirm",
  "cancelButton": "Cancel",
  "signOut": "Sign Out",
  "signOutMessage": "Are you sure you want to sign out?",
  "deleteAccount": "Delete Account",
  "deleteAccountMessage": "Are you sure you want to delete your account?"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
