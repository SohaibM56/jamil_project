import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../features/auth/presentation/auth_controller.dart';
import '../features/auth/presentation/forgot/forgot_controller.dart';
import '../features/auth/presentation/forgot/forgot_screen.dart';
import '../features/auth/presentation/login/login_controller.dart';
import '../features/auth/presentation/login/login_screen.dart';
import '../features/auth/presentation/signup/signup_controller.dart';
import '../features/auth/presentation/signup/signup_screen.dart';
import '../features/dashboard/presentation/dashboard_controller.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/splash/presentation/splash_controller.dart';
import '../features/splash/presentation/splash_screen.dart';

enum AppRoute { splash, login, signup, forgot, dashboard }

extension AppRoutePath on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.splash:
        return '/';
      case AppRoute.login:
        return '/login';
      case AppRoute.signup:
        return '/signup';
      case AppRoute.forgot:
        return '/forgot';
      case AppRoute.dashboard:
        return '/dashboard';
    }
  }
}

class AppPages {
  const AppPages._();

  static final pages = [
    GetPage(
      name: AppRoute.splash.path,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(
        () => Get.put<SplashController>(SplashController()),
      ),
    ),
    GetPage(
      name: AppRoute.login.path,
      page: () => LoginScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<LoginController>(() => LoginController()),
      ),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoute.signup.path,
      page: () => SignupScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SignupController>(() => SignupController()),
      ),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoute.forgot.path,
      page: () => const ForgotScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ForgotController>(() => ForgotController()),
      ),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoute.dashboard.path,
      page: () => const DashboardScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut<DashboardController>(() => DashboardController()),
      ),
      middlewares: [AuthMiddleware()],
    ),
  ];
}

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    final isAuthRoute =
        route == AppRoute.login.path ||
        route == AppRoute.signup.path ||
        route == AppRoute.forgot.path;

    if (route == AppRoute.splash.path) return null;

    if (!authController.isAuthenticated.value && !isAuthRoute) {
      return RouteSettings(name: AppRoute.login.path);
    }

    if (authController.isAuthenticated.value && isAuthRoute) {
      return RouteSettings(name: AppRoute.dashboard.path);
    }

    return null;
  }
}
