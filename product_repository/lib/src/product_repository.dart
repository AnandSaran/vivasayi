import 'dart:async';

import 'package:product_repository/src/models/models.dart';

abstract class ProductRepository {
  setProductCollection(String collectionId);

  Future<void> addNewProduct(Product product);

  Future<void> deleteProduct(Product product);

  Stream<List<Product>> products();

  Stream<List<Product>> productsByShopCategory(String shopCategory);

  Future<void> updateProduct(Product product);
}
