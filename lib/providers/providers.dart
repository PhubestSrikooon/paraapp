import 'package:flutter/material.dart';

class flashLight with ChangeNotifier {
  bool _flashlight = false;

  bool get count => _flashlight;

  void change() {
    _flashlight = !_flashlight; // เพิ่มจำนวน
    notifyListeners(); // แจ้งเตือนการเปลี่ยนแปลงข้อมูล
  }
}
