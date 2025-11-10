import 'dart:developer';
import 'package:fashionapp/common/utils/enums.dart';
import 'package:fashionapp/src/product/models/product_model.dart';
import 'package:fashionapp/src/hook/result/category_products_results.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchProduct fetchProducts(QueryType queryType) {
  final products = useState<List<Products>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  final isMounted = useIsMounted(); // ✅ للتحقق قبل التحديث

  Future<void> fetchData() async {
    if (!isMounted()) return; // حماية إضافية
    isLoading.value = true;
    String baseUrl = 'https://pos-firefox-relatives-denver.trycloudflare.com';
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
      }

      final response = await http.get(url);

      if (response.statusCode == 200 && isMounted()) {
        products.value = productsFromJson(response.body);
        log('✅ Products fetched successfully');
      }
    } catch (e) {
      if (isMounted()) {
        // ✅ تأكد إن الـ widget لسه mounted
        error.value = e.toString();
        log('❌ Error: $e');
      }
    } finally {
      if (isMounted()) {
        // ✅ تأكد إنك ما تحدثش بعد الـ dispose
        isLoading.value = false;
      }
    }
  }

  useEffect(() {
    fetchData();
    return null; // ✅ لازم ترجع null مش void
  }, [queryType.index]);

  void refetch() {
    if (isMounted()) {
      isLoading.value = true;
      fetchData();
      log('🔄 Refetch products');
    }
  }

  return FetchProduct(
    products: products.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
