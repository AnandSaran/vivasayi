import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivasayi/util/shared_preference.dart';
import 'package:vivasayi/util/user_access_control_util.dart';

import 'create_product_access_control.dart';

class CreateProductAccessControlBloc extends Bloc<CreateProductAccessControlEvent,
    CreateProductAccessControlState> {
  final UserAccessControlUtil _userAccessControlUtil;
  final SharedPreferenceUtil _sharedPreferenceUtil;

  CreateProductAccessControlBloc({
    required UserAccessControlUtil userAccessControlUtil,
    required SharedPreferenceUtil sharedPreferenceUtil,
  })  : _userAccessControlUtil = userAccessControlUtil,
        _sharedPreferenceUtil = sharedPreferenceUtil,
        super(CreateProductAccessControlLoading());

  @override
  Stream<CreateProductAccessControlState> mapEventToState(
      CreateProductAccessControlEvent event) async* {
    if (event is IsShowCreateProductAccess) {
      yield* _mapIsShowCreateProductAccessState(event);
    } else if (event is IsShowCreateProductAccessUpdated) {
      yield* _mapIsShowCreateProductAccessUpdateToState(event);
    }
  }

  Stream<CreateProductAccessControlState> _mapIsShowCreateProductAccessState(
      IsShowCreateProductAccess event) async* {
    add(IsShowCreateProductAccessUpdated(
        _userAccessControlUtil.isValidToCreateProductAccessIcon(
            _sharedPreferenceUtil.getUser().phoneNumber,
            event.shopPhoneNumber)));
  }

  Stream<CreateProductAccessControlLoaded> _mapIsShowCreateProductAccessUpdateToState(
      IsShowCreateProductAccessUpdated event) async* {
    yield CreateProductAccessControlLoaded(event.isShow);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
