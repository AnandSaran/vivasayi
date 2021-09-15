import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded([this.products = const []]);

  @override
  List<Object> get props => [products];

  @override
  String toString() => 'ProductLoaded { stories: $products }';
}

class ProductNotLoaded extends ProductState {}
