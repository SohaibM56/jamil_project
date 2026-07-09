import 'package:jamil_project/src/utils/local_storage.dart';

class AuthRepository {
  AuthRepository(this._localStorage);

  final LocalStorage _localStorage;

  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == 'test@example.com' && password == 'password') {
      await _localStorage.setLoggedIn(true);
      return;
    }

    throw Exception('Invalid credentials');
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    await _localStorage.setLoggedIn(true);
  }

  Future<void> logout() {
    return _localStorage.setLoggedIn(false);
  }

  bool isLoggedIn() => _localStorage.isLoggedIn();
}
