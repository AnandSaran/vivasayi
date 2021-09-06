import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_repository/location_repository.dart';
import 'package:vivasayi/bloc/shop_address/shop_address_bloc.dart';

class EquipShopAddressBloc extends Bloc<ShopAddressEvent, ShopAddressState> {
  final LocationRepository _locationRepository;

  EquipShopAddressBloc({required LocationRepository locationRepository})
      : _locationRepository = locationRepository,
        super(ShopAddressLoading());

  @override
  Stream<ShopAddressState> mapEventToState(ShopAddressEvent event) async* {
    if (event is LoadShopAddress) {
      yield* _mapLoadShopAddressToState(event);
    } else if (event is ShopAddressUpdated) {
      yield* _mapShopAddressUpdateToState(event);
    }
  }

  Stream<ShopAddressState> _mapLoadShopAddressToState(
      LoadShopAddress event) async* {
    Location location = event.location;
    generateAddress(location);
  }

  Stream<ShopAddressState> _mapShopAddressUpdateToState(
      ShopAddressUpdated event) async* {
    yield ShopAddressLoaded(event.address);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  generateAddress(Location location) async {
    String address = await _locationRepository.getAddress(location);
    add(ShopAddressUpdated(address));
  }
}
