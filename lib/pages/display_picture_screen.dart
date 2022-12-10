import 'package:flutter/material.dart';
import 'dart:io';

class DisplayPictureScreen extends StatelessWidget {
  final imageFile;
  const DisplayPictureScreen({super.key, this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display the Picture'),
      ),
      body: Image.file(File(imageFile.path)),
    );
  }
}
