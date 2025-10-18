import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../core/enum/constants.dart';
import '../core/extensions/font_family.dart';
import '../core/extensions/font_size.dart';
import '../core/extensions/language.dart';
import '../core/extensions/theme_mode.dart';
import '../core/local_service/local_storage.dart';
import '../core/theme/style.dart';

part 'generated/settings.g.dart';

@Riverpod(keepAlive: true)
class SettingsNotifier extends _$SettingsNotifier {
  late LocalStorage _box;

  @override
  SettingsState build() {
    _box = LocalStorage.instance;
    state = SettingsState(
      isLoading: false,
      themeMode: Thememode.fromString(
        _box.getData(key: Constants.themeKey.name),
      ),
      language: Language.fromString(
        _box.getData(key: Constants.languageKey.name),
      ),
      fontSizes: FontSizes.fromString(
        _box.getData(key: Constants.fontSize.name),
      ),
      fontFamily: FontFamily.fromString(
        _box.getData(key: Constants.fontFamily.name) ?? FontFamily.cairo.toStr,
      ),
    );
    return state;
  }

  Future<void> changeFontSize(FontSizes fontSize) async {
    state = state.copyWith(isLoading: true);
    try {
      await _box.saveData(key: Constants.fontSize.name, value: fontSize.toStr);
      state = state.copyWith(fontSizes: fontSize, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> changeFontFamily(FontFamily fontFamily) async {
    state = state.copyWith(isLoading: true);
    try {
      await _box.saveData(
        key: Constants.fontFamily.name,
        value: fontFamily.toStr,
      );
      state = state.copyWith(fontFamily: fontFamily, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> changeThemeMode(Thememode themeMode) async {
    state = state.copyWith(isLoading: true);
    try {
      state = state.copyWith(themeMode: themeMode);
      await _changeStatusBarColor(themeMode);
      await _box.saveData(
        key: Constants.themeKey.name,
        value: state.themeMode?.name,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> changeLanguage(Language language) async {
    state = state.copyWith(isLoading: true);
    try {
      state = state.copyWith(language: language);

      await _box.saveData(
        key: Constants.languageKey.name,
        value: language.toStr,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _changeStatusBarColor(Thememode themeMode) async {
    Color color;
    Brightness iconBrightness;

    if (state.themeMode == Thememode.light) {
      color = whiteColor;
      iconBrightness = Brightness.dark;
    } else if (state.themeMode == Thememode.dark) {
      color = greenSwatch.shade900;
      iconBrightness = Brightness.light;
    } else {
      final bool isDarkMode = themeMode == Thememode.dark;
      if (isDarkMode) {
        color = greenSwatch.shade900;
        iconBrightness = Brightness.light;
      } else {
        color = whiteColor;
        iconBrightness = Brightness.dark;
      }
    }

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness: iconBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarColor: color,
        systemNavigationBarIconBrightness: iconBrightness,
        systemNavigationBarDividerColor: color,
      ),
    );
  }
}

class SettingsState {
  SettingsState({
    this.fontSizes,
    this.themeMode,
    this.language,
    this.fontFamily,
    this.isLoading,
  });
  FontSizes? fontSizes;
  FontFamily? fontFamily;
  Thememode? themeMode;
  Language? language;
  bool? isLoading;

  SettingsState copyWith({
    FontSizes? fontSizes,
    FontFamily? fontFamily,
    Thememode? themeMode,
    Language? language,
    bool? isLoading,
  }) {
    return SettingsState(
      fontSizes: fontSizes ?? this.fontSizes,
      fontFamily: fontFamily ?? this.fontFamily,
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
