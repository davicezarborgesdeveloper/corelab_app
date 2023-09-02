import 'dart:convert';

import 'package:corelab_app_challenge/src/models/category_model.dart';
import 'package:flutter/services.dart';

import './category_service.dart';

class CategoryServiceImpl implements CategoryService {
  @override
  Future<List<CategoryModel>> getCategories() async {
    final List<CategoryModel> list = <CategoryModel>[];
    String fileJson =
        await rootBundle.loadString('assets/data/categories.json');
    final result = json.decode(fileJson);
    result.forEach((d) => list.add(CategoryModel.fromMap(d)));
    return list;
  }
}
