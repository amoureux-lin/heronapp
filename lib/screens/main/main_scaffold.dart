import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heron/core/utils/app_logger.dart';

import '../../localization/l10n/app_localizations.dart';
import '../../router/app_navigation_providers.dart';


class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('MainScaffold'));

  final StatefulNavigationShell navigationShell;

  static final List<String> navPaths = [
    '/home',
    '/party',
    '/square',
    '/club',
    '/my',
  ];

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      _initialized = true;

      Future.microtask(() {
        final path = GoRouterState.of(context).uri.toString();
        final currentIndex =
        MainScaffold.navPaths.indexWhere((p) => path.startsWith(p));

        if (currentIndex >= 0) {
          appLogger.d(currentIndex);
          // ✅ 安全地延迟写入 provider
          ref.read(bottomNavIndexProvider.notifier).state = currentIndex;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    debugPrint('MainScaffold: initState');
  }

  @override
  void dispose() {
    debugPrint('MainScaffold: dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = ref.watch(bottomNavIndexProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: l10n.nav_home),
          BottomNavigationBarItem(icon: Icon(Icons.celebration), label: l10n.nav_party),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: l10n.nav_plaza),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: l10n.nav_club),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: l10n.nav_profile),
        ],
        onTap: (int index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;

          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}