// lib/providers/app_navigation_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 提供底部导航栏当前选中索引的 StateProvider
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// 提供当前选中路径的 StateProvider (可选，用于更复杂的导航同步)
final currentPathProvider = StateProvider<String>((ref) => '/');