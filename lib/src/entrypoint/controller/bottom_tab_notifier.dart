
import 'package:flutter/material.dart';

class TabNotifier with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void setcurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}