import 'package:equatable/equatable.dart';
import 'package:shop_repository/shop_repository.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {
  final List<Shop> shops;

  const ShopLoaded([this.shops = const []]);

  @override
  List<Object> get props => [shops];

  @override
  String toString() => 'ShopLoaded { stories: $shops }';
}

class ShopNotLoaded extends ShopState {}
