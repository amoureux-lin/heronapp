import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
class MyScreen extends ConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("个人中心"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: (){
              // context.push('/settings');
              // context.go('/settings');
              context.goNamed('settings');
            },
          ),
        ],
      ),
      body: const Center(child: Text('我的页面内容', style: TextStyle(fontSize: 24))),
    );
  }
}