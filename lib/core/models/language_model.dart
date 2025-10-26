class LanguageModel {
  final String code;
  final String name;
  final String nativeName;

  const LanguageModel({
    required this.code,
    required this.name,
    required this.nativeName,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      nativeName: json['nativeName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name, 'nativeName': nativeName};
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LanguageModel && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => '$name ($nativeName)';
}

// Predefined languages list
class Languages {
  static const List<LanguageModel> all = [
    LanguageModel(code: 'en', name: 'English', nativeName: 'English'),
    LanguageModel(code: 'ar', name: 'Arabic', nativeName: 'العربية'),
    LanguageModel(code: 'es', name: 'Spanish', nativeName: 'Español'),
    LanguageModel(code: 'fr', name: 'French', nativeName: 'Français'),
    LanguageModel(code: 'de', name: 'German', nativeName: 'Deutsch'),
    LanguageModel(code: 'it', name: 'Italian', nativeName: 'Italiano'),
    LanguageModel(code: 'pt', name: 'Portuguese', nativeName: 'Português'),
    LanguageModel(code: 'ru', name: 'Russian', nativeName: 'Русский'),
    LanguageModel(code: 'ja', name: 'Japanese', nativeName: '日本語'),
    LanguageModel(code: 'ko', name: 'Korean', nativeName: '한국어'),
    LanguageModel(code: 'zh', name: 'Chinese', nativeName: '中文'),
    LanguageModel(code: 'hi', name: 'Hindi', nativeName: 'हिन्दी'),
    LanguageModel(code: 'bn', name: 'Bengali', nativeName: 'বাংলা'),
    LanguageModel(code: 'ur', name: 'Urdu', nativeName: 'اردو'),
    LanguageModel(code: 'tr', name: 'Turkish', nativeName: 'Türkçe'),
    LanguageModel(code: 'nl', name: 'Dutch', nativeName: 'Nederlands'),
    LanguageModel(code: 'sv', name: 'Swedish', nativeName: 'Svenska'),
    LanguageModel(code: 'no', name: 'Norwegian', nativeName: 'Norsk'),
    LanguageModel(code: 'da', name: 'Danish', nativeName: 'Dansk'),
    LanguageModel(code: 'fi', name: 'Finnish', nativeName: 'Suomi'),
    LanguageModel(code: 'pl', name: 'Polish', nativeName: 'Polski'),
    LanguageModel(code: 'cs', name: 'Czech', nativeName: 'Čeština'),
    LanguageModel(code: 'sk', name: 'Slovak', nativeName: 'Slovenčina'),
    LanguageModel(code: 'hu', name: 'Hungarian', nativeName: 'Magyar'),
    LanguageModel(code: 'ro', name: 'Romanian', nativeName: 'Română'),
    LanguageModel(code: 'bg', name: 'Bulgarian', nativeName: 'Български'),
    LanguageModel(code: 'hr', name: 'Croatian', nativeName: 'Hrvatski'),
    LanguageModel(code: 'sr', name: 'Serbian', nativeName: 'Српски'),
    LanguageModel(code: 'sl', name: 'Slovenian', nativeName: 'Slovenščina'),
    LanguageModel(code: 'et', name: 'Estonian', nativeName: 'Eesti'),
    LanguageModel(code: 'lv', name: 'Latvian', nativeName: 'Latviešu'),
    LanguageModel(code: 'lt', name: 'Lithuanian', nativeName: 'Lietuvių'),
    LanguageModel(code: 'el', name: 'Greek', nativeName: 'Ελληνικά'),
    LanguageModel(code: 'he', name: 'Hebrew', nativeName: 'עברית'),
    LanguageModel(code: 'th', name: 'Thai', nativeName: 'ไทย'),
    LanguageModel(code: 'vi', name: 'Vietnamese', nativeName: 'Tiếng Việt'),
    LanguageModel(
      code: 'id',
      name: 'Indonesian',
      nativeName: 'Bahasa Indonesia',
    ),
    LanguageModel(code: 'ms', name: 'Malay', nativeName: 'Bahasa Melayu'),
    LanguageModel(code: 'tl', name: 'Filipino', nativeName: 'Filipino'),
    LanguageModel(code: 'sw', name: 'Swahili', nativeName: 'Kiswahili'),
    LanguageModel(code: 'af', name: 'Afrikaans', nativeName: 'Afrikaans'),
    LanguageModel(code: 'am', name: 'Amharic', nativeName: 'አማርኛ'),
    LanguageModel(code: 'az', name: 'Azerbaijani', nativeName: 'Azərbaycan'),
    LanguageModel(code: 'be', name: 'Belarusian', nativeName: 'Беларуская'),
    LanguageModel(code: 'bs', name: 'Bosnian', nativeName: 'Bosanski'),
    LanguageModel(code: 'ca', name: 'Catalan', nativeName: 'Català'),
    LanguageModel(code: 'cy', name: 'Welsh', nativeName: 'Cymraeg'),
    LanguageModel(code: 'eu', name: 'Basque', nativeName: 'Euskera'),
    LanguageModel(code: 'fa', name: 'Persian', nativeName: 'فارسی'),
    LanguageModel(code: 'ga', name: 'Irish', nativeName: 'Gaeilge'),
    LanguageModel(code: 'gl', name: 'Galician', nativeName: 'Galego'),
    LanguageModel(code: 'gu', name: 'Gujarati', nativeName: 'ગુજરાતી'),
    LanguageModel(code: 'is', name: 'Icelandic', nativeName: 'Íslenska'),
    LanguageModel(code: 'ka', name: 'Georgian', nativeName: 'ქართული'),
    LanguageModel(code: 'kk', name: 'Kazakh', nativeName: 'Қазақ'),
    LanguageModel(code: 'km', name: 'Khmer', nativeName: 'ខ្មែរ'),
    LanguageModel(code: 'kn', name: 'Kannada', nativeName: 'ಕನ್ನಡ'),
    LanguageModel(code: 'ky', name: 'Kyrgyz', nativeName: 'Кыргыз'),
    LanguageModel(code: 'lo', name: 'Lao', nativeName: 'ລາວ'),
    LanguageModel(code: 'mk', name: 'Macedonian', nativeName: 'Македонски'),
    LanguageModel(code: 'ml', name: 'Malayalam', nativeName: 'മലയാളം'),
    LanguageModel(code: 'mn', name: 'Mongolian', nativeName: 'Монгол'),
    LanguageModel(code: 'mr', name: 'Marathi', nativeName: 'मराठी'),
    LanguageModel(code: 'my', name: 'Myanmar', nativeName: 'မြန်မာ'),
    LanguageModel(code: 'ne', name: 'Nepali', nativeName: 'नेपाली'),
    LanguageModel(code: 'pa', name: 'Punjabi', nativeName: 'ਪੰਜਾਬੀ'),
    LanguageModel(code: 'si', name: 'Sinhala', nativeName: 'සිංහල'),
    LanguageModel(code: 'ta', name: 'Tamil', nativeName: 'தமிழ்'),
    LanguageModel(code: 'te', name: 'Telugu', nativeName: 'తెలుగు'),
    LanguageModel(code: 'uk', name: 'Ukrainian', nativeName: 'Українська'),
    LanguageModel(code: 'uz', name: 'Uzbek', nativeName: 'Oʻzbek'),
  ];

  static LanguageModel? findByCode(String code) {
    try {
      return all.firstWhere((lang) => lang.code == code);
    } catch (e) {
      return null;
    }
  }

  static List<LanguageModel> search(String query) {
    if (query.isEmpty) return all;

    final lowerQuery = query.toLowerCase();
    return all
        .where(
          (lang) =>
              lang.name.toLowerCase().contains(lowerQuery) ||
              lang.nativeName.toLowerCase().contains(lowerQuery) ||
              lang.code.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }
}
