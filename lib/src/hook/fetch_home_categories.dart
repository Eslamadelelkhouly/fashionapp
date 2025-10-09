import 'package:fashionapp/src/category/models/category_models.dart';
import 'package:fashionapp/src/hook/result/categories_results.dart';
import 'package:fashionapp/src/hook/result/category_products_results.dart';
import 'package:fashionapp/src/product/models/product_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchCategories fetchHomeCategories() {
  final categories = useState<List<Categories>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  Future<void> FetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse(
          'https://fc676bed094a.ngrok-free.app/api/products/home-categories/');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        categories.value = categoriesFromJson(response.body);
      }
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(
    () {
      FetchData();
      return;
    },
    const [],
  );

  void refetch() {
    isLoading.value = true;
    FetchData();
  }

  return FetchCategories(
      categories: categories.value,
      isLoading: isLoading.value,
      error: error.value,
      refetch: refetch);
}
