import 'package:fashionapp/src/cart/models/cart_count_model.dart';
import 'package:fashionapp/src/category/models/category_models.dart';
import 'package:flutter/material.dart';

class FetchCartCount {
  final CartCountModel cartCountModel;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCartCount({
    required this.cartCountModel,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
