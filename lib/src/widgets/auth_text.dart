import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTextStyles {
  AppTextStyles._();

  static const String satoshi = 'Satoshi';
  static const String clashDisplay = 'ClashDisplay';

  static TextStyle customText({
    Color? color,
    Paint? foreground,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double fontSize = 12,
    String fontFamily = satoshi,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
    double? height,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.sp,
      color: color,
      foreground: foreground,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
      height: height,
    );
  }

  static TextStyle customText16({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
    String fontFamily = satoshi,
    TextDecoration decoration = TextDecoration.none,
    Color? decorationColor,
  }) {
    return customText(
      color: color,
      fontSize: 16,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
      height: height,
      fontFamily: fontFamily,
    );
  }

  static TextStyle customText18({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
    String fontFamily = satoshi,
  }) {
    return customText(
      color: color,
      fontSize: 18,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily,
    );
  }

  static TextStyle customText20({
    Color? color,
    double? height,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    String fontFamily = satoshi,
  }) {
    return customText(
      color: color,
      fontSize: 20,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily,
    );
  }

  static TextStyle customText22({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    double? height,
    String fontFamily = satoshi,
  }) {
    return customText(
      color: color,
      fontSize: 22,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily,
    );
  }

  static TextStyle customText24({
    double? height,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    String fontFamily = satoshi,
  }) {
    return customText(
      color: color,
      fontSize: 24,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily,
    );
  }

  static TextStyle customText26({
    Color? color,
    double? height,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    String fontFamily = satoshi,
  }) {
    return customText(
      color: color,
      fontSize: 26,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily,
    );
  }

  static TextStyle customText28({
    Color? color,
    double? height,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    String fontFamily = satoshi,
  }) {
    return customText(
      color: color,
      fontSize: 28,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily,
    );
  }

  static TextStyle customText30({
    Color? color,
    double? height,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    String fontFamily = satoshi,
  }) {
    return customText(
      color: color,
      fontSize: 30,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      height: height,
      fontFamily: fontFamily,
    );
  }

  static TextStyle customText34({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    TextDecoration decoration = TextDecoration.none,
    double? height,
    String fontFamily = satoshi,
  }) {
    return customText(
      color: color,
      fontSize: 34,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
      fontFamily: fontFamily,
    );
  }

  static TextStyle customText38({
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing = 0,
    TextDecoration decoration = TextDecoration.none,
    double? height,
    String fontFamily = satoshi,
  }) {
    return customText(
      color: color,
      fontSize: 38,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height,
      fontFamily: fontFamily,
    );
  }
}
