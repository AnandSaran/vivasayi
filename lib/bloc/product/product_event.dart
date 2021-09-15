import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class SetShop extends ProductEvent {
  final String shopId;

  const SetShop(this.shopId);
}

class LoadProduct extends ProductEvent {
  const LoadProduct();
}

class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'AddProduct { product: $product }';
}

class UpdateProduct extends ProductEvent {
  final Product updatedProduct;

  const UpdateProduct(this.updatedProduct);

  @override
  List<Object> get props => [updatedProduct];

  @override
  String toString() => 'UpdateProduct { updatedProduct: $updatedProduct }';
}

class DeleteProduct extends ProductEvent {
  final Product product;

  const DeleteProduct(this.product);

  @override
  List<Object> get props => [product];

  @override
  String toString() => 'DeleteProduct { deletedProduct: $product }';
}

class ProductUpdated extends ProductEvent {
  final List<Product> stories;

  const ProductUpdated(this.stories);

  @override
  List<Object> get props => [stories];
}

class AddressUpdated extends ProductEvent {
  final String address;

  const AddressUpdated(this.address);

  @override
  List<Object> get props => [address];
}
