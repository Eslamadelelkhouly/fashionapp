import 'package:fashionapp/src/category/models/category_models.dart';
import 'package:fashionapp/src/hook/result/categories_results.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchCategories fetchHomeCategories() {
  final categories = useState<List<Categories>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  final isMounted = useIsMounted(); // ✅ للتحقق إذا الـ widget لسه موجود

  Future<void> fetchData() async {
    isLoading.value = true;
    try {
      Uri url = Uri.parse(
          'https://industrial-returning-documents-recognize.trycloudflare.com/api/products/home-categories/');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        if (isMounted()) {
          // ✅ تأكد إن الـ widget لسه موجود
          categories.value = categoriesFromJson(response.body);
        }
      }
    } catch (e) {
      if (isMounted()) {
        error.value = e.toString();
      }
    } finally {
      if (isMounted()) {
        isLoading.value = false;
      }
    }
  }

  useEffect(() {
    fetchData();
    return null; // ✅ مهم ترجع null مش void
  }, const []);

  void refetch() {
    if (isMounted()) {
      isLoading.value = true;
      fetchData();
    }
  }

  return FetchCategories(
    categories: categories.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
