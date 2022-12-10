import 'package:flutter/material.dart';

class MyTheme {
  static final darkTheme = ThemeData(
    colorSchemeSeed: Colors.yellow.shade400,
    brightness: Brightness.dark,
    useMaterial3: true,
  );
  static final lightTheme = ThemeData(
    colorSchemeSeed: Colors.yellow.shade400,
    brightness: Brightness.light,
    useMaterial3: true,
  );
}
