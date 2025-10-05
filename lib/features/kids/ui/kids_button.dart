import 'package:flutter/material.dart';

class KidsButton extends StatelessWidget {
  const KidsButton({super.key, required this.label, this.onPressed});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

