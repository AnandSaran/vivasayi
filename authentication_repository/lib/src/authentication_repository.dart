import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import 'models/models.dart';

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  late firebase_auth.ConfirmationResult confirmationResult;

  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  /// Stream of [AuthUser] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [AuthUser.empty] if the user is not authenticated.
  Stream<AuthUser> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? AuthUser.empty : firebaseUser.toUser;
      return user;
    });
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    late final firebase_auth.AuthCredential credential;
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _firebaseAuth.signInWithCredential(credential);
  }

  void signInWithMobileNumber(
      String phoneNumber,
      Duration timeOut,
      firebase_auth.PhoneVerificationCompleted phoneVerificationSuccess,
      firebase_auth.PhoneVerificationFailed phoneVerificationFailed,
      firebase_auth.PhoneCodeSent phoneCodeSent,
      firebase_auth.PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: phoneVerificationSuccess,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout,
      );
    } catch (e) {
      phoneVerificationFailed(e as firebase_auth.FirebaseAuthException);
    }
  }

  void signInWithMobileNumberWeb(
    String phoneNumber,
    firebase_auth.RecaptchaVerifierOnSuccess _recaptchaVerifierSuccess,
    firebase_auth.RecaptchaVerifierOnError _recaptchaVerifierError,
    firebase_auth.RecaptchaVerifierOnExpired _recaptchaVerifierExpired,
    Function _phoneVerificationFailedWeb,
    Function _phoneVerificationSuccessWeb,
  ) async {
    try {
      confirmationResult = await _firebaseAuth.signInWithPhoneNumber(
          phoneNumber,
          firebase_auth.RecaptchaVerifier(
            onSuccess: _recaptchaVerifierSuccess,
            onError: _recaptchaVerifierError,
            onExpired: _recaptchaVerifierExpired,
          ));
      _phoneVerificationSuccessWeb();
    } catch (e) {
      _phoneVerificationFailedWeb(e as firebase_auth.FirebaseAuthException);
    }
  }

  void verifyOtp(
      String verificationId, String smsCode, Function verifyOtpFail) async {
    try {
      firebase_auth.PhoneAuthCredential credential =
          firebase_auth.PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

      await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      verifyOtpFail(e.toString());
    }
  }

  void verifyOtpWeb(String smsCode, Function verifyOtpFail) async {
    try {
      await confirmationResult.confirm(smsCode);
    } catch (e) {
      verifyOtpFail();
    }
  }

  /// Signs out the current user which will emit
  /// [AuthUser.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
       // _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  AuthUser get toUser {
    return AuthUser(
        id: uid,
        email: email,
        name: displayName,
        photo: photoURL,
        phoneNumber: phoneNumber);
  }
}
