import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:heron/theme/app_theme_enum.dart';
import 'package:heron/theme/app_themes.dart';

import '../core/network/api.dart';
import '../localization/extension.dart';


final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppTheme> {
  static const _key = 'app_theme';
  late SharedPreferences _prefs;

  ThemeNotifier() : super(AppTheme.light) {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    final index = _prefs.getInt(_key);
    if (index != null && index < AppTheme.values.length) {
      state = AppTheme.values[index];
    }
  }

  /// 设置为指定主题
  void setTheme(AppTheme theme) {
    state = theme;
    _prefs.setInt(_key, theme.index);
  }

  /// 循环切换
  void cycleTheme() {
    final next = (state.index + 1) % AppTheme.values.length;
    setTheme(AppTheme.values[next]);
  }

  /// 获取当前 ThemeData（供 UI 使用）
  ThemeData get currentThemeData => appThemes[state]!;
}



final localeProvider = StateNotifierProvider<LocaleNotifier, AppLocale>(
      (ref) => LocaleNotifier(),
);

class LocaleNotifier extends StateNotifier<AppLocale> {
  LocaleNotifier() : super(AppLocale.system) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('app_locale') ?? 0;
    if (index >= 0 && index < AppLocale.values.length) {
      state = AppLocale.values[index];
    }
  }

  Future<void> change(AppLocale locale) async {
    state = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('app_locale', locale.index);
  }

  /// 循环切换
  void cycleTheme() {
    final next = (state.index + 1) % AppLocale.values.length;
    change(AppLocale.values[next]);
  }
}


final appInitializerProvider = FutureProvider<void>((ref) async {
  final api = ref.read(apiProvider);
  final result = await api.getConfig({'env': 'prod'});
  if (result.success) {
    // 存储配置，例如保存到全局 provider（可选）
    // ref.read(appConfigProvider.notifier).state = result.data;
  } else {
    throw Exception('启动配置加载失败: ${result.message}');
  }
});