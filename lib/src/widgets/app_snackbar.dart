import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jamil_project/src/config/app_colors.dart';

class AppSnackbar {
  const AppSnackbar._();

  static void success(String title, String message) {
    _show(title, message, backgroundColor: AppColors.success);
  }

  static void error(String title, String message) {
    _show(title, message, backgroundColor: AppColors.error);
  }

  static void info(String title, String message) {
    _show(title, message, backgroundColor: AppColors.primaryTeal);
  }

  static void _show(
    String title,
    String message, {
    required Color backgroundColor,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      icon: const Icon(Icons.info_outline, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }
}
