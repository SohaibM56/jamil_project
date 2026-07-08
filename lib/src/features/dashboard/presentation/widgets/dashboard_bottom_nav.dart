import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constants/app_assets.dart';
import '../../../../constants/app_colors.dart';

class DashboardBottomNav extends StatelessWidget {
  const DashboardBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _icons = [
    Icons.qr_code_scanner_rounded,
    Icons.person_outline_rounded,
    Icons.link_rounded,
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
                color: AppColors.primaryTeal.withValues(alpha: 0.45),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                border: Border(
                  top: BorderSide(
                    color: AppColors.primaryTeal.withValues(alpha: 0.45),
                  ),
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
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
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
            margin: EdgeInsets.only(top: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryTeal
                    : Colors.black.withValues(alpha: 0.65),
                width: isSelected ? 1.3.w : 0.7.w,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 6.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: Center(
              child: isSelected
                  ? Icon(
                      icon,
                      size: 32.sp,
                      color: AppColors.primaryTeal,
                    )
                  : Icon(
                      icon,
                      size: 32.sp,
                      color: Colors.black,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
