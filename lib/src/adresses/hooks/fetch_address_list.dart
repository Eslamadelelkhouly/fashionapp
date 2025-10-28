import 'dart:convert';
import 'dart:developer';
import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/src/adresses/hooks/results/ad_list_results.dart';
import 'package:fashionapp/src/adresses/model/address_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchAddress fetchAddress() {
  final addresses = useState<List<AddressModel>>([]);
  final isLoading = useState(false);
  final error = useState<String?>(null);

  Future<void> fetchData() async {
    isLoading.value = true;
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse(
          'https://industrial-returning-documents-recognize.trycloudflare.com/api/address/addresslist/');
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

        List<AddressModel> parsedList = [];

        // الحالة الأولى: الـ API بيرجع قائمة كاملة
        if (decoded is List) {
          parsedList = decoded.map((e) => AddressModel.fromJson(e)).toList();
        }
        // الحالة الثانية: بيرجع object واحد
        else if (decoded is Map<String, dynamic>) {
          parsedList = [AddressModel.fromJson(decoded)];
        } else {
          error.value = 'Invalid response format';
        }

        addresses.value = parsedList;
        log('✅ Address fetched successfully (${addresses.value.length} items)');
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

  return FetchAddress(
    addressModels: addresses.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: fetchData,
  );
}
