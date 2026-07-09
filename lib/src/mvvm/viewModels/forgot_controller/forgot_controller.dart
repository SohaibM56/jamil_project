import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  final emailController = TextEditingController();

  void resetPassword() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
