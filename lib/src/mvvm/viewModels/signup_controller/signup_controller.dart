import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';
import 'package:jamil_project/src/widgets/app_snackbar.dart';

class SignupController extends GetxController {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  Future<void> signup() async {
    final email = emailController.text.trim();
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || name.isEmpty || phone.isEmpty || password.isEmpty) {
      AppSnackbar.error('Error', 'Please fill in all fields.');
      return;
    }

    await Get.find<AuthController>().signup(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
