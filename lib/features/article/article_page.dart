import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticlePage extends ConsumerWidget {
  const ArticlePage({super.key, required this.postId});
  final int postId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Artikel #$postId')),
      body: const Center(child: Text('Artikel-Platzhalter')),
    );
  }
}

