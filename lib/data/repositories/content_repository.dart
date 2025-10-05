import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/post.dart';

final contentRepositoryProvider = Provider<ContentRepository>((ref) => ContentRepository());

class ContentRepository {
  Future<List<Post>> getPosts({int page = 1}) async {
    return List.generate(
      5,
      (i) => Post(
        id: i + 1,
        title: 'Post #${i + 1}',
        excerpt: 'Kurzbeschreibung…',
        content: 'Inhalt…',
      ),
    );
  }

  Future<Post> getPost(int id) async => Post(id: id, title: 'Post #$id', excerpt: '', content: 'Inhalt…');
}

