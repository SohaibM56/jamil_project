import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamil_project/src/config/app_assets.dart';
import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';
import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';

class BlockedView extends StatelessWidget {
  const BlockedView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: SafeArea(
              top: false,
              child: Image.asset(AppAssets.loginBg, fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 37.w),
              child: Column(
                children: [
                  10.h.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () => SystemNavigator.pop(),
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.error,
                            width: 1.8.w,
                          ),
                        ),
                        child: Icon(
                          Icons.close,
                          size: 18.sp,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.block_flipped,
                    size: 80.sp,
                    color: AppColors.error,
                  ),
                  24.h.height,
                  Text(
                    'Account Blocked',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.customText34(
                      color: Colors.black,
                      letterSpacing: -1,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppTextStyles.clashDisplay,
                    ),
                  ),
                  16.h.height,
                  Text(
                    'Your account has been suspended by the administrator. Please contact support for further assistance.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.customText18(
                      color: AppColors.mutedText,
                      letterSpacing: -0.4,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Obx(
                    () => authController.isLoading.value
                        ? SizedBox(
                            width: 28.w,
                            height: 28.w,
                            child: const CircularProgressIndicator(
                              color: AppColors.primaryTeal,
                              strokeWidth: 2,
                            ),
                          )
                        : GestureDetector(
                            onTap: authController.logout,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.primaryTeal,
                                    width: 1.w,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 4.h),
                                child: Text(
                                  'Logout',
                                  style: AppTextStyles.customText34(
                                    color: AppColors.primaryTeal,
                                    letterSpacing: -0.5,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                  40.h.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
