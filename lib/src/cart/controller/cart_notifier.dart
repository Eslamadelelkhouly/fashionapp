import 'dart:developer';

import 'package:fashionapp/common/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartNotifier with ChangeNotifier {
  int _qty = 0;

  int get qty => _qty;

  void increment() {
    _qty++;
    notifyListeners();
  }

  void decrement() {
    if (_qty > 1) {
      _qty--;
      notifyListeners();
    }
  }

  int? _selectCart;

  int? get selectedCounter => _selectCart;

  void setSelectedCounter(int id, int q) {
    _selectCart = id;
    _qty = q;
    notifyListeners();
  }

  void clearSelected() {
    log('clear selected');
    _selectCart = null;
    _qty = 0;
    notifyListeners();
  }

  Future<void> deleteCart() async {}

  Future<void> updateCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');
    const baseurl = 'https://4cb510477446.ngrok-free.app/';
    try {
      Uri url = Uri.parse('${baseurl}api/cart/update/?id=$id&count=$qty');
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      log(response.body.toString());
      if (response.statusCode == 200) {
        refetch();
        clearSelected();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
