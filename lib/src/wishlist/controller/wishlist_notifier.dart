import 'dart:convert';
import 'dart:developer';
import 'package:fashionapp/common/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WishlistNotifier with ChangeNotifier {
  String? error;
  List _wishlist = [];

  List get wishlist => _wishlist;

  // ✅ لتحديث القائمة بالكامل
  void setWishList(List<int> w) {
    _wishlist = w;
    notifyListeners();
  }

  // ✅ لتخزين وإدارة المنتج داخل الـ wishlist
  void setToList(int v) {
    try {
      String? accessToken = Storage().getString('accessToken');
      String key = '${accessToken}wishlist';

      // نقرأ البيانات من التخزين
      String? wishlistData = Storage().getString(key);
      List<int> w = [];

      if (wishlistData != null && wishlistData.isNotEmpty) {
        final decoded = jsonDecode(wishlistData);
        if (decoded is List) {
          w = List<int>.from(decoded);
        } else if (decoded is String) {
          // لو القيمة كانت String داخل String
          w = List<int>.from(jsonDecode(decoded));
        }
      }

      // ✅ نضيف أو نحذف المنتج حسب الحالة
      if (w.contains(v)) {
        w.remove(v);
      } else {
        w.add(v);
      }

      // ✅ نخزن التحديث
      Storage().setString(key, jsonEncode(w));
      setWishList(w);
      log('Wishlist updated: $w');
    } catch (e) {
      log('Wishlist setToList error: $e');
    }
  }

  // ✅ للتعامل مع الـ API (إضافة أو حذف من السيرفر)
  void addRemoveWishlist(int id, Function refetch) async {
    final accessToken = Storage().getString('accessToken');
    try {
      String baseurl = 'https://c5dd61e45072.ngrok-free.app/';
      Uri url = Uri.parse('${baseurl}api/wishlist/toggle/?id=$id');
      log(url.toString());

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $accessToken',
        },
      );

      if (response.statusCode == 201) {
        log('✅ Added to wishlist');
        setToList(id);
        refetch();
      } else if (response.statusCode == 204) {
        log('❌ Removed from wishlist');
        setToList(id);
        refetch();
      } else {
        log('⚠️ Unexpected status: ${response.statusCode}');
      }
    } catch (e) {
      error = e.toString();
      log('🚨 Wishlist error: $e');
      notifyListeners();
    }
  }
}
