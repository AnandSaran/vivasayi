import 'package:equatable/equatable.dart';
import 'package:location_repository/location_repository.dart';

class ShopAddressEvent extends Equatable {
  const ShopAddressEvent();

  @override
  List<Object> get props => [];
}

class LoadShopAddress extends ShopAddressEvent {
  final Location location;

  const LoadShopAddress(this.location);
}

class ShopAddressUpdated extends ShopAddressEvent {
  final String address;

  const ShopAddressUpdated(this.address);

  @override
  List<Object> get props => [address];
}
