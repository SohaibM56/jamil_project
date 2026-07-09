import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamil_project/src/config/padding_extensions.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';
import 'package:jamil_project/src/mvvm/viewModels/dashboard_controller/dashboard_controller.dart';
import 'package:jamil_project/src/widgets/dashboard_icons.dart';
import 'package:jamil_project/src/widgets/responsive_switch.dart';

import '../../../../widgets/auth_text.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final dashboardController = Get.find<DashboardController>();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          50.h.height,
          Text(
            "Settings",
            style: AppTextStyles.customText34(
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),

          30.h.height,

          Container(
            height: 60.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFBAEFE3),
              border: Border.all(color: Colors.black, width: 1.w),
              borderRadius: BorderRadius.circular(16.r),
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
                      border: Border.all(
                        color: const Color(0xFF666666),
                        width: 1.w,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          dashboardController.profileImageUrl.value,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                16.w.width,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Abdullah Jamil',
                        style: AppTextStyles.customText20(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '--',
                        style: AppTextStyles.customText16(color: Colors.black),
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
          24.h.height,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.contrast_rounded, size: 25.sp, color: Colors.black),
                5.w.width,
                Expanded(
                  child: Text(
                    'Dark Mode',
                    style: AppTextStyles.customText22(
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
          32.h.height,
          _SettingsOption(
            label: 'Privacy policy',
            iconType: SettingsIconType.privacy,
            onTap: () => Get.snackbar(
              'Privacy policy',
              'Privacy policy will be available soon.',
            ),
          ),
          12.h.height,
          Divider(
            color: Colors.black.withValues(alpha: 0.2),
            height: 1.h,
            thickness: 1.h,
          ).paddingHorizontal(50.w),
          12.h.height,
          _SettingsOption(
            label: 'Terms and conditions',
            iconType: SettingsIconType.terms,
            onTap: () => Get.snackbar(
              'Terms and conditions',
              'Terms and conditions will be available soon.',
            ),
          ),
          12.h.height,
          Divider(
            color: Colors.black.withValues(alpha: 0.2),
            height: 1.h,
            thickness: 1.h,
          ).paddingHorizontal(50.w),
          12.h.height,
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
          12.h.height,
          Divider(
            color: Colors.black.withValues(alpha: 0.2),
            height: 1.h,
            thickness: 1.h,
          ).paddingHorizontal(50.w),
          12.h.height,
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
                      style: AppTextStyles.customText18(
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
      ).paddingHorizontal(30.w),
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
                style: AppTextStyles.customText20(
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withValues(alpha: 0.5),
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
