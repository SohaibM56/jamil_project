import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

import 'package:jamil_project/src/config/app_assets.dart';
import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';
import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';
import 'package:jamil_project/src/mvvm/viewModels/forgot_controller/forgot_controller.dart';

import '../../../../widgets/auth_text_field.dart';

class ForgotView extends GetView<ForgotController> {
  ForgotView({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).padding.bottom,
            child: Image.asset(AppAssets.forgotBg, fit: BoxFit.fitWidth),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 38.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.h.height,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: Get.back,
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 24.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryTeal,
                            width: 1.8.w,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 14.sp,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                    ),
                  ),
                  100.h.height,
                  Text(
                    'Forgot your\npassword?',
                    style: TextStyle(
                      fontFamily: 'ClashDisplay',
                      fontSize: 32.sp,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -1.1,
                      color: Colors.black,
                    ),
                  ),
                  30.h.height,
                  AuthTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                    textInputType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                  ).paddingOnly(right: 25.w),
                  5.h.height,
                  Text(
                    'Enter the email associated with your account',
                    style: AppTextStyles.customText18(
                      color: const Color(0xFF595959),
                      letterSpacing: -0.2,
                      height: 1,
                    ),
                  ),
                  62.h.height,
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
                            onTap: controller.resetPassword,
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Reset Password',
                                  style: AppTextStyles.customText38(
                                    color: AppColors.primaryTeal,
                                    letterSpacing: -0.5,
                                    height: 1,
                                  ),
                                ),
                                4.h.height,
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryTeal,
                                  ),
                                  width: 80.w,
                                  height: 1.h,
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
