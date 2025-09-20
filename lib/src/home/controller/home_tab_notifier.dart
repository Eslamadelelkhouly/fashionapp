import 'dart:developer';

import 'package:fashionapp/common/utils/enums.dart';
import 'package:flutter/material.dart';

class HomeTabNotifier with ChangeNotifier {
  QueryType queryType = QueryType.all;
  String _index = 'All';

  String get index => _index;


  void setIndex(String index) {
    _index = index;

    switch (index) {
      case 'All':
        setQuaryType(QueryType.all);
        break;
      case 'Popular':
        setQuaryType(QueryType.popular);
        break;
      case 'Unisex':
        setQuaryType(QueryType.unisex);
        break;
      case 'Men':
        setQuaryType(QueryType.men);
        break;
      case 'Women':
        setQuaryType(QueryType.women);
        break;
      case 'Kids':
        setQuaryType(QueryType.kids);
        break;
      default:
        setQuaryType(QueryType.all);
    }
  }

  void setQuaryType(QueryType q) {
    queryType = q;
  }
}
