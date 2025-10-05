import 'package:flutter/material.dart';

class KidsChip extends StatelessWidget {
  const KidsChip({super.key, required this.label, this.selected = false, this.onSelected});
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
    );
  }
}

