import 'package:get/get.dart';

import 'package:jamil_project/src/config/app_router.dart';
import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));

    final authController = Get.find<AuthController>();
    final route = authController.isAuthenticated.value
        ? AppRoute.dashboard.path
        : AppRoute.login.path;

    Get.offAllNamed(route);
  }
}
