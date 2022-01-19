import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:vivasayi/bloc/home_access_control/home_access_control.dart';
import 'package:vivasayi/util/shared_preference.dart';
import 'package:vivasayi/util/user_access_control_util.dart';

class HomeAccessControlBloc
    extends Bloc<HomeAccessControlEvent, HomeAccessControlState> {
  final UserAccessRepository _userAccessRepository;
  final UserAccessControlUtil _userAccessControlUtil;
  final SharedPreferenceUtil _sharedPreferenceUtil;
  StreamSubscription? _userAccessSubscription;

  HomeAccessControlBloc({
    required UserAccessRepository userAccessRepository,
    required UserAccessControlUtil userAccessControlUtil,
    required SharedPreferenceUtil sharedPreferenceUtil,
  })  : _userAccessRepository = userAccessRepository,
        _userAccessControlUtil = userAccessControlUtil,
        _sharedPreferenceUtil = sharedPreferenceUtil,
        super(HomeAccessControlLoading());

  @override
  Stream<HomeAccessControlState> mapEventToState(
      HomeAccessControlEvent event) async* {
    if (event is IsShowHomeAccess) {
      yield* _mapIsShowHomeAccessState(event);
    } else if (event is IsShowHomeAccessUpdated) {
      yield* _mapIsShowHomeAccessUpdateToState(event);
    }
  }

  Stream<HomeAccessControlState> _mapIsShowHomeAccessState(
      IsShowHomeAccess event) async* {
    _userAccessSubscription?.cancel();
    _userAccessSubscription =
        _userAccessRepository.getUserAccess().listen((userAccess) {
      add(IsShowHomeAccessUpdated(
          _userAccessControlUtil.isValidToHomeAccessIcon(
              _sharedPreferenceUtil.getUser().phoneNumber, userAccess)));
    });
  }

  Stream<HomeAccessControlLoaded> _mapIsShowHomeAccessUpdateToState(
      IsShowHomeAccessUpdated event) async* {
    yield HomeAccessControlLoaded(event.isShow);
  }

  @override
  Future<void> close() {
    _userAccessSubscription?.cancel();
    return super.close();
  }
}
