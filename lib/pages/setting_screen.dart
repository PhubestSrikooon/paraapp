import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  final BuildContext context;
  const SettingPage({super.key, required this.context});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    context = this.context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Container(
        child: ElevatedButton(
            onPressed: () {
              null;
            },
            child: const Text("Hi")),
      ),
    );
  }
}
