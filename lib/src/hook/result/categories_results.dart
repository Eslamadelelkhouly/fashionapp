import 'package:fashionapp/src/category/models/category_models.dart';
import 'package:flutter/material.dart';

class FetchCategories {
  final List<Categories> categories;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchCategories(
      {required this.categories,
      required this.isLoading,
      required this.error,
      required this.refetch});
}
