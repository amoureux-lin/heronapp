import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class ClubScreen extends ConsumerWidget {
  const ClubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('俱乐部页面内容', style: TextStyle(fontSize: 24)));
  }
}