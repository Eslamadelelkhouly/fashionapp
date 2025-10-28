import 'package:fashionapp/src/adresses/model/address_model.dart';
import 'package:fashionapp/src/cart/models/cart_count_model.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:fashionapp/src/category/models/category_models.dart';
import 'package:flutter/material.dart';

class FetchAddress {
  final List<AddressModel> addressModels;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchAddress({
    required this.addressModels,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
