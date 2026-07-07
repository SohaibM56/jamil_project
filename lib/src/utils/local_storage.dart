import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  static const _isLoggedInKey = 'isLoggedIn';

  Future<void> setLoggedIn(bool value) {
    return _sharedPreferences.setBool(_isLoggedInKey, value);
  }

  bool isLoggedIn() {
    return _sharedPreferences.getBool(_isLoggedInKey) ?? false;
  }
}
