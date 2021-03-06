import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shop_repository/constants/constant.dart';
import 'package:shop_repository/src/models/models.dart';
import 'package:shop_repository/src/shop_repository.dart';

class FirestoreShopRepository implements ShopRepository {
  dynamic shopCollection = FirebaseFirestore.instance.collection(COL_SHOP);
  final geo = Geoflutterfire();

  late final center;
  final double radius = 50;

  FirestoreShopRepository() {
    center =
        geo.point(latitude: 11.161097755043787, longitude: 79.38969615206517);
  }

  updateShopCategory(String shopCategory) {
    shopCollection = shopCollection.where(FIELD_SHOP_CATEGORIES,
        arrayContains: shopCategory);
  }

  @override
  Future<void> addNewShop(Shop shop) {
    return shopCollection.add(shop.toDocument());
  }

  @override
  Future<void> deleteShop(Shop shop) {
    return shopCollection.doc(shop.id).delete();
  }

  @override
  Stream<List<DocumentSnapshot>> shops() {
    /* return geo.collection(collectionRef: shopCollection)
        .within(center: center, radius: radius, field: FIELD_GEO_QUERY_FIELD_NAME).listen((event) {
         return event.map((e) => Shop.fromSnapshot(e)).toList();
    });*/

    Stream<List<DocumentSnapshot>> stream = geo
        .collection(collectionRef: shopCollection)
        .within(
            center: center, radius: radius, field: FIELD_GEO_QUERY_FIELD_NAME);
    return stream;
  }

  @override
  Future<void> updateShop(Shop shop) {
    return shopCollection.doc(shop.id).update(shop.toDocument());
  }
}
