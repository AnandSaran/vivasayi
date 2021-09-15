import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_repository/constants/constant.dart';
import 'package:product_repository/product_repository.dart';

class FirestoreProductRepository implements ProductRepository {
  late CollectionReference productCollection;

  @override
  setProductCollection(String shopId) {
    productCollection = FirebaseFirestore.instance
        .collection(COL_SHOP)
        .doc(shopId)
        .collection(COL_PRODUCT);
  }

  @override
  Future<void> addNewProduct(Product product) {
    return productCollection.add(product.toDocument());
  }

  @override
  Future<void> deleteProduct(Product product) {
    return productCollection.doc(product.id).delete();
  }

  @override
  Stream<List<Product>> products() {
    return productCollection.orderBy(FIELD_NAME).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList();
    });
  }

  @override
  Future<void> updateProduct(Product product) {
    return productCollection.doc(product.id).update(product.toDocument());
  }
}
