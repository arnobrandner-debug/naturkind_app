import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsentPage extends ConsumerWidget {
  const ConsentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Datenschutz & Einwilligung')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Platzhalter für Einwilligungen (Benachrichtigungen/Fehlerberichte).'),
        ],
      ),
    );
  }
}

