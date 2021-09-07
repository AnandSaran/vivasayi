import 'dart:async';

import 'package:product_repository/src/models/models.dart';

abstract class ProductRepository {
  Future<void> addNewProduct(Product product);

  Future<void> deleteProduct(Product product);

  Stream<List<Product>> products();

  Future<void> updateProduct(Product product);
}
