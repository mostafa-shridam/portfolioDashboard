import 'dart:io';
import 'package:flutter/foundation.dart';

import '../constants.dart';

String getLanguageCodeHelper() {
  if (kIsWeb) {
    return 'ar';
  }
  final deviceLocale = Platform.localeName.split('_').first;
  for (var loc in supportedLocales) {
    if (deviceLocale == loc.languageCode) {
      return deviceLocale;
    }
  }
  return 'ar';
}
