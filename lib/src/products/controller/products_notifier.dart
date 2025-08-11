import 'package:fashionapp/src/product/models/product_model.dart';
import 'package:flutter/widgets.dart';

class ProductsNotifier with ChangeNotifier {
  Products? product;

  void setProduct(Products p) {
    product = p;
    notifyListeners();
  }
}
