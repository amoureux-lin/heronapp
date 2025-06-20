import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class SquareScreen extends ConsumerWidget {
  const SquareScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('广场页面内容', style: TextStyle(fontSize: 24)));
  }
}