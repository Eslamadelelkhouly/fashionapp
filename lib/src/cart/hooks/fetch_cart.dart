import 'dart:convert';
import 'dart:developer';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/src/cart/hooks/results/cart_result.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchCart fetchCart() {
  final cart = useState<List<CartModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse('https://c5dd61e45072.ngrok-free.app/api/cart/me/');
      log('🔑 Token: $accessToken');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 200) {
        log('🟢 Response: ${response.body}');
        final decoded = jsonDecode(response.body);

        List<dynamic> jsonList = [];
        if (decoded is List) {
          jsonList = decoded;
        } else if (decoded is Map && decoded.containsKey('results')) {
          jsonList = decoded['results'];
        } else if (decoded is Map && decoded.containsKey('data')) {
          jsonList = decoded['data'];
        }

        cart.value = jsonList.map((e) => CartModel.fromJson(e)).toList();
        log('✅ Cart fetched: ${cart.value.length} items');
      } else {
        error.value = 'Failed: ${response.statusCode}';
      }
    } catch (e) {
      log('❌ Error: $e');
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return;
  }, const []);

  return FetchCart(
    listCartModel: cart.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: fetchData,
  );
}
