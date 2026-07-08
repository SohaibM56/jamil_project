import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../dashboard/presentation/dashboard_controller.dart';
import '../../dashboard/presentation/widgets/dashboard_icons.dart';
import '../../dashboard/presentation/widgets/dashboard_page_scaffold.dart';
import '../../dashboard/presentation/widgets/responsive_switch.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final dashboardController = Get.find<DashboardController>();

    return DashboardPageScaffold(
      title: 'Settings',
      headerHeight: 120,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            Container(
              height: 72.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFBAEFE3),
                border: Border.all(color: Colors.black, width: 1.w),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Row(
                children: [
                  Obx(
                    () => Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: const Color(0xFF666666), width: 1.w),
                        image: DecorationImage(
                          image: NetworkImage(
                              dashboardController.profileImageUrl.value),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Abdullah Jamil',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          '--',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 14.sp,
                            color: const Color(0xFF666666),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: const Color(0xFFB0B0B0),
                    size: 24.sp,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                children: [
                  Icon(
                    Icons.contrast_rounded,
                    size: 24.sp,
                    color: Colors.black,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Obx(
                    () => ResponsiveSwitch(
                      value: dashboardController.isDarkMode.value,
                      onChanged: dashboardController.toggleDarkMode,
                      width: 44.w,
                      height: 24.h,
                      thumbSize: 20.w,
                      inactiveColor: Colors.black,
                      thumbColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            _SettingsOption(
              label: 'Privacy policy',
              iconType: SettingsIconType.privacy,
              onTap: () => Get.snackbar(
                'Privacy policy',
                'Privacy policy will be available soon.',
              ),
            ),
            SizedBox(height: 16.h),
            _SettingsOption(
              label: 'Terms and conditions',
              iconType: SettingsIconType.terms,
              onTap: () => Get.snackbar(
                'Terms and conditions',
                'Terms and conditions will be available soon.',
              ),
            ),
            SizedBox(height: 16.h),
            Obx(
              () => _SettingsOption(
                label: authController.isLoading.value
                    ? 'Logging out...'
                    : 'Logout',
                iconType: SettingsIconType.logout,
                onTap: authController.isLoading.value
                    ? null
                    : authController.logout,
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => Get.snackbar(
                'Delete account',
                'Account deletion flow will be available soon.',
              ),
              child: Container(
                height: 52.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF84E55),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Delete my account',
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(Icons.cancel_outlined, color: Colors.white, size: 20.sp),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsOption extends StatelessWidget {
  const _SettingsOption({
    required this.label,
    required this.iconType,
    this.onTap,
  });

  final String label;
  final SettingsIconType iconType;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F7F6),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: 16.sp,
                  color: const Color(0xFF555555),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SettingsGlyph(
              type: iconType,
              size: 22.sp,
              color: const Color(0xFF666666),
            ),
          ],
        ),
      ),
    );
  }
}
