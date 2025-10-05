import 'package:flutter/material.dart';
import '../../kids/ui/kids_chip.dart';
import '../../../theme/strings.dart';

class KidsListPage extends StatefulWidget {
  const KidsListPage({super.key, required this.tag});
  final String tag;

  @override
  State<KidsListPage> createState() => _KidsListPageState();
}

class _KidsListPageState extends State<KidsListPage> {
  final Set<String> _filters = {};

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kids – ${widget.tag}')),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Wrap(
              spacing: 8,
              children: [
                for (final f in ['leicht','mittel','schwer'])
                  KidsChip(
                    label: f,
                    selected: _filters.contains(f),
                    onSelected: (v) => setState(() => v ? _filters.add(f) : _filters.remove(f)),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            for (int i=1; i<=8; i++)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.local_florist),
                  title: Text('Item #$i'),
                  subtitle: const Text('Kurzer Platzhaltertext …'),
                  onTap: () => Navigator.of(context).pushNamed('/kids/item/$i'),
                ),
              ),
            const SizedBox(height: 40),
            const Center(child: Text(emptyList)),
          ],
        ),
      ),
    );
  }
}

