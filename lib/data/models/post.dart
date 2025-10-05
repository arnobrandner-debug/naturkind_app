class Post {
  final int id;
  final String title;
  final String excerpt;
  final String content;
  final String? imageUrl;

  const Post({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    this.imageUrl,
  });
}

