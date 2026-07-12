import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.h,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: AppColors.primaryTeal,
        style: AppTextStyles.customText18(
          fontFamily: AppTextStyles.clashDisplay,
          color: Colors.black,
          height: 1,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.customText22(
            color: AppColors.inputHint,
            fontFamily: AppTextStyles.clashDisplay,
            height: 1,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.4,
          ),
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(15.w, 15.h, 10.w, 15.h),
          suffixIcon: suffixIcon,
          suffixIconColor: AppColors.primaryTeal,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.black, width: 1.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.black, width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: AppColors.primaryTeal, width: 1.w),
          ),
        ),
      ),
    );
  }
}
