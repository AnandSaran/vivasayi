import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_repository/src/models/models.dart';

abstract class ShopRepository {
  Future<void> addNewShop(Shop shop);

  Future<void> deleteShop(Shop shop);

  Stream<List<DocumentSnapshot>> shops(double lat,double long);

  Future<void> updateShop(Shop shop);
}
