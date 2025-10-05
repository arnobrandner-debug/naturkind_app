import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../kids/stickers/sticker_store.dart';

class KidsStickersPage extends ConsumerWidget {
  const KidsStickersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(stickerStoreProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Sticker')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: 12,
        itemBuilder: (_, i) {
          final unlocked = store.isUnlocked(i);
          return InkWell(
            onTap: () => store.unlock(i),
            child: Container(
              decoration: BoxDecoration(
                color: unlocked ? Colors.amber.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(unlocked ? Icons.star : Icons.star_border, color: Colors.orange),
              ),
            ),
          );
        },
      ),
    );
  }
}

