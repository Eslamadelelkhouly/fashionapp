import 'dart:developer';

import 'package:fashionapp/src/hook/result/category_products_results.dart';
import 'package:fashionapp/src/product/models/product_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProduct fetchProductsByCategories(int categoryId) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse(
          'https://cce2060bc083.ngrok-free.app/api/products/category/?category=$categoryId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        log(response.body.toString());
        products.value = productsFromJson(response.body);
        log(products.value.toString());
      }
    } catch (e) {
      log(e.toString());
      error.value = e.toString();
    } finally {
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
