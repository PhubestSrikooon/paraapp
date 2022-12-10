import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    context = this.context;
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Container(
          child: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Text(
            "Copyright © 2022 all rights reserved",
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      )),
    );
  }
}
