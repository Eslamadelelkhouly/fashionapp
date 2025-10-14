import 'dart:developer';

import 'package:fashionapp/common/utils/enums.dart';
import 'package:fashionapp/src/category/models/category_models.dart';
import 'package:fashionapp/src/hook/result/categories_results.dart';
import 'package:fashionapp/src/hook/result/category_products_results.dart';
import 'package:fashionapp/src/product/models/product_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProduct fetchProducts(QueryType queryType) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> FetchData() async {
    isLoading.value = true;
    String baseUrl = 'https://cce2060bc083.ngrok-free.app';
    Uri url;

    try {
      switch (queryType) {
        case QueryType.all:
          url = Uri.parse('$baseUrl/api/products/');
          break;
        case QueryType.popular:
          url = Uri.parse('$baseUrl/api/products/popular/');
          break;
        case QueryType.unisex:
          url = Uri.parse('$baseUrl/api/products/byType/?clothesType=unisex');
          break;
        case QueryType.women:
          url = Uri.parse('$baseUrl/api/products/byType/?clothesType=women');
          break;
        case QueryType.men:
          url = Uri.parse('$baseUrl/api/products/byType/?clothesType=men');
          break;
        case QueryType.kids:
          url = Uri.parse('$baseUrl/api/products/byType/?clothesType=kids');
          break;
        default:
          url = Uri.parse('$baseUrl/api/products/popular/');
          break;
      }

      final response = await http.get(url);

      if (response.statusCode == 200) {
        products.value = productsFromJson(response.body);
        log(response.body.toString());
      }
    } catch (e) {
      error.value = e.toString();
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(
    () {
      FetchData();
      return;
    },
    [queryType.index],
  );

  void refetch() {
    isLoading.value = true;
    FetchData();
    log('REFETCH PRODUCTS');
  }

  return FetchProduct(
    products: products.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
