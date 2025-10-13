import 'package:fashionapp/src/cart/models/cart_count_model.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:fashionapp/src/category/models/category_models.dart';
import 'package:flutter/material.dart';

class FetchCart {
  final List<CartModel> listCartModel;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCart({
    required this.listCartModel,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
