import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class PartyScreen extends ConsumerWidget {
  const PartyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(child: Text('派对页面内容', style: TextStyle(fontSize: 24)));
  }
}