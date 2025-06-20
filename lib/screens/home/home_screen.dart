
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heron/core/utils/AppUtil.dart';
import 'package:heron/localization/extension.dart';
import '../../localization/l10n/app_localizations.dart';
import '../../providers/app_state_provider.dart';
import 'package:heron/theme/app_theme_enum.dart';

import 'package:heron/theme/app_themes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final locale = ref.watch(localeProvider);
    final localeNotifier = ref.watch(localeProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.nav_home),centerTitle: true,),
      body: SafeArea(
        child: DefaultTabController(
          length: 3, // 你可以根据需要修改 tab 数量
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Home Page'),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                  Tab(text: 'Tab 3'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Center(child: TextButton(onPressed: (){
                  context.push('/game');
                }, child: Text("Controller obj: 1"))),
                Center(child: Text('Tab 2 Content')),
                Center(child: Text('Tab 3 Content')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


