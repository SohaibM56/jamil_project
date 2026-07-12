import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamil_project/src/config/app_assets.dart';
import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';
import 'package:jamil_project/src/mvvm/viewModels/login_controller/login_controller.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';
import 'package:jamil_project/src/config/app_router.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

import '../../../../widgets/auth_text_field.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
                  Spacer(),

                  Image.asset(AppAssets.loginHeaderImg, height: 70.h,),

                  16.h.height,

                  Text(
                    'Sign in your account',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.customText34(
                      color: Colors.black,
                      letterSpacing: -1,
                      height: 1,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppTextStyles.clashDisplay,
                    ),
                  ),
                  64.h.height,
                  AuthTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                  ),
                  16.h.height,
                  Obx(
                    () => AuthTextField(
                      controller: controller.passwordController,
                      hintText: 'Password',
                      obscureText: controller.obscurePassword.value,
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints.tightFor(
                          width: 44.w,
                          height: 44.h,
                        ),
                        icon: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 22.sp,
                          color: AppColors.primaryTeal,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  10.h.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.toNamed(AppRoute.forgot.path),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryTeal,
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Forgot your password?',
                        style: AppTextStyles.customText(
                          color: AppColors.primaryTeal,
                          fontSize: 18,
                          letterSpacing: -0.4,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                  34.h.height,
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
                            onTap: controller.login,
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
                                  'Login',
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
                  const Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?  ",
                        style: AppTextStyles.customText22(
                          color: AppColors.mutedText,
                          letterSpacing: -0.4,
                          height: 1,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoute.signup.path),
                        child: Text(
                          'Signup',
                          style: AppTextStyles.customText22(
                            color: AppColors.primaryTeal,
                            letterSpacing: -0.4,
                            height: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
