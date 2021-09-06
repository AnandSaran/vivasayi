import 'package:equatable/equatable.dart';
import 'package:location_repository/location_repository.dart';
import 'package:shop_repository/shop_repository.dart';

class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class LoadShop extends ShopEvent {
  final Location location;

  const LoadShop(this.location);
}

class AddShop extends ShopEvent {
  final Shop shop;

  const AddShop(this.shop);

  @override
  List<Object> get props => [shop];

  @override
  String toString() => 'AddShop { shop: $shop }';
}

class UpdateShop extends ShopEvent {
  final Shop updatedShop;

  const UpdateShop(this.updatedShop);

  @override
  List<Object> get props => [updatedShop];

  @override
  String toString() => 'UpdateShop { updatedShop: $updatedShop }';
}

class DeleteShop extends ShopEvent {
  final Shop shop;

  const DeleteShop(this.shop);

  @override
  List<Object> get props => [shop];

  @override
  String toString() => 'DeleteShop { deletedShop: $shop }';
}

class ShopUpdated extends ShopEvent {
  final List<Shop> stories;

  const ShopUpdated(this.stories);

  @override
  List<Object> get props => [stories];
}

class AddressUpdated extends ShopEvent {
  final String address;

  const AddressUpdated(this.address);

  @override
  List<Object> get props => [address];
}
