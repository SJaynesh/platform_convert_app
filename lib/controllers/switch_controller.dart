import 'package:flutter/material.dart';

class SwitchController extends ChangeNotifier {
  bool isIOS = false;

  void changePlatform() {
    isIOS = !isIOS;

    notifyListeners();
  }
}
