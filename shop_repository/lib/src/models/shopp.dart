/*
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shop_repository/src/entities/entities.dart';

@immutable
class Shopp {
  final String id;
  final String name;
  final String imageUrl;
  final String phoneNumber;
  final String whatsAppNumber;
  final String address;
  final GeoFirePoint geoFirePoint;

  Shopp({
    required this.name,
    required this.imageUrl,
    required this.phoneNumber,
    required this.whatsAppNumber,
    String? id,
  }) : this.id = id ?? '';

  Shopp copyWith(
      {String? name,
      String? imageUrl,
      String? phoneNumber,
      String? whatsAppNumber}) {
    return Shopp(
      id: id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      whatsAppNumber: whatsAppNumber ?? this.whatsAppNumber,
    );
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        imageUrl.hashCode ^
        phoneNumber.hashCode ^
        whatsAppNumber.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Shopp &&
            runtimeType == other.runtimeType &&
            name == other.name &&
            imageUrl == other.imageUrl &&
            phoneNumber == other.phoneNumber &&
            whatsAppNumber == other.whatsAppNumber &&
            id == other.id;
  }

  @override
  String toString() {
    return 'Shop{name: $name, imageUrl: $imageUrl, phoneNumber: $phoneNumber, whatsAppNumber: $whatsAppNumber, id: $id}';
  }

  Shop toEntity() {
    return Shop(
      id: id,
      name: name,
      imageUrl: imageUrl,
      phoneNumber: phoneNumber,
      whatsAppNumber: whatsAppNumber,
    );
  }

  static Shopp fromEntity(Shop entity) {
    return Shopp(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      phoneNumber: entity.phoneNumber,
      whatsAppNumber: entity.whatsAppNumber,
    );
  }
}
*/
