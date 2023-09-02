import 'package:corelab_app_challenge/src/models/product_model.dart';

import 'product_service_impl.dart';

abstract interface class ProductService {
  Future<List<ProductModel>> getProducts(String? query);

  factory ProductService() {
    return ProductServiceImpl();
  }
}
