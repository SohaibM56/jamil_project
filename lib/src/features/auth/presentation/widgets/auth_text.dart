import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_colors.dart';

class AuthText extends StatelessWidget {
  const AuthText(
    this.text, {
    super.key,
    this.fontSize = 16,
    this.color = Colors.black,
    this.fontFamily = 'Satoshi',
    this.fontWeight = FontWeight.w400,
    this.letterSpacing,
    this.textAlign,
    this.decoration,
  });

  const AuthText.brand(
    this.text, {
    super.key,
    this.textAlign = TextAlign.center,
  }) : fontSize = 34,
       color = Colors.black,
       fontFamily = 'ClashDisplay',
       fontWeight = FontWeight.w400,
       letterSpacing = -1.1,
       decoration = null;

  const AuthText.subtitle(
    this.text, {
    super.key,
    this.textAlign = TextAlign.center,
  }) : fontSize = 24,
       color = Colors.black,
       fontFamily = 'Satoshi',
       fontWeight = FontWeight.w400,
       letterSpacing = -1,
       decoration = null;

  const AuthText.action(
    this.text, {
    super.key,
    this.fontSize = 28,
    this.textAlign,
  }) : color = AppColors.primaryTeal,
       fontFamily = 'Satoshi',
       fontWeight = FontWeight.w400,
       letterSpacing = -0.5,
       decoration = null;

  const AuthText.link(
    this.text, {
    super.key,
    this.fontSize = 16,
    this.textAlign,
    this.decoration,
  }) : color = AppColors.primaryTeal,
       fontFamily = 'Satoshi',
       fontWeight = FontWeight.w400,
       letterSpacing = -0.4;

  const AuthText.muted(
    this.text, {
    super.key,
    this.fontSize = 16,
    this.textAlign,
  }) : color = AppColors.mutedText,
       fontFamily = 'Satoshi',
       fontWeight = FontWeight.w400,
       letterSpacing = -0.4,
       decoration = null;

  final String text;
  final double fontSize;
  final Color color;
  final String fontFamily;
  final FontWeight fontWeight;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize.sp,
        height: 1,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
        color: color,
        decoration: decoration,
      ),
    );
  }
}
