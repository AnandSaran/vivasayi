import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vivasayi/util/shared_preference.dart';
import 'package:vivasayi/util/user_access_control_util.dart';

import 'create_product_access_control.dart';

class CreateProductAccessControlBloc extends Bloc<
    CreateProductAccessControlEvent, CreateProductAccessControlState> {
  final UserAccessRepository _userAccessRepository;
  final UserAccessControlUtil _userAccessControlUtil;
  final SharedPreferenceUtil _sharedPreferenceUtil;
  StreamSubscription? _userAccessSubscription;

  CreateProductAccessControlBloc({
    required UserAccessRepository userAccessRepository,
    required UserAccessControlUtil userAccessControlUtil,
    required SharedPreferenceUtil sharedPreferenceUtil,
  })  : _userAccessRepository = userAccessRepository,
        _userAccessControlUtil = userAccessControlUtil,
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
    _userAccessSubscription?.cancel();
    _userAccessSubscription =
        _userAccessRepository.getUserAccess().listen((userAccess) {
      add(IsShowCreateProductAccessUpdated(isValidToShow(userAccess, event)));
    });
  }

  bool isValidToShow(
      List<UserAccess> userAccess, IsShowCreateProductAccess event) {
    return _userAccessControlUtil.isValidToHomeAccessIcon(
            _sharedPreferenceUtil.getUser().phoneNumber, userAccess) ||
        _userAccessControlUtil.isValidToCreateProductAccessIcon(
            _sharedPreferenceUtil.getUser().phoneNumber, event.shopPhoneNumber);
  }

  Stream<CreateProductAccessControlLoaded>
      _mapIsShowCreateProductAccessUpdateToState(
          IsShowCreateProductAccessUpdated event) async* {
    yield CreateProductAccessControlLoaded(event.isShow);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
