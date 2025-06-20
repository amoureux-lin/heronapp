// lib/config/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 导入 Riverpod
import 'package:heron/screens/game/game_screen.dart';
import 'package:heron/screens/main/main_scaffold.dart';

import 'package:heron/screens/home/home_screen.dart';
import 'package:heron/screens/party/party_screen.dart';
import 'package:heron/screens/settings/SettingsPage.dart';
import 'package:heron/screens/square/square_screen.dart';
import 'package:heron/screens/club/club_screen.dart';
import 'package:heron/screens/my/my_screen.dart';

import '../screens/splash/splash_screen.dart';
import 'app_navigation_providers.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

// ⭐ 核心修改点：GoRouterRefreshStream 现在通过 ref.listen 监听 Provider
class GoRouterRefreshStream extends ChangeNotifier {
  final Ref _ref; // 接收 Riverpod 的 Ref
  final ProviderListenable<int> _provider; // 接收要监听的 Provider

  late final ProviderSubscription<int> _subscription; // 用于管理监听

  GoRouterRefreshStream(this._ref, this._provider) {
    // 使用 ref.listen 订阅 Provider 的状态变化
    _subscription = _ref.listen<int>(
      _provider,
          (previous, next) {
        // 当 Provider 状态变化时，通知 GoRouter 刷新
        if (previous != next) { // 仅在值实际改变时通知，避免不必要的刷新
          notifyListeners();
        }
      },
      fireImmediately: false, // 不立即触发监听，让 GoRouter 管理初始路由状态
    );
  }

  @override
  void dispose() {
    _subscription.close(); // 在 dispose 时关闭订阅
    super.dispose();
  }
}

// 定义 GoRouter 实例
final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',

    // ⭐ 核心修改点：将 ref 和要监听的 Provider 传递给 GoRouterRefreshStream
    refreshListenable: GoRouterRefreshStream(ref, bottomNavIndexProvider),

    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        name: 'splash',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // 从 GoRouter 到 Riverpod 的同步：确保底部导航栏的选中状态与 GoRouter 同步
            if (ref.read(bottomNavIndexProvider) != navigationShell.currentIndex) {
              ref.read(bottomNavIndexProvider.notifier).state = navigationShell.currentIndex;
            }
            ref.read(currentPathProvider.notifier).state = state.uri.toString();
          });
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          // 首页分支
          StatefulShellBranch(
            navigatorKey: _shellNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/home',
                name: 'home',
                builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
              ),
            ],
          ),
          // 派对分支
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/party',
                name: 'party',
                builder: (BuildContext context, GoRouterState state) => const PartyScreen(),
              ),
            ],
          ),
          // 广场分支
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/square',
                name: 'square',
                builder: (BuildContext context, GoRouterState state) => const SquareScreen(),
              ),
            ],
          ),
          // 俱乐部分支
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/club',
                name: 'club',
                builder: (BuildContext context, GoRouterState state) => const ClubScreen(),
              ),
            ],
          ),
          // 我的分支
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/my',
                name: 'my',
                builder: (BuildContext context, GoRouterState state) => const MyScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/game',
        name: 'game',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) => const GameScreen(),
      ),
    ],
  );
});
