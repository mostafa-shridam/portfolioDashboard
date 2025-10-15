import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';

enum Language {
  arabic('ar'),
  english('en');

  const Language(this.displayName);
  final String displayName;

  static Language fromString(String? value) {
    if (value == null) return Language.arabic;

    return Language.values.firstWhere(
      (language) => language.name == value || language.displayName == value,
      orElse: () => Language.arabic,
    );
  }

  String get toStr => name;

  static getLanguageName(Language language) {
    switch (language) {
      case Language.arabic:
        return LocaleKeys.languages.tr();
      case Language.english:
        return LocaleKeys.languages.tr();
    }
  }

  static Locale getLanguageLocale(Language language) {
    switch (language) {
      case Language.arabic:
        return Locale('ar');
      case Language.english:
        return Locale('en');
    }
  }
}
