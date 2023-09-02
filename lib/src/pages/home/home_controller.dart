import 'package:corelab_app_challenge/src/models/product_model.dart';
import "package:collection/collection.dart";
import 'package:corelab_app_challenge/src/services/suggestion/suggestion_service.dart';
import 'package:mobx/mobx.dart';

import '../../services/product/product_service.dart';
part 'home_controller.g.dart';

enum HomeStateStatus {
  initial,
  loading,
  loadingSuggestion,
  loaded,
  error,
}

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  @readonly
  var _status = HomeStateStatus.initial;

  @readonly
  String? _errorMessage;

  @readonly
  var _products = <ProductModel>[];

  @readonly
  var _suggestions = <String>[];

  @readonly
  var _groupProducts = <dynamic, List<dynamic>>{};

  @readonly
  String? _filterQuery;

  @observable
  bool searchable = false;

  @action
  bool setSearchable(bool value) => searchable = value;

  @action
  Future<void> loadSuggestions() async {
    try {
      _status = HomeStateStatus.loadingSuggestion;
      _suggestions = (await SuggestionService().getSuggestions())!;
      _status = HomeStateStatus.loaded;
    } catch (e) {
      _status = HomeStateStatus.error;
      _errorMessage = 'Erro recuperar sugestões';
    }
  }

  @action
  Future<void> filter(String query) async {
    _filterQuery = query;
    await loadProducts();
  }

  @action
  Future<void> loadProducts() async {
    try {
      _status = HomeStateStatus.loading;
      _products = await ProductService().getProducts(_filterQuery);
      if (_filterQuery == null || _filterQuery!.isEmpty) {
        _groupProducts = groupBy(_products, (obj) => obj.post);
      }
      _status = HomeStateStatus.loaded;
    } catch (e) {
      _status = HomeStateStatus.error;
      _errorMessage = 'Erro recuperar produtos';
    }
  }
}
