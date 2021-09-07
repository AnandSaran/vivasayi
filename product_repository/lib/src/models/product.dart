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

  const Product({
    id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.qty,
    required this.scaleType,
  }) : this.id = id ?? EMPTY_STRING;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'qty': qty,
      'scaleType': scaleType,
    };
  }

  @override
  List<Object?> get props => [id, name, imageUrl, description, qty, scaleType];

  @override
  String toString() {
    return 'Shop { id: $id, name: $name, imageUrl: $imageUrl, description: $description, qty: $qty, scaleType: $scaleType}';
  }

  static Product fromJson(Map<String, Object> json) {
    return Product(
        id: json['id'] as String,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as List<String>,
        description: json['description'] as String,
        qty: json['qty'] as String,
        scaleType: json['scaleType'] as String);
  }

  static Product fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return Product(
        id: snap.id,
        name: snap.get('name'),
        imageUrl: snap.get('imageUrl'),
        description: snap.get('description'),
        qty: snap.get('qty'),
        scaleType: snap.get('scaleType'));
  }

  Map<String, Object?> toDocument() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'qty': qty,
      'scaleType': scaleType
    };
  }
}
