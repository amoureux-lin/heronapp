import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heron/core/utils/app_logger.dart';
import 'package:heron/providers/app_state_provider.dart';
import 'package:heron/router/app_router.dart';
import 'package:heron/localization/extension.dart';
import 'package:heron/theme/app_theme_enum.dart';
import 'package:heron/theme/app_themes.dart';
import 'core/network/api.dart';
import 'localization/l10n/app_localizations.dart';


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoRouter router = ref.watch(goRouterProvider);

    final appTheme = ref.watch(themeProvider);
    final themeData = appThemes[appTheme]!;
    final localeEnum = ref.watch(localeProvider);

    return MaterialApp.router(
      theme: themeData,
      darkTheme: appThemes[AppTheme.dark],
      themeMode: ThemeMode.light, // 如果你用自定义主题就不要 ThemeMode.system
      locale: localeEnum.locale,
      ///路由
      routerConfig: router,
      ///多语言实现代理
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner:false,
    );
  }
}
