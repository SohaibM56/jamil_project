import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
              height: 66.h,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColors.primaryTeal.withValues(alpha: 0.45),
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      size: 32,
                      color: Color(0xFF8DC7BB),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Abdullah Jamil',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          '--',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 16.sp,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.edit_outlined,
                    color: const Color(0xFF6E968E),
                    size: 24.sp,
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Row(
                children: [
                  SettingsGlyph(type: SettingsIconType.darkMode, size: 20.w),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Text(
                      'Dark Mode',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Obx(
                    () => ResponsiveSwitch(
                      value: dashboardController.isDarkMode.value,
                      onChanged: dashboardController.toggleDarkMode,
                      width: 38.w,
                      height: 20.h,
                      thumbSize: 18.w,
                      inactiveColor: Colors.black,
                      thumbColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            _SettingsOption(
              label: 'Privacy policy',
              iconType: SettingsIconType.privacy,
              onTap: () => Get.snackbar(
                'Privacy policy',
                'Privacy policy will be available soon.',
              ),
            ),
            const _SettingsDivider(),
            _SettingsOption(
              label: 'Terms and conditions',
              iconType: SettingsIconType.terms,
              onTap: () => Get.snackbar(
                'Terms and conditions',
                'Terms and conditions will be available soon.',
              ),
            ),
            const _SettingsDivider(),
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
            const _SettingsDivider(),
            SizedBox(height: 0.h),
            Container(
              height: 50.h,
              margin: EdgeInsets.symmetric(horizontal: 0.w),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF84E55),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: GestureDetector(
                onTap: () => Get.snackbar(
                  'Delete account',
                  'Account deletion flow will be available soon.',
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Delete my account',
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Icon(Icons.close_rounded, color: Colors.white, size: 18.sp),
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
        height: 50.h,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F7F6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: 15.sp,
                  color: const Color(0xFF555555),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SettingsGlyph(type: iconType, size: 23.w),
          ],
        ),
      ),
    );
  }
}

class _SettingsDivider extends StatelessWidget {
  const _SettingsDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 264.w,
      height: 1.h,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      color: const Color(0xFFD8D8D8),
    );
  }
}
