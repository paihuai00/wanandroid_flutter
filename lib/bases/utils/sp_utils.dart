import 'package:shared_preferences/shared_preferences.dart';

///sp 单例模式
class SpUtil {
  static SpUtil _spUtil;

  static SharedPreferences _sharedPreferences;

  factory SpUtil() => _getInstance();

  SpUtil._internal() {
    _initSp();
  }

  Future _initSp() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static SpUtil _getInstance() {
    if (_spUtil == null) _spUtil = new SpUtil._internal();
    return _spUtil;
  }

  ///put 方法
  static Future<bool> put(String key, Object value) {
    if (_sharedPreferences == null) return null;

    if (value is String) {
      putString(key, value);
    } else if (value is int) {
      putInt(key, value);
    } else if (value is bool) {
      putBoolean(key, value);
    } else if (value is List<String>) {
      putStringList(key, value);
    } else {

    }
  }

  static Future<bool> putString(String key, String value) {
    if (_sharedPreferences == null) return null;

    return _sharedPreferences.setString(key, value);
  }

  static String getString(String key) {
    if (_sharedPreferences == null) return "";

    return _sharedPreferences.get(key);
  }

  static Future<bool> putBoolean(String key, bool value) {
    if (_sharedPreferences == null) return null;

    return _sharedPreferences.setBool(key, value);
  }

  static String getBoolean(String key) {
    if (_sharedPreferences == null) return "";

    return _sharedPreferences.get(key);
  }

  static Future<bool> putInt(String key, int value) {
    if (_sharedPreferences == null) return null;

    return _sharedPreferences.setInt(key, value);
  }

  static String getInt(String key) {
    if (_sharedPreferences == null) return "";

    return _sharedPreferences.get(key);
  }

  static Future<bool> putStringList(String key, List<String> value) {
    if (_sharedPreferences == null) return null;

    return _sharedPreferences.setStringList(key, value);
  }

  static String getStringList(String key) {
    if (_sharedPreferences == null) return "";

    return _sharedPreferences.get(key);
  }
}
