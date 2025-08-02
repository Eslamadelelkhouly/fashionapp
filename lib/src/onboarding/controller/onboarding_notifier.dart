import 'package:flutter/material.dart';

class OnboardingNotifier extends ChangeNotifier {
  int _selectedPage = 0;

  int get selectedPage => _selectedPage;

  set selectedPage(int page) {
    _selectedPage = page;
    print(page);
    notifyListeners();
  }
}
