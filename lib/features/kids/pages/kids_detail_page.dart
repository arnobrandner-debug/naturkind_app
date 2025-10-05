import 'package:flutter/material.dart';
import '../../kids/ui/kids_button.dart';
import '../../../theme/strings.dart';

class KidsDetailPage extends StatelessWidget {
  const KidsDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Projekt #$id')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(child: Icon(Icons.image, size: 64)),
          ),
          const SizedBox(height: 16),
          const Text('Schritte', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          for (final s in ['Material sammeln','So geht’s','Aufräumen'])
            ListTile(leading: const Icon(Icons.check_circle_outline), title: Text(s)),
          const SizedBox(height: 16),
          KidsButton(label: 'Vorlesen', onPressed: () { /* TODO: TTS */ }),
          const SizedBox(height: 8),
          KidsButton(
            label: ctaFinishSticker,
            onPressed: () => Navigator.of(context).pushNamed('/kids/stickers'),
          ),
        ],
      ),
    );
  }
}

