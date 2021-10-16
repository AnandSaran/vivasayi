import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shop_repository/constants/constant.dart';

class Shop extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final String phoneNumber;
  final String whatsAppNumber ;
  final String address;
  final GeoFirePoint? geoFirePoint;
  final List<String> shopCategories;

  const Shop({
    id,
    required this.name,
    required this.imageUrl,
    required this.phoneNumber,
    required this.whatsAppNumber,
    required this.address,
    required this.  shopCategories,
    geoFirePoint,
  })  : this.id = id ?? EMPTY_STRING,
        this.geoFirePoint = geoFirePoint ?? null;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
      'address': address,
      'geoFirePoint': geoFirePoint,
      'shopCategories': shopCategories,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        phoneNumber,
        whatsAppNumber,
        address,
        geoFirePoint,
        shopCategories
      ];

  @override
  String toString() {
    return 'Shop { id: $id, name: $name, imageUrl: $imageUrl, phoneNumber: $phoneNumber, whatsAppNumber: $whatsAppNumber, address: $address, geoFirePoint: $geoFirePoint, shopCategories: $shopCategories}';
  }

  static Shop fromJson(Map<String, Object> json) {
    return Shop(
        id: json['id'] as String,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
        phoneNumber: json['phoneNumber'] as String,
        whatsAppNumber: json['whatsAppNumber'] as String,
        address: json['address'] as String,
        geoFirePoint: json['geoFirePoint'] as GeoFirePoint,
        shopCategories: json['shopCategories'] as List<String>);
  }

  static Shop fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return Shop(
      id: snap.id,
      name: snap.get('name'),
      imageUrl: snap.get('imageUrl'),
      phoneNumber: snap.get('phoneNumber'),
      whatsAppNumber: snap.get('whatsAppNumber'),
      address: snap.get('address'),
      //  geoFirePoint: snap.get('geoFirePoint'),
      shopCategories: List.from(snap.get('shopCategories')),
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'name': name,
      'searchName': name.toLowerCase(),
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'whatsAppNumber': whatsAppNumber,
      'address': address,
      'geoFirePoint': geoFirePoint?.data,
      'shopCategories': shopCategories,
    };
  }
}
