import 'package:flutter/material.dart';
import '../../data/models/post.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post, required this.onTap});
  final Post post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.excerpt),
        onTap: onTap,
      ),
    );
  }
}

