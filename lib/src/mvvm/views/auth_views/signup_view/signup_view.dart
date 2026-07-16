import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamil_project/src/config/padding_extensions.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';
import 'package:jamil_project/src/config/app_assets.dart';
import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/mvvm/viewModels/auth_controller/auth_controller.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';
import 'package:jamil_project/src/mvvm/viewModels/signup_controller/signup_controller.dart';
import 'package:jamil_project/src/config/app_router.dart';

class SignupView extends GetView<SignupController> {
  SignupView({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final imageHeight = constraints.maxHeight * 0.28;
          final imageWidth = constraints.maxWidth;

          return Stack(
            children: [
              Positioned(
                left: 0.w,
                bottom: 0.h,
                width: imageWidth,
                height: imageHeight,
                child: Image.asset(
                  AppAssets.signupBg,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomLeft,
                  cacheWidth:
                      (imageWidth * MediaQuery.devicePixelRatioOf(context))
                          .ceil(),
                ),
              ),

              // Signup Form Content
              SafeArea(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.h.height,
                      // Back Button
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
                      26.h.height,
                      // Title
                      Text(
                        'Signup',
                        style: AppTextStyles.customText34(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          fontFamily: AppTextStyles.clashDisplay,
                        ),
                      ),
                      10.h.height,
                      Text(
                        'Create your Jamil account',
                        style: AppTextStyles.customText26(
                          color: Colors.black,
                          height: 1,
                          fontWeight: FontWeight.w500,
                          fontFamily: AppTextStyles.clashDisplay,
                        ),
                      ),
                      24.h.height,
                      // Fields
                      _buildFieldLabel('Email'),
                      _buildTextField(controller.emailController),
                      12.h.height,
                      _buildFieldLabel('Name'),
                      _buildTextField(controller.nameController),
                      12.h.height,
                      _buildFieldLabel('Phone Number'),
                      _buildTextField(
                        controller.phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      12.h.height,
                      _buildFieldLabel('Password'),
                      Obx(
                        () => _buildTextField(
                          controller.passwordController,
                          obscureText: controller.obscurePassword.value,
                          textInputAction: TextInputAction.done,
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
                      76.h.height,
                      // Signup Button (Underlined text)
                      Center(
                        child: Obx(
                          () => GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              authController.isLoading.value
                                  ? null
                                  : controller.signup();
                            },
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
                                    child: Text(
                                      'Signup',
                                      style: AppTextStyles.customText34(
                                        color: AppColors.primaryTeal,
                                        letterSpacing: -0.5,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: AppTextStyles.clashDisplay,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      100.h.height,
                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account? ",
                            style: AppTextStyles.customText22(
                              color: AppColors.mutedText,
                              letterSpacing: -0.4,
                              height: 1,
                              fontFamily: AppTextStyles.clashDisplay,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.offNamed(AppRoute.login.path),
                            child: Text(
                              'Login',
                              style: AppTextStyles.customText22(
                                color: AppColors.primaryTeal,
                                letterSpacing: -0.4,
                                height: 1,
                                fontFamily: AppTextStyles.clashDisplay,
                              ),
                            ),
                          ),
                        ],
                      ),
                      16.h.height,
                      // Terms and Conditions
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'by clicking signup you agree to our ',
                            style: AppTextStyles.customText(
                              color: Colors.black,
                              fontSize: 16.sp,
                              letterSpacing: -0.4,
                              height: 1,
                              fontFamily: AppTextStyles.clashDisplay,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Terms & Conditions',
                              style: AppTextStyles.customText(
                                color: AppColors.primaryTeal,
                                fontSize: 16.sp,
                                letterSpacing: -0.4,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryTeal,
                                height: 1,
                                fontFamily: AppTextStyles.clashDisplay,
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.h.height,
                    ],
                  ).paddingHorizontal(32.w),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        label,
        style: AppTextStyles.customText(
          color: Colors.black.withValues(alpha: 0.5),
          fontSize: 24.sp,
          height: 1,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType = TextInputType.text,
    TextInputAction? textInputAction = TextInputAction.next,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(color: Colors.black87, fontSize: 20.sp),
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        inputFormatters: keyboardType == TextInputType.phone
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
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
