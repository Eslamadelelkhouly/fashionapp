import 'package:fashionapp/src/category/models/category_models.dart';
import 'package:fashionapp/src/product/models/product_model.dart';
import 'package:flutter/widgets.dart';

class FetchProduct {
  final List<Products> products;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchProduct({
    required this.products,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
