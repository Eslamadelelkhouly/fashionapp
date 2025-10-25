import 'dart:developer';

import 'package:fashionapp/src/product/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchNotifier with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Products> _results = [];
  List<Products> get results => _results;

  void setresults(List<Products> value) {
    _results = value;
    notifyListeners();
  }

  void clearResults() {
    _results = [];
  }

  String currentQuery = '';

  void setCurrentQuery(String value) {
    currentQuery = value;
    notifyListeners();
  }

  String _searchKey = '';

  String? _error;

  String get error => _error ?? '';

  void setError(String value) {
    _error = value;
  }

  void setSearchKey(String value) {
    _searchKey = value;
    notifyListeners();
  }

  void searchFunction(String searchKey) async {
    setLoading(true);
    setSearchKey(searchKey);
    Uri url = Uri.parse(
        'https://d3d681df2788.ngrok-free.app/api/products/search/?q=${searchKey}');
    log(url.toString());
    try {
      var response = await http.get(url);
      log("response : ${response.toString()}");
      if (response.statusCode == 200) {
        var data = productsFromJson(response.body);
        setresults(data);
        log(data.toString());
        setLoading(false);
        log("response status: ${response.statusCode}");
        log("response body: ${response.body}");
      }
    } catch (e) {
      setError(e.toString());
      log(e.toString());
    }
  }
}
