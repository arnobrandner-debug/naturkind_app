import 'package:flutter/material.dart';

ThemeData kidsTheme() {
  const seed = Colors.green;
  const bg = Color(0xFFF6FAF6);
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    scaffoldBackgroundColor: bg,
    cardTheme: const CardThemeData(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
    ),
    chipTheme: const ChipThemeData(shape: StadiumBorder()),
  );
}
