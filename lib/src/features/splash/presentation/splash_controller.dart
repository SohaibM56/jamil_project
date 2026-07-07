import 'package:get/get.dart';

import '../../../routing/app_router.dart';
import '../../auth/presentation/auth_controller.dart';

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
