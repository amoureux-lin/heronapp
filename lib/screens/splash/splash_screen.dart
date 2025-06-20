import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:heron/core/utils/app_logger.dart';
import '../../providers/app_state_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final init = ref.watch(appInitializerProvider);
    ref.watch(appInitializerProvider);

    ref.listen(appInitializerProvider, (prev, next) {
      // next.whenOrNull(
      //   data: (_) => context.go('/home'),
      //   error: (e, _) {
      //     appLogger.e('初始化失败: $e');
      //     context.go('/home');
      //   },
      // );
      context.go('/home');
    });
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Loading..")
          ],
        ),
      ),
    );
  }
}
