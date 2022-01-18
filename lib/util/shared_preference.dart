import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:vivasayi/constants/sharedpreferece_key.dart';
import 'package:user_repository/user_repository.dart';

class SharedPreferenceUtil {
  static final SharedPreferenceUtil _sharedPreference =
      SharedPreferenceUtil._internal();
  final storage = GetStorage();

  factory SharedPreferenceUtil() {
    return _sharedPreference;
  }

  SharedPreferenceUtil._internal();

  Future init() async {
    await GetStorage.init();
  }

  GetStorage getStorage() {
    return storage;
  }

  String getString(String key, {String defValue = ""}) {
    return storage.read(key) ?? defValue;
  }

  int getInt(String key, {int defValue = -1}) {
    return storage.read(key) ?? defValue;
  }

  double getDouble(String key, {double defValue = -1}) {
    return storage.read(key) ?? defValue;
  }

  bool getBool(String key, {bool defValue = false}) {
    return storage.read(key) ?? defValue;
  }

  void write(String key, dynamic value) async {
    storage.write(key, value);
  }

  void increasePageViewCount() {
    final totalPageViewed = getInt(prefKeyTotalPageViewed, defValue: 0);
    write(prefKeyTotalPageViewed, (totalPageViewed + 1));
  }

  User getUser() {
    return User.fromJsonString(
        jsonDecode(SharedPreferenceUtil().getString(prefKeyUser)));
  }

  String getUserId() {
    final user= User.fromJsonString(
        jsonDecode(SharedPreferenceUtil().getString(prefKeyUser)));
    return user.id;
  }
}
