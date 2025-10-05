import 'package:flutter/material.dart';

class EpaperPage extends StatelessWidget {
  const EpaperPage({super.key, required this.pdfUrl, required this.title});
  final String pdfUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('PDF: $pdfUrl')),
    );
  }
}

