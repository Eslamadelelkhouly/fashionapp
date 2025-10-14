import 'dart:convert';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/src/cart/hooks/results/cart_count_result.dart';
import 'package:fashionapp/src/cart/models/cart_count_model.dart';
import 'package:fashionapp/src/category/models/category_models.dart';
import 'package:fashionapp/src/hook/result/categories_results.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchCartCount fetchCategories() {
  final initalData = CartCountModel(cartCount: 0);
  final count = useState<CartCountModel>(initalData);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  final accessToken = Storage().getString('accessToken');
  Future<void> FetchData() async {
    isLoading.value = true;

    try {
      Uri url =
          Uri.parse('https://cce2060bc083.ngrok-free.app/api/cart/count/');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      if (response.statusCode == 200) {
        final jsondecode = jsonDecode(response.body);
        count.value = CartCountModel.fromJson(jsondecode);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(
    () {
      if (accessToken != null) {
        FetchData();
      }
      return;
    },
    const [],
  );

  void refetch() {
    isLoading.value = true;
    FetchData();
  }

  return FetchCartCount(
      cartCountModel: count.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
