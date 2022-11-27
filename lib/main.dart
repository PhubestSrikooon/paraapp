import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/main_screen.dart';
import 'theme_provider.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.system,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        title: "Para App",
        home: const main_screen());
  }
}
