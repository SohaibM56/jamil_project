import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';
import '../widgets/auth_text.dart';
import '../widgets/auth_text_field.dart';
import 'forgot_controller.dart';

class ForgotScreen extends GetView<ForgotController> {
  const ForgotScreen({super.key});

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
            bottom: MediaQuery.viewPaddingOf(context).bottom,
            child: Image.asset(
              AppAssets.forgotBg,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 38.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 42.h),
                  _BackButton(onTap: Get.back),
                  Spacer(),
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
                  SizedBox(height: 30.h),
                  AuthTextField(
                    controller: controller.emailController,
                    hintText: 'Email',
                  ).paddingOnly(right: 24.w),
                  SizedBox(height: 5.h),
                  const AuthText(
                    'Enter the email associated with your account',
                    fontSize: 18,
                    color: Color(0xFF595959),
                    letterSpacing: -0.2,
                  ),
                  SizedBox(height: 62.h),
                  GestureDetector(
                    onTap: controller.resetPassword,
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AuthText.action('Reset Password', fontSize: 38),
                        SizedBox(height: 7.h),
                        Container(
                          width: 90.w,
                          height: 1.h,
                          color: AppColors.primaryTeal,
                        ),
                      ],
                    ),
                  ),
                  Spacer(flex: 4,),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 31.w,
        height: 31.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryTeal, width: 1.8.w),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 17.sp,
          color: AppColors.primaryTeal,
        ),
      ),
    );
  }
}
