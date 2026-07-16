import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';
import 'package:jamil_project/src/mvvm/viewModels/forgot_controller/forgot_controller.dart';
import 'package:jamil_project/src/mvvm/viewModels/login_controller/login_controller.dart';
import 'package:jamil_project/src/mvvm/viewModels/signup_controller/signup_controller.dart';
import 'package:jamil_project/src/mvvm/viewModels/dashboard_controller/dashboard_controller.dart';
import 'package:jamil_project/src/mvvm/views/dashboard_view/dashboard_view.dart';
import 'package:jamil_project/src/repos/card_repository.dart';
import 'package:jamil_project/src/repos/storage_repository.dart';
import 'package:jamil_project/src/mvvm/viewModels/splash_controller/splash_controller.dart';
import 'package:jamil_project/src/mvvm/views/splash_view/splash_view.dart';

import '../mvvm/views/auth_views/forgot_view/forgot_view.dart';
import '../mvvm/views/auth_views/login_view/login_view.dart';
import '../mvvm/views/auth_views/signup_view/signup_view.dart';

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
      page: () => const SplashView(),
      binding: BindingsBuilder(
        () => Get.put<SplashController>(SplashController()),
      ),
    ),
    GetPage(
      name: AppRoute.login.path,
      page: () => LoginView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<LoginController>(() => LoginController()),
      ),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoute.signup.path,
      page: () => SignupView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<SignupController>(() => SignupController()),
      ),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoute.forgot.path,
      page: () => ForgotView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<ForgotController>(() => ForgotController()),
      ),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppRoute.dashboard.path,
      page: () => const DashboardView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<DashboardController>(
          () => DashboardController(
            Get.find<CardRepository>(),
            Get.find<StorageRepository>(),
          ),
        ),
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
