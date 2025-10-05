import 'package:flutter/material.dart';
import '../../theme/strings.dart';

class ParentsPage extends StatefulWidget {
  const ParentsPage({super.key});

  @override
  State<ParentsPage> createState() => _ParentsPageState();
}

class _ParentsPageState extends State<ParentsPage> {
  int _minutes = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Elternbereich')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Zeitlimit'),
          Wrap(
            spacing: 8,
            children: [
              for (final m in [20,30,45])
                ChoiceChip(
                  label: Text('$m Min'),
                  selected: _minutes == m,
                  onSelected: (_) => setState(() => _minutes = m),
                ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Downloads (Platzhalter)'),
          for (int i=1;i<=3;i++)
            ListTile(
              leading: const Icon(Icons.download),
              title: Text('Download #$i'),
              subtitle: const Text('Nicht verfügbar – TODO Caching'),
            ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.volunteer_activism),
              title: const Text('Unterstützt von Naturfreunde e.V.'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(adsBadge),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

