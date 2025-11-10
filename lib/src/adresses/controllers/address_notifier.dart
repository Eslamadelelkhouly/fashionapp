// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:fashionapp/common/models/api_error_model.dart';
import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/utils/app_routes.dart';
import 'package:fashionapp/common/widgets/error_modal.dart';
import 'package:fashionapp/src/adresses/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class AddressNotifier with ChangeNotifier {
  // ===============================
  // 🏠 Address Model
  // ===============================
  AddressModel? address;

  Function refetchA = () {};
  void setRefetch(Function r) {
    refetchA = r;
    log('Bosten chilticks');
  }

  void setAddress(AddressModel a) {
    address = a;
    notifyListeners();
  }

  void clearAddress() {
    address = null;
    notifyListeners();
  }

  // ===============================
  // 📍 Address Type
  // ===============================
  List<String> addressTypes = ['Home', 'School', 'Office'];
  String _addressType = '';

  void setAddressType(String type) {
    _addressType = type;
    notifyListeners();
  }

  String get addresstype => _addressType;

  void clearAddressType() {
    _addressType = '';
    notifyListeners();
  }

  // ===============================
  // ⭐ Default Toggle
  // ===============================
  bool _defaultToggle = false;

  void setDefaultToggle(bool d) {
    _defaultToggle = d;
    notifyListeners();
  }

  bool get defaultToggle => _defaultToggle;

  void clearDefaultToggle() {
    _defaultToggle = false;
    notifyListeners();
  }

  // ===============================
  // 🔹 Set Address as Default
  // ===============================
  Future<void> setAsDefault(
      int id, Function refetch, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');
    log('Access token (default): $accessToken');

    try {
      Uri url = Uri.parse(
          'https://pos-firefox-relatives-denver.trycloudflare.com/api/address/default/?id=$id');
      log('Default URL: $url');

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      log('Default Status Code: ${response.statusCode}');
      log('Default Response Body: ${response.body}');

      if (response.statusCode == 200) {
        log('✅ Address set as default successfully');
        refetch();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(
            context, data.message, 'Error changing default address', true);
        log('⚠️ Error: $data');
      } else {
        log('⚠️ Unexpected default status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ Default Error: $e');
    }
  }

  // ===============================
  // 🗑 Delete Address
  // ===============================
  Future<void> deleteAddress(int id, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');
    log('Access token (delete): $accessToken');
    log('Deleting address with id: $id');

    try {
      Uri url = Uri.parse(
          'https://pos-firefox-relatives-denver.trycloudflare.com/api/address/delete/?id=$id');
      log('Delete URL: $url');

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      log('Delete Status Code: ${response.statusCode}');
      log('Delete Response Body: ${response.body}');

      if (response.statusCode == 200) {
        log('✅ Address deleted successfully');
        refetchA();
        context.pop();
      } else if (response.statusCode == 404 || response.statusCode == 400) {
        var data = apiErrorFromJson(response.body);
        showErrorPopup(context, data.message, 'Error deleting address', true);
        log('⚠️ Error: $data');
      } else {
        log('⚠️ Unexpected delete status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ Delete Error: $e');
    }
  }

  Future<void> addAddres(String data, BuildContext context) async {
    String? accessToken = Storage().getString('accessToken');
    log('Access token (add): $accessToken');
    log('data : $data');

    try {
      Uri url = Uri.parse(
          'https://pos-firefox-relatives-denver.trycloudflare.com/api/address/add/');
      log('Delete URL: $url');

      final response = await http.post(
        url,
        body: data,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      log('Add Status Code: ${response.statusCode}');
      log('Add Response Body: ${response.body}');

      if (response.statusCode == 201) {
        log('✅ Address added successfully');
        refetchA();
        context.pop();
      }
    } catch (e) {
      debugPrint(e.toString());
      showErrorPopup(context, e.toString(), 'Error adding address', true);
    }
  }
}
