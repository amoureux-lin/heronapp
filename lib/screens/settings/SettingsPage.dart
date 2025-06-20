import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:heron/core/utils/AppUtil.dart';
import 'package:heron/localization/extension.dart';
import 'package:heron/localization/l10n/app_localizations.dart';
import 'package:heron/providers/app_state_provider.dart';
import 'package:heron/theme/app_theme_enum.dart';
import 'package:heron/theme/app_themes.dart';

import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    final locale = ref.watch(localeProvider);
    final localeNotifier = ref.watch(localeProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.nav_home),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/my'); // 👈 返回到你的个人页面，或 ref.read(...) 也行
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: context.colors.brand,
                  ),
                  Text("当前主题: ${theme.label}",),
                  DropdownButton<AppTheme>(
                    value: theme,
                    items: AppTheme.values.map((theme) {
                      return DropdownMenuItem<AppTheme>(
                        value: theme,
                        child: Text(theme.label),
                      );
                    }).toList(),
                    onChanged: (theme) {
                      if (theme != null) themeNotifier.setTheme(theme);
                    },
                  ),
                  ElevatedButton(
                    onPressed: themeNotifier.cycleTheme,
                    child: const Text("循环切换主题"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // ListTile(
              //   title: Text(loc.home_change_language),
              //   subtitle: Text(locale.label),
              //   trailing: ElevatedButton(
              //     onPressed: () {
              //       final next = (locale?.languageCode == 'en')
              //           ? const Locale('zh')
              //           : const Locale('en');
              //       // 切换语言
              //       ref.read(localeProvider.notifier).change(next);
              //     },
              //     child: Text(loc.home_change_language),
              //   ),
              // ),
              Column(
                children: [
                  Text("当前语言: ${locale.label}"),
                  DropdownButton<AppLocale>(
                    value: locale,
                    items: AppLocale.values.map((locale) {
                      return DropdownMenuItem<AppLocale>(
                        value: locale,
                        child: Text(locale.label),
                      );
                    }).toList(),
                    onChanged: (locale) {
                      if (locale != null) localeNotifier.change(locale);
                    },
                  ),
                  ElevatedButton(
                    onPressed: localeNotifier.cycleTheme,
                    child: const Text("循环切换语言"),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        AppUtil.showSnackbar(context, '这是一条提示');
                      },
                      child: const Text('显示 SnackBar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        AppUtil.showAlert(
                            context,
                            title: '操作成功',
                            content: '你的请求已完成',
                            confirmText:"确定"
                        );
                      },
                      child: const Text('显示提示弹窗'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final ok = await AppUtil.showConfirm(
                            context,
                            title: '删除确认',
                            content: '你确定要删除该项吗？',
                            confirmText:"确定",
                            cancelText:"取消"
                        );
                        AppUtil.showSnackbar(context, ok ? '点击了确定' : '点击了取消');
                      },
                      child: const Text('显示确认弹窗'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        AppUtil.showLoading(context, text: '处理中...');
                        await Future.delayed(const Duration(seconds: 1));
                        AppUtil.closeDialog(context);
                      },
                      child: const Text('显示 Loading 遮罩'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
