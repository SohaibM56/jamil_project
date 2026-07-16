import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';

class DashboardLoadingState extends StatelessWidget {
  const DashboardLoadingState({
    super.key,
    required this.hasError,
    required this.onRetry,
  });

  final bool hasError;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (!hasError) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryTeal),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Couldn't load your card.",
            style: AppTextStyles.customText20(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: AppTextStyles.clashDisplay,
            ),
          ),
          12.h.height,
          TextButton(
            onPressed: onRetry,
            child: Text(
              'Retry',
              style: AppTextStyles.customText18(
                color: AppColors.primaryTeal,
                fontFamily: AppTextStyles.clashDisplay,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
