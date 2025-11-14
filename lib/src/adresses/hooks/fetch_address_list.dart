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
  final isMounted = useIsMounted(); // ✅ Add this

  Future<void> fetchData() async {
    if (!isMounted()) return;

    isLoading.value = true;
    String? accessToken = Storage().getString('accessToken');

    try {
      Uri url = Uri.parse(
          'https://midi-circuit-enjoy-directory.trycloudflare.com/api/address/addresslist/');
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

        if (decoded is List) {
          parsedList = decoded.map((e) => AddressModel.fromJson(e)).toList();
        } else if (decoded is Map<String, dynamic>) {
          parsedList = [AddressModel.fromJson(decoded)];
        } else {
          if (isMounted()) error.value = 'Invalid response format';
        }

        if (isMounted()) addresses.value = parsedList;
        log('✅ Address fetched successfully (${parsedList.length} items)');
      } else {
        if (isMounted()) error.value = 'Failed: ${response.statusCode}';
      }
    } catch (e) {
      log('❌ Error: $e');
      if (isMounted()) error.value = e.toString();
    } finally {
      if (isMounted()) isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return; // no cleanup
  }, const []);

  return FetchAddress(
    addressModels: addresses.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: fetchData,
  );
}
