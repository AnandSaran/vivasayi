import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_repository/product_repository.dart';
import 'package:vivasayi/bloc/product/products.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is SetShop) {
      _mapSetShopToState(event);
    } else if (event is LoadProduct) {
      yield* _mapLoadProductToState(event);
    } else if (event is AddProduct) {
      yield* _mapAddProductToState(event);
    } else if (event is UpdateProduct) {
      yield* _mapUpdateProductToState(event);
    } else if (event is DeleteProduct) {
      yield* _mapDeleteProductToState(event);
    } else if (event is ProductUpdated) {
      yield* _mapProductUpdateToState(event);
    }
  }

  _mapSetShopToState(SetShop event) {
    _productRepository.setProductCollection(event.shopId);
    add(LoadProduct());
  }

  Stream<ProductState> _mapLoadProductToState(LoadProduct event) async* {
    _productSubscription?.cancel();
    _productSubscription = _productRepository.products().listen(
          (product) => add(ProductUpdated(product)),
        );
  }

  Stream<ProductState> _mapAddProductToState(AddProduct event) async* {
    //  _productRepository.addNewProduct(event.product);
  }

  Stream<ProductState> _mapUpdateProductToState(UpdateProduct event) async* {
    //_productRepository.updateProductProduct(event.updatedProduct);
  }

  Stream<ProductState> _mapDeleteProductToState(DeleteProduct event) async* {
    // _productRepository.deleteProductProduct(event.product);
  }

  Stream<ProductState> _mapProductUpdateToState(ProductUpdated event) async* {
    yield ProductLoaded(event.stories);
  }

  @override
  Future<void> close() {
    _productSubscription?.cancel();
    return super.close();
  }
}
