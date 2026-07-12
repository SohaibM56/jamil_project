import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jamil_project/src/config/app_assets.dart';
import 'package:jamil_project/src/config/app_colors.dart';

class DashboardBottomNav extends StatelessWidget {
  const DashboardBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<IconData?> _icons = [
    null,
    Icons.person_outline_rounded,
    null,
    Icons.settings_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return SizedBox(
      height: 78.h + bottomInset,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomInset,
            child: Container(
              height: 54.h,
              decoration: BoxDecoration(
                color: AppColors.primaryTealLight,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                border: Border(
                  top: BorderSide(color: AppColors.primaryTealLight),
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: 0,
            bottom: bottomInset,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                _icons.length,
                (index) => _DashboardNavItem(
                  icon: _icons[index],
                  svgAsset: index == 0 ? AppAssets.qrScanner : index ==2 ? AppAssets.link : null,
                  index: index,
                  isSelected: currentIndex == index,
                  onTap: () => onTap(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardNavItem extends StatelessWidget {
  const _DashboardNavItem({
    required this.icon,
    required this.svgAsset,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  final IconData? icon;
  final String? svgAsset;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 72.w,
        height: 72.h,
        child: Align(
          alignment: Alignment.topCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 58.w,
            height: 58.w,
            margin: EdgeInsets.only(top: 2.h),
            decoration: BoxDecoration(
              color: !isSelected ? Colors.white : AppColors.primaryTealLight,
              shape: BoxShape.circle,
              border: !isSelected
                  ? Border.all(
                      color: Colors.black.withValues(alpha: 0.72),
                      width: 1.w,
                    )
                  : null,
              boxShadow: !isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.22),
                        blurRadius: 1.r,
                        offset: Offset(0, 2.h),
                      ),
                      BoxShadow(
                        color: AppColors.primaryTeal.withValues(alpha: 0.35),
                        blurRadius: 9.r,
                        spreadRadius: 1.r,
                        offset: Offset(0, 8.h),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: svgAsset != null
                  ? SvgPicture.asset(svgAsset!, width: 42.sp, height: 42.sp)
                  : Icon(icon, size: 42.sp, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
