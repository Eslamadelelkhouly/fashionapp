import 'dart:convert';
import 'dart:developer';

import 'package:fashionapp/common/services/storage.dart';
import 'package:fashionapp/common/widgets/password_field.dart';
import 'package:fashionapp/src/cart/models/cart_model.dart';
import 'package:fashionapp/src/entrypoint/controller/bottom_tab_notifier.dart';
import 'package:fashionapp/src/products/controller/color_sized_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartNotifier with ChangeNotifier {
  int _qty = 0;

  Function? refetchCount;

  int get qty => _qty;

  void setRefetchCount(Function r) {
    refetchCount = r;
  }

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
    _selectedCartItemIds.clear();
    _selectedCartItem.clear();
    _qty = 0;
    notifyListeners();
  }

  Future<void> deleteCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');
    const baseurl = 'https://midi-circuit-enjoy-directory.trycloudflare.com/';
    try {
      Uri url = Uri.parse('${baseurl}api/cart/delete/?id=$id');

      log(url.toString());
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );
      log(response.body.toString());
      if (response.statusCode == 204) {
        refetch();
        refetchCount!();
        clearSelected();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateCart(int id, void Function() refetch) async {
    String? accessToken = Storage().getString('accessToken');
    const baseurl = 'https://midi-circuit-enjoy-directory.trycloudflare.com/';
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

  Future<void> addToCart(Map<String, dynamic> data, BuildContext ctx) async {
    String? accessToken = Storage().getString('accessToken');
    const baseurl = 'https://midi-circuit-enjoy-directory.trycloudflare.com/';
    try {
      Uri url = Uri.parse('${baseurl}api/cart/add/');
      final response = await http.post(
        url,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      log('Status: ${response.statusCode}');
      log('Response body: ${response.body}');

      if (response.statusCode == 201) {
        refetchCount!();
        ctx.read<ColorSizedNotifier>().setColor('');
        ctx.read<ColorSizedNotifier>().setSize('');

        ctx.read<TabNotifier>().setcurrentIndex(2);
        ctx.go('/home');
      } else {
        log('Failed: ${response.statusCode}');
        log('Error response: ${response.body}');
      }
    } catch (e) {
      log('Exception: $e');
    }
  }

  List<int> _selectedCartItemIds = [];
  List<int> get selectedCartItemIds => _selectedCartItemIds;

  List<CartModel> _selectedCartItem = [];
  List<CartModel> get selectedCartItem => _selectedCartItem;

  double totalPrice = 0.0;
  void selectedOrDeselected(int id, CartModel cartItem) {
    if (_selectedCartItemIds.contains(id)) {
      _selectedCartItemIds.remove(id);
      _selectedCartItem.removeWhere((i) => i.id == id);
      totalPrice = calculateTotalPrice(_selectedCartItem);
    } else {
      _selectedCartItemIds.add(id);
      _selectedCartItem.add(cartItem);
      totalPrice = calculateTotalPrice(_selectedCartItem);
    }
    notifyListeners();
  }

  double calculateTotalPrice(List<CartModel> items) {
    double tp = 0.0;
    for (var item in items) {
      tp += item.product.price * item.quantity;
    }
    return tp;
  }

  String _paymentUrl = '';
  String get paymenturl => _paymentUrl;

  void setPaymentUrl(String url) {
    _paymentUrl = url;
    notifyListeners();
  }

  String _success = '';
  String get success => _success;

  void setSuccessUrl(String url) {
    _success = url;
  }
}
