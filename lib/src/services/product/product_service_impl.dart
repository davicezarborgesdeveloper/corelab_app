import 'dart:convert';

import 'package:corelab_app_challenge/src/models/product_model.dart';
import 'package:flutter/services.dart';

import './product_service.dart';

class ProductServiceImpl implements ProductService {
  @override
  Future<List<ProductModel>> getProducts(String? query) async {
    List<ProductModel> list = <ProductModel>[];
    String fileJson = await rootBundle.loadString('assets/data/products.json');
    final result = json.decode(fileJson);
    result.forEach((d) => list.add(ProductModel.fromMap(d)));
    if (query != null && query.isNotEmpty) {
      List<ProductModel> listQuery =
          list.where((e) => e.name == 'query').toList();
      return listQuery;
    } else {
      return list;
    }
  }

  findProducts(List<ProductModel> list) {}
}
