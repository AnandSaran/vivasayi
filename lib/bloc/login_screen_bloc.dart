import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vivasayi/bloc/bloc_provider/bloc_provider.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/util/shared_preference.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:user_repository/user_repository.dart' as valley_repository;

class LoginScreenBloc extends BlocBase {
  LoginScreenBloc(this._authRepository, this._userRepository, this.sharedPreferenceUtil) {
    listenUser();
  }

  final AuthenticationRepository _authRepository;
  final valley_repository.UserRepository _userRepository;
  final SharedPreferenceUtil sharedPreferenceUtil;
  late StreamSubscription userStreamSubscription;
  final _phoneNumber = BehaviorSubject<String>();
  final isOtpVerified = BehaviorSubject<bool>();
  var progressButtonState = BehaviorSubject<ButtonState>();
  final isShowOtpDialog = BehaviorSubject<bool>();
  var otp = BehaviorSubject<String>();
  final verificationId = BehaviorSubject<String>();
  final errorMessage = BehaviorSubject<String>();
  var logInSuccess = BehaviorSubject<bool>();
  final isLogin = BehaviorSubject<bool>();

  final duration = const Duration(minutes: 1);

  @override
  Future<void> dispose() async {
    _phoneNumber.close();

    isOtpVerified.close();

    progressButtonState.close();

    isShowOtpDialog.close();

    otp.close();

    verificationId.close();

    errorMessage.close();

    logInSuccess.close();

    isLogin.close();
  }

  Stream<String> get phoneNumber =>
      _phoneNumber.stream.transform(_streamValidateMobileNumber);

  Function(String) get changePhoneNumber => _phoneNumber.sink.add;

  Function(bool) get changeOtpVerified => isOtpVerified.sink.add;

  Function(ButtonState) get changeProgressButtonState =>
      progressButtonState.sink.add;

  Function(bool) get changeShowOtpDialog => isShowOtpDialog.sink.add;

  Function(String) get changeOtp => otp.sink.add;

  Function(String) get changeVerificationId => verificationId.sink.add;

  Function(String) get changeErrorMessage => errorMessage.sink.add;

  Function(bool) get changeLogInSuccess => logInSuccess.sink.add;

  Function(bool) get changeIsLogin => isLogin.sink.add;

  final _streamValidateMobileNumber =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (mobileNumber, sink) {
    if (mobileNumber.trim().isNotEmpty &&
        mobileNumber.trim().length > MINIMUM_PHONE_NUMBER_LENGTH) {
      sink.add(mobileNumber);
    } else {
      sink.addError(ERROR_PHONE_NUMBER);
    }
  });

  void validateLoginForm() {
    bool validMobileNumber = _validateMobileNumber();
    if (validMobileNumber) {
      loginUser();
    }
  }

  bool _validateMobileNumber() {
    if (_phoneNumber.hasValue && _phoneNumber.value.length > 3) {
      return true;
    } else {
      _phoneNumber.sink.addError(ERROR_PHONE_NUMBER);
      return false;
    }
  }

  void loginUser() {}

  generateOtp() {
    if (_validateMobileNumber()) {
      if (kIsWeb) {
        _authRepository.signInWithMobileNumberWeb(
            _phoneNumber.value,
            _recaptchaVerifierSuccess,
            _recaptchaVerifierError,
            _recaptchaVerifierExpired,
            _phoneVerificationFailedWeb,
            _phoneVerificationSuccessWeb);
      } else {
        _authRepository.signInWithMobileNumber(
            _phoneNumber.value,
            duration,
            _phoneVerificationSuccess,
            _phoneVerificationFailed,
            _phoneCodeSent,
            _phoneCodeAutoRetrievalTimeout);
      }
    }
  }

  _phoneVerificationSuccess(AuthCredential authCredential) {}

  _phoneVerificationFailed(FirebaseAuthException authException) {
    String message = authException.message ?? ERROR_FIREBASE_AUTH_EXCEPTION;

    if (authException.code == EXCEPTION_INVALID_PHONE_NUMBER) {
      message = ERROR_PHONE_NUMBER;
    }
    if (isOtpVerified.hasValue) {
      otp.sink.addError(message);
    } else {
      _phoneNumber.sink.addError(message);
    }
  }

  _phoneCodeSent(String verId, [int? forceResent]) {
    verificationId.sink.add(verId);
    changeShowOtpDialog(true);
  }

  _phoneCodeAutoRetrievalTimeout(String verId) {
    verificationId.sink.add(verId);
  }

  _recaptchaVerifierSuccess() {}

  _recaptchaVerifierError(FirebaseAuthException error) {
    changeErrorMessage(error.message ?? ERROR_SOMETHING_WENT_WRONG);
  }

  _recaptchaVerifierExpired() {}

  _phoneVerificationFailedWeb(FirebaseAuthException authException) {
    String message = authException.message ?? ERROR_FIREBASE_AUTH_EXCEPTION;

    if (authException.code == EXCEPTION_INVALID_PHONE_NUMBER) {
      message = ERROR_PHONE_NUMBER;
    }
    _phoneNumber.sink.addError(message);
  }

  _phoneVerificationSuccessWeb() {
    changeShowOtpDialog(true);
  }

  void resetOtp() {
    otp = BehaviorSubject<String>();
  }

  void otpSubmit() {
    if (validateOtpForm()) {
      verifyOtp();
    }
  }

  bool validateOtpForm() {
    return _validateOtp();
  }

  bool _validateOtp() {
    if (otp.hasValue && otp.value.length == 6) {
      return true;
    } else {
      otp.sink.addError(ERROR_ENTER_6_DIGIT_OTP);
      return false;
    }
  }

  void verifyOtp() async {
    if (kIsWeb) {
      _authRepository.verifyOtpWeb(otp.value, _verifyOtpFail);
    } else {
      _authRepository.verifyOtp(
          verificationId.value, otp.value, _verifyOtpFail);
    }
  }

  _verifyOtpFail() {
    otp.sink.addError(ERROR_INVALID_OTP);
  }

  void listenUser() {
    userStreamSubscription = _authRepository.user.listen((event) {
      if (event.isNotEmpty) {
        changeShowOtpDialog(false);
        userStreamSubscription.cancel();
        valley_repository.User user = valley_repository.User(
            uid: event.id, name: event.name, phoneNumber: event.phoneNumber);

        getUser(user);
      }
    });
  }

  void getUser(valley_repository.User user) {
    _userRepository.getUser(user).then((value) {
      if (value.isEmpty) {
        addUser(user);
      } else {
        onGetUserSuccess(value);
      }
    });
  }

  void addUser(valley_repository.User user) {
    _userRepository.addUser(user).then((value) {
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
}
