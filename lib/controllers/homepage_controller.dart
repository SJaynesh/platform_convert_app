import 'package:flutter/material.dart';

class HomePageController extends ChangeNotifier {
  DateTime? currentDate;
  int hour = 0, minutes = 0;

  void setDateTime({required DateTime? date}) {
    currentDate = date;

    notifyListeners();
  }

  void setHourAndMinute({required int h, required int m}) {
    hour = h;
    minutes = m;

    notifyListeners();
  }
}
