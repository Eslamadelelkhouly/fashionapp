import 'dart:convert';
import 'dart:developer';
import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/src/adresses/hooks/results/default_results.dart';
import 'package:fashionapp/src/adresses/model/address_model.dart';
import 'package:fashionapp/src/adresses/controllers/address_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

FetchDefaultAddress fetchDefaultAddress(BuildContext context) {
  final address = useState<AddressModel?>(null);
  final isLoading = useState(false);
  final error = useState<String?>(null);
  final accessToken = Storage().getString('accessToken');

  Future<void> fetchData() async {
    // تأكد إن الصفحة لسه موجودة
    if (!context.mounted) return;

    isLoading.value = true;

    try {
      final url = Uri.parse(
        'https://pos-firefox-relatives-denver.trycloudflare.com/api/address/me/',
      );

      log('🔑 Token: $accessToken');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      // بعد الاستجابة، تأكد إن الـ widget لسه موجود
      if (!context.mounted) return;

      if (response.statusCode == 200) {
        log('🟢 Response: ${response.body}');
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          address.value = AddressModel.fromJson(decoded);
        } else if (decoded is List && decoded.isNotEmpty) {
          address.value = AddressModel.fromJson(decoded.first);
        } else {
          error.value = 'Invalid response format';
        }

        // ✅ خزّن العنوان في AddressNotifier
        if (address.value != null && context.mounted) {
          Provider.of<AddressNotifier>(context, listen: false)
              .setAddress(address.value!);
        }

        log('✅ Address fetched successfully');
      } else {
        error.value = 'Failed: ${response.statusCode}';
      }
    } catch (e) {
      log('❌ Error: $e');
      if (context.mounted) {
        error.value = e.toString();
      }
    } finally {
      if (context.mounted) {
        isLoading.value = false;
      }
    }
  }

  // تشغيل الفنكشن أول مرة فقط بعد بناء الصفحة
  useEffect(() {
    if (accessToken != null) {
      fetchData();
    }
    return null; // لازم return null في useEffect
  }, const []);

  return FetchDefaultAddress(
    addressModel: address.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: fetchData,
  );
}
