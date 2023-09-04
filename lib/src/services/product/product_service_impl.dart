import 'dart:convert';

import 'package:corelab_app_challenge/src/models/product_model.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/services.dart';

import './product_service.dart';

class ProductServiceImpl implements ProductService {
  @override
  Future<List<ProductModel>> getProducts(String? query, List<bool> type) async {
    List<ProductModel> list = <ProductModel>[];
    String fileJson = await rootBundle.loadString('assets/data/products.json');
    final result = json.decode(fileJson);
    result.forEach((d) => list.add(ProductModel.fromMap(d)));
    if (query != null && query.isNotEmpty) {
      List<ProductModel> listQuery = list.where((e) {
        if (type[0]) {
          return removeDiacritics(e.name).toUpperCase().contains(query);
        } else if (type[1]) {
          return removeDiacritics(e.description).toUpperCase().contains(query);
        } else if (type[2]) {
          return removeDiacritics(e.description).toUpperCase().contains(query);
        } else if (type[3]) {
          return e.price.toString().contains(query);
        } else {
          return removeDiacritics(e.name).toUpperCase().contains(query) ||
              removeDiacritics(e.description).toUpperCase().contains(query) ||
              removeDiacritics(e.category).toUpperCase().contains(query) ||
              e.price.toString().contains(query);
        }
      }).toList();
      return listQuery;
    } else {
      return list;
    }
  }

  bool findProductsType(List<bool> type) {
    return true;
  }
}
