import 'dart:convert';
import 'dart:developer';
import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/src/adresses/hooks/results/default_results.dart';
import 'package:fashionapp/src/adresses/model/address_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;

FetchDefaultAddress fetchDefaultAddress() {
  final address = useState<AddressModel?>(null);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  String? accessToken = Storage().getString('accessToken');

  Future<void> fetchData() async {
    isLoading.value = true;

    try {
      Uri url = Uri.parse(
          'https://industrial-returning-documents-recognize.trycloudflare.com/api/address/me/');
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

        // الحالة الأولى: الـ API بيرجع object واحد
        if (decoded is Map<String, dynamic>) {
          address.value = AddressModel.fromJson(decoded);
        }
        // الحالة الثانية: الـ API بيرجع قائمة فيها عنوان واحد
        else if (decoded is List && decoded.isNotEmpty) {
          address.value = AddressModel.fromJson(decoded.first);
        } else {
          error.value = 'Invalid response format';
        }

        log('✅ Address fetched successfully');
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
    if (accessToken != null) {
      fetchData();
    }

    return;
  }, const []);

  return FetchDefaultAddress(
    addressModel: address.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: fetchData,
  );
}
