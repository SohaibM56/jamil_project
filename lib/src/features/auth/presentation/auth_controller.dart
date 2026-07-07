import 'package:get/get.dart';

import '../data/auth_repository.dart';
import '../../../routing/app_router.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);

  final AuthRepository _authRepository;
  final isLoading = false.obs;
  final isAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();
    isAuthenticated.value = _authRepository.isLoggedIn();
  }

  Future<void> login(String email, String password) async {
    await _runAuthAction(() async {
      await _authRepository.login(email, password);
      isAuthenticated.value = true;
      Get.offAllNamed(AppRoute.dashboard.path);
    });
  }

  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    await _runAuthAction(() async {
      await _authRepository.signup(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
      isAuthenticated.value = true;
      Get.offAllNamed(AppRoute.dashboard.path);
    });
  }

  Future<void> logout() async {
    await _runAuthAction(() async {
      await _authRepository.logout();
      isAuthenticated.value = false;
      Get.offAllNamed(AppRoute.login.path);
    });
  }

  Future<void> _runAuthAction(Future<void> Function() action) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      await action();
    } catch (error) {
      Get.snackbar('Error', error.toString().replaceFirst('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }
}
