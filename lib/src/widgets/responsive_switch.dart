import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jamil_project/src/config/app_colors.dart';

class ResponsiveSwitch extends StatelessWidget {
  const ResponsiveSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor = const Color(0xFF34C759),
    this.inactiveColor = Colors.black,
    this.thumbColor = Colors.white,
    this.width,
    this.height,
    this.thumbSize,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final Color thumbColor;
  final double? width;
  final double? height;
  final double? thumbSize;

  @override
  Widget build(BuildContext context) {
    final switchWidth = width ?? 52.w;
    final switchHeight = height ?? 28.h;
    final knobSize = thumbSize ?? 22.w;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: switchWidth,
        height: switchHeight,
        padding: EdgeInsets.all(
          ((switchHeight - knobSize) / 2).clamp(1.0, 4.0),
        ),
        decoration: BoxDecoration(
          color: value ? activeColor : inactiveColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: knobSize,
            height: knobSize,
            decoration: BoxDecoration(
              color: value
                  ? thumbColor
                  : Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
