import 'package:equatable/equatable.dart';
import 'package:vivasayi/constants/string_constants.dart';

abstract class ShopAddressState extends Equatable {
  const ShopAddressState();

  @override
  List<Object> get props => [];
}

class ShopAddressLoading extends ShopAddressState {
  final String hint = SYMBOL_THREE_DOT;
}

class ShopAddressLoaded extends ShopAddressState {
  final String address;

  const ShopAddressLoaded(this.address);

  @override
  List<Object> get props => [address];

  @override
  String toString() => 'ShopAddressLoaded { address: $address }';
}

class ShopAddressNotLoaded extends ShopAddressState {}
