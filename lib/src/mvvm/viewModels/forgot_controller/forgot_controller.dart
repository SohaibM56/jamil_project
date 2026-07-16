import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';
import 'package:jamil_project/src/widgets/app_snackbar.dart';

class ForgotController extends GetxController {
  final emailController = TextEditingController();

  Future<void> resetPassword() async {
    FocusManager.instance.primaryFocus?.unfocus();

    final email = emailController.text.trim();
    if (email.isEmpty) {
      AppSnackbar.error('Error', 'Please enter your email.');
      return;
    }

    await Get.find<AuthController>().forgotPassword(email);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
