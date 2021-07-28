import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static Future<SharedPreferences> get _instance async =>
      await SharedPreferences.getInstance();
  static late SharedPreferences _prefsInstance;

  static final SharedPreferenceUtil _navigation =
      SharedPreferenceUtil._internal();

  factory SharedPreferenceUtil() {
    return _navigation;
  }

  SharedPreferenceUtil._internal();

  // call this method from iniState() function of mainApp().
  Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  String getString(String key, [String defValue = ""]) {
    return _prefsInstance.getString(key) ?? defValue;
  }

  int getInt(String key, [int defValue = -1]) {
    return _prefsInstance.getInt(key) ?? defValue;
  }

  double getDouble(String key, [double defValue = -1]) {
    return _prefsInstance.getDouble(key) ?? defValue;
  }

  bool getBool(String key, [bool defValue = false]) {
    return _prefsInstance.getBool(key) ?? defValue;
  }

  Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

  Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    var prefs = await _instance;
    return prefs.setDouble(key, value);
  }

  Future<bool> containsKey(String key) async {
    var prefs = await _instance;
    return prefs.containsKey(key);
  }
}
