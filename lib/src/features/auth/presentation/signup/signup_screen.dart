import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_sizes.dart';
import '../auth_controller.dart';
import '../widgets/auth_text.dart';
import 'signup_controller.dart';
import '../../../../routing/app_router.dart';

class SignupScreen extends GetView<SignupController> {
  SignupScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final imageCacheHeight =
        (MediaQuery.sizeOf(context).height *
                MediaQuery.devicePixelRatioOf(context))
            .ceil();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image (mostly visible at the bottom)
          Positioned.fill(
            child: Image.asset(
              AppAssets.signupBg,
              fit: BoxFit.cover,
              cacheHeight: imageCacheHeight,
            ),
          ),
          // White overlay for the top part to ensure it looks like the screenshot
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 200.h, // Show background at the bottom
            child: Container(color: Colors.white),
          ),
          // Signup Form Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.p32.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.p16.h),
                    // Back Button
                    GestureDetector(
                      onTap: () => Get.offNamed(AppRoute.login.path),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.primaryTeal.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 16.sp,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.p32.h),
                    // Title
                    const AuthText(
                      'Signup',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    const AuthText(
                      'Create your Jamil account',
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    SizedBox(height: AppSizes.p24.h),
                    // Fields
                    _buildFieldLabel('Email'),
                    _buildTextField(controller.emailController),
                    SizedBox(height: AppSizes.p12.h),
                    _buildFieldLabel('Name'),
                    _buildTextField(controller.nameController),
                    SizedBox(height: AppSizes.p12.h),
                    _buildFieldLabel('Phone Number'),
                    _buildTextField(controller.phoneController),
                    SizedBox(height: AppSizes.p12.h),
                    _buildFieldLabel('Password'),
                    Obx(
                      () => _buildTextField(
                        controller.passwordController,
                        obscureText: controller.obscurePassword.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.obscurePassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.primaryTeal,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.p32.h),
                    // Signup Button (Underlined text)
                    Center(
                      child: Obx(
                        () => GestureDetector(
                          onTap: authController.isLoading.value
                              ? null
                              : controller.signup,
                          child: Column(
                            children: [
                              if (authController.isLoading.value)
                                const CircularProgressIndicator(
                                  color: AppColors.primaryTeal,
                                )
                              else
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColors.primaryTeal,
                                        width: 1.5.w,
                                      ),
                                    ),
                                  ),
                                  child: const AuthText.action(
                                    'Signup',
                                    fontSize: 28,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSizes.p24.h),
                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AuthText.muted("Have an account? ", fontSize: 16),
                        GestureDetector(
                          onTap: () => Get.offNamed(AppRoute.login.path),
                          child: const AuthText.link('Login', fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.p12.h),
                    // Terms and Conditions
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          children: [
                            const AuthText.muted(
                              'by clicking signup you agree to our ',
                              fontSize: 13,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const AuthText.link(
                                'Terms & Conditions',
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 100.h), // Space to show background
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: AuthText(label, fontSize: 17, color: const Color(0xFFB0B0B0)),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black87, fontSize: 16.sp),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
