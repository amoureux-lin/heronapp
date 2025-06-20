import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

enum AppLocale {
  system,
  zhCN,
  enUS,
  jaJP,
  koKR,
}

extension AppLocaleExt on AppLocale {
  String get label {
    switch (this) {
      case AppLocale.system:
        return '跟随系统';
      case AppLocale.zhCN:
        return '简体中文';
      case AppLocale.enUS:
        return 'English';
      case AppLocale.jaJP:
        return '日本語';
      case AppLocale.koKR:
        return '한국어';
    }
  }

  Locale? get locale {
    switch (this) {
      case AppLocale.system:
        return null;
      case AppLocale.zhCN:
        return const Locale('zh', 'CN');
      case AppLocale.enUS:
        return const Locale('en', 'US');
      case AppLocale.jaJP:
        return const Locale('ja', 'JP');
      case AppLocale.koKR:
        return const Locale('ko', 'KR');
    }
  }

  static AppLocale fromLocale(Locale? locale) {
    if (locale == null) return AppLocale.system;
    final lang = locale.languageCode;
    final country = locale.countryCode;

    return AppLocale.values.firstWhere(
          (e) => e.locale?.languageCode == lang && e.locale?.countryCode == country,
      orElse: () => AppLocale.system,
    );
  }
}