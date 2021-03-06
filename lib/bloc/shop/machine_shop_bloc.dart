import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/bloc/shop/shops.dart';

class MachineShopBloc extends Bloc<ShopEvent, ShopState> {
  final ShopRepository _shopRepository;
  StreamSubscription? _shopSubscription;

  MachineShopBloc({required ShopRepository shopRepository})
      : _shopRepository = shopRepository,
        super(ShopLoading());

  @override
  Stream<ShopState> mapEventToState(ShopEvent event) async* {
    if (event is LoadShop) {
      yield* _mapLoadShopToState();
    } else if (event is AddShop) {
      yield* _mapAddShopToState(event);
    } else if (event is UpdateShop) {
      yield* _mapUpdateShopToState(event);
    } else if (event is DeleteShop) {
      yield* _mapDeleteShopToState(event);
    } else if (event is ShopUpdated) {
      yield* _mapShopUpdateToState(event);
    }
  }

  Stream<ShopState> _mapLoadShopToState() async* {
    _shopSubscription?.cancel();
    _shopSubscription = _shopRepository.shops().listen((documentSnapShots) {
      add(ShopUpdated(
          documentSnapShots.map((e) => Shop.fromSnapshot(e)).toList()));
    });
  }

  Stream<ShopState> _mapAddShopToState(AddShop event) async* {
    //  _shopRepository.addNewShop(event.shop);
  }

  Stream<ShopState> _mapUpdateShopToState(UpdateShop event) async* {
    //_shopRepository.updateShopShop(event.updatedShop);
  }

  Stream<ShopState> _mapDeleteShopToState(DeleteShop event) async* {
    // _shopRepository.deleteShopShop(event.shop);
  }

  Stream<ShopState> _mapShopUpdateToState(ShopUpdated event) async* {
    yield ShopLoaded(event.stories);
  }

  @override
  Future<void> close() {
    _shopSubscription?.cancel();
    return super.close();
  }
}

