import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:vivasayi/bloc/bloc_provider/bloc_provider.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/util/shared_preference.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/user_repository.dart' as valley_repository;

class LoadingScreenBloc extends BlocBase {
  final AuthenticationRepository authRepository;
  final valley_repository.UserRepository userRepository;
  final SharedPreferenceUtil sharedPreferenceUtil;
  late StreamSubscription userStreamSubscription;
  final isLogin = BehaviorSubject<bool>();
  final errorMessage = BehaviorSubject<String>();
  Function(bool) get changeIsLogin => isLogin.sink.add;

  LoadingScreenBloc(
      {required this.authRepository,
      required this.userRepository,
      required this.sharedPreferenceUtil}) {
    listenUser();
  }

  @override
  Future<void> dispose() async {
    isLogin.close();
    userStreamSubscription.cancel();
    await errorMessage.drain();
    errorMessage.close();

  }

  void listenUser() {
    userStreamSubscription = authRepository.user.listen((event) {
      if (event.isNotEmpty) {
        valley_repository.User user = valley_repository.User(
            uid: event.id, name: event.name, phoneNumber: event.phoneNumber);

        getUser(user);
      } else {
        changeIsLogin(false);
      }
    });
  }

  void getUser(valley_repository.User user) {
    userRepository.getUser(user).then((value) {
      if (value.isEmpty) {
        addUser(user);
      } else {
        onGetUserSuccess(value);
      }
    });
  }

  void addUser(valley_repository.User user) {
    userRepository.addUser(user).then((value) {
      onGetUserSuccess(value);
    });
  }

  void onGetUserSuccess(valley_repository.User value) {
    saveUser(value);
    changeIsLogin(true);
  }

  void saveUser(valley_repository.User value) {
    SharedPreferenceUtil().write(prefKeyUser, jsonEncode(value.toJson()));
  }

  Function(String) get changeErrorMessage => errorMessage.sink.add;
}
