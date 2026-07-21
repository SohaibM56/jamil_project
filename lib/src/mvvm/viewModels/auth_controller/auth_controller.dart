import 'dart:async';

import 'package:get/get.dart';

import 'package:jamil_project/src/repos/auth_repository.dart';
import 'package:jamil_project/src/config/app_router.dart';
import 'package:jamil_project/src/widgets/app_snackbar.dart';
import 'package:jamil_project/src/widgets/reauthenticate_dialog.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  AuthController(this._authRepository);

  final AuthRepository _authRepository;
  final isLoading = false.obs;
  final isAuthenticated = false.obs;
  StreamSubscription<bool>? _blockSub;

  @override
  void onInit() {
    super.onInit();
    isAuthenticated.value = _authRepository.isLoggedIn();
    if (isAuthenticated.value) {
      _startBlockedListener(_authRepository.currentUid!);
    }
  }

  @override
  void onClose() {
    _blockSub?.cancel();
    super.onClose();
  }


  Future<void> login(String email, String password) async {
    await _runAuthAction(() async {
      await _authRepository.login(email, password);
      isAuthenticated.value = true;
      _startBlockedListener(_authRepository.currentUid!);
      AppSnackbar.success('Welcome back', 'Logged in successfully.');
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
      _startBlockedListener(_authRepository.currentUid!);
      Get.offAllNamed(AppRoute.dashboard.path);
      AppSnackbar.success('Welcome', 'Account created successfully.');
    });
  }

  Future<void> logout() async {
    await _runAuthAction(() async {
      await _blockSub?.cancel();
      _blockSub = null;
      await _authRepository.logout();
      isAuthenticated.value = false;
      Get.offAllNamed(AppRoute.login.path);
      AppSnackbar.success('Logged out', 'You have been logged out.');
    });
  }

  Future<void> deleteAccount() async {
    final context = Get.context;
    if (context == null) return;

    final password = await showReauthenticateDialog(context: context);
    if (password == null) return;

    await _runAuthAction(() async {
      await _blockSub?.cancel();
      _blockSub = null;
      await _authRepository.deleteAccount(password);
      isAuthenticated.value = false;
      Get.offAllNamed(AppRoute.login.path);
      AppSnackbar.success('Account deleted', 'Your account has been deleted.');
    });
  }

  Future<void> forgotPassword(String email) async {
    await _runAuthAction(() async {
      await _authRepository.sendPasswordResetEmail(email);
      Get.back();
      AppSnackbar.success(
        'Check your email',
        'A password reset link has been sent to $email.',
      );
    });
  }

  void _startBlockedListener(String uid) {
    _blockSub?.cancel();
    _blockSub = _authRepository.watchBlocked(uid).listen((isBlocked) {
      if (isBlocked) {
        Get.offAllNamed(AppRoute.blocked.path);
      }
      else{
        Get.offAllNamed(AppRoute.dashboard.path);
      }
    });
  }

  Future<void> _runAuthAction(Future<void> Function() action) async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      await action();
    } catch (error) {
      AppSnackbar.error(
        'Error',
        error.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
