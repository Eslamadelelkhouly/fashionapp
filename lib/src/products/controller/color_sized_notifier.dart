import 'package:flutter/widgets.dart';

class ColorSizedNotifier with ChangeNotifier {
  String _sizes = '';
  String _colors = '';

  String get size => _sizes;
  String get color => _colors;

  void setSize(String s) {
    if (_sizes == s) {
      _sizes = '';
    } else {
      _sizes = s;
    }
    notifyListeners();
  }

  void setColor(String c) {
    if (_colors == c) {
      _colors = '';
    } else {
      _colors = c;
    }
    notifyListeners();
  }
}
