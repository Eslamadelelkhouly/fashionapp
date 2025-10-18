import 'dart:developer';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/src/hook/result/category_products_results.dart';
import 'package:fashionapp/src/product/models/product_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProduct fetchWishlist() {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url =
          Uri.parse('https://b824cd0a8271.ngrok-free.app/api/wishlist/me/');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        log(response.body.toString());
        products.value = productsFromJson(response.body);
        log(products.value.toString());
      }
    } catch (e) {
      log(e.toString());
      error.value = e.toString();
      print(error.value);
    } finally {
      log(error.toString());
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  void refetch() {
    isLoading.value = true;
    fetchData();
  }

  return FetchProduct(
      products: products.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
