import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/constants/constant.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final List<String> imageUrl;
  final String description;
  final String qty;
  final String scaleType;
  final String price;
  final String productCategory;

  const Product({
    id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.qty,
    required this.scaleType,
    required this.price,
    required this.productCategory,
  }) : this.id = id ?? EMPTY_STRING;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'qty': qty,
      'scaleType': scaleType,
      'price': price,
      'productCategory': productCategory,
    };
  }

  @override
  List<Object?> get props =>
      [id, name, imageUrl, description, qty, scaleType, price,productCategory];

  @override
  String toString() {
    return 'Shop { id: $id, name: $name, imageUrl: $imageUrl, description: $description, qty: $qty, scaleType: $scaleType, price: $price, productCategory: $productCategory}';
  }

  static Product fromJson(Map<String, Object> json) {
    return Product(
        id: json['id'] as String,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as List<String>,
        description: json['description'] as String,
        qty: json['qty'] as String,
        scaleType: json['scaleType'] as String,
        price: json['price'] as String,
    productCategory: json['productCategory'] as String);
  }

  static Product fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return Product(
        id: snap.id,
        name: snap.get('name'),
        imageUrl: List.from(snap.get('imageUrl')),
        description: snap.get('description'),
        qty: snap.get('qty'),
        scaleType: snap.get('scaleType'),
        price: snap.get('price'),
        productCategory: snap.get('productCategory'));
  }

  Map<String, Object?> toDocument() {
    return {
      'name': name,
      'searchName': name.toLowerCase(),
      'imageUrl': imageUrl,
      'description': description,
      'qty': qty,
      'scaleType': scaleType,
      'price': price,
      'productCategory': productCategory
    };
  }
}
