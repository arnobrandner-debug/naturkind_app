import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/post.dart';
import '../../profile/profile_prefs.dart';
import '../../data/repositories/content_repository.dart';
import 'post_list_item.dart';

final postsProvider = FutureProvider.autoDispose<List<Post>>((ref) async {
  final repo = ref.watch(contentRepositoryProvider);
  return repo.getPosts(page: 1);
});

class FeedPage extends ConsumerWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(postsProvider);
    final profile = ref.watch(profilePrefsProvider);
    final interests = profile.interests.map((e) => e.toLowerCase()).toList();
    final name = profile.name?.trim();
    final hour = DateTime.now().hour;
    final greet = hour < 12 ? 'Guten Morgen' : (hour < 18 ? 'Guten Tag' : 'Guten Abend');
    final titleText = name == null || name.isEmpty ? 'Naturkind' : '$greet, $name 🌿';
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.local_florist),
        title: Text(titleText),
        actions: [
          IconButton(
            tooltip: 'Einwilligung',
            icon: const Icon(Icons.privacy_tip_outlined),
            onPressed: () => context.push('/consent'),
          ),
          IconButton(
            tooltip: 'Einstellungen',
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
          IconButton(
            tooltip: 'Kids',
            icon: const Icon(Icons.toys),
            onPressed: () => context.push('/kids'),
          ),
        ],
      ),
      body: asyncPosts.when(
        data: (posts) {
          // Einfache clientseitige Filterung anhand Interessen (Titel/Excerpt)
          final filtered = interests.isEmpty
              ? posts
              : posts.where((p) {
                  final t = p.title.toLowerCase();
                  final x = p.excerpt.toLowerCase();
                  return interests.any((i) => t.contains(i) || x.contains(i));
                }).toList();
          return RefreshIndicator(
          onRefresh: () async => ref.refresh(postsProvider),
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemBuilder: (ctx, i) => PostListItem(
              post: filtered[i],
              onTap: () {
                context.push('/article/${filtered[i].id}');
              },
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemCount: filtered.length,
          ),
        );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text('Fehler beim Laden: $e'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/epaper'),
        label: const Text('E-Paper'),
        icon: const Icon(Icons.picture_as_pdf),
      ),
    );
  }
}
