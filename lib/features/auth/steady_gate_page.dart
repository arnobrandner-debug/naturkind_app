import 'package:flutter/material.dart';

class SteadyGatePage extends StatelessWidget {
  const SteadyGatePage({super.key});
  static const steadyUrl = 'https://steadyhq.com/de/naturkindmagazin';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Naturkind PLUS')),
      body: const Center(child: Text('Login/Link: $steadyUrl')),
    );
  }
}

