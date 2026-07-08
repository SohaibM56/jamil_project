import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../auth_controller.dart';
import 'login_controller.dart';
import '../widgets/auth_text.dart';
import '../widgets/auth_text_field.dart';
import '../../../../routing/app_router.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});

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
            child: Image.asset(
              AppAssets.loginBg,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 37.w),
              child: Column(
                children: [
                  SizedBox(height: 42.h),
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
                  SizedBox(height: 40.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      AppAssets.whiteLogo,
                      width: 100.w,
                      height: 50.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const AuthText.brand('Jamil Cards'),
                  SizedBox(height: 38.h),
                  const AuthText.subtitle('Sign in your account'),
                  SizedBox(height: 48.h),
                  AuthTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                  ),
                  SizedBox(height: 16.h),
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
                  SizedBox(height: 7.h),
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
                      child: const AuthText.link(
                        'Forgot your password?',
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 26.h),
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
                                child: const AuthText.action('Login'),
                              ),
                            ),
                          ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AuthText.muted("Don't have an account?  "),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoute.signup.path),
                        child: const AuthText.link('Signup'),
                      ),
                    ],
                  ),
                  SizedBox(height: 120.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
