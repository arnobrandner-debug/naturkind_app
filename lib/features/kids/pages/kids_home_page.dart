import 'package:flutter/material.dart';
import '../../kids/ui/kids_card.dart';
import '../../../theme/strings.dart';

class KidsHomePage extends StatelessWidget {
  const KidsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      (Icons.brush, 'Basteln', 'basteln'),
      (Icons.park, 'Entdecken', 'entdecken'),
      (Icons.menu_book, 'Vorlesen', 'vorlesen'),
      (Icons.headset, 'Hören', 'hoeren'),
      (Icons.directions_run, 'Bewegung', 'bewegung'),
      (Icons.extension, 'Rätsel', 'raetsel'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Kids')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(kidsGreeting, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(12),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                for (final t in tiles)
                  KidsCard(
                    icon: t.$1,
                    label: t.$2,
                    onTap: () => Navigator.of(context).pushNamed('/kids/${t.$3}'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

