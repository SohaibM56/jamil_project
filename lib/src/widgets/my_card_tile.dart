import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';

/// The "My Card" business-card tile shown on the account view.
///
/// Sizes itself to its content (no fixed height) so it never overflows,
/// and keeps text clear of the avatar (top-right) and the action icons
/// (bottom-right) by reserving space on the right edge.
class MyCardTile extends StatelessWidget {
  const MyCardTile({
    super.key,
    required this.name,
    required this.title,
    required this.phone,
    required this.email,
    required this.imageUrl,
    required this.isUpdatingPhoto,
    required this.onEditPhoto,
    required this.onEditCard,
    required this.onViewPublic,
  });

  final String name;
  final String title;
  final String phone;
  final String email;
  final String imageUrl;
  final bool isUpdatingPhoto;
  final VoidCallback onEditPhoto;
  final VoidCallback onEditCard;
  final VoidCallback onViewPublic;

  @override
  Widget build(BuildContext context) {
    final hasTitle = title.trim().isNotEmpty;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          // Reserve the right edge for the avatar + action icons.
          constraints: BoxConstraints(minHeight: 150.h),
          padding: EdgeInsets.fromLTRB(22.w, 22.h, 100.w, 18.h),
          decoration: BoxDecoration(
            color: AppColors.primaryTealLight,
            border: Border.all(color: Colors.black, width: 2.w),
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20.r,
                offset: Offset(0, 10.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.customText20(
                  fontWeight: FontWeight.w700,
                  fontFamily: AppTextStyles.clashDisplay,
                  height: 1.15,
                ),
              ),
              if (hasTitle) ...[
                SizedBox(height: 5.h),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.customText(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: AppTextStyles.clashDisplay,
                    color: Colors.black.withValues(alpha: 0.75),
                  ),
                ),
              ],
              SizedBox(height: 12.h),
              Text(
                phone,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.customText(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: AppTextStyles.clashDisplay,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                email,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.customText(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: Colors.black.withValues(alpha: 0.85),
                  fontFamily: AppTextStyles.clashDisplay,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -10.h,
          right: -10.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96.w,
                height: 96.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2.w),
                  image: imageUrl.isEmpty
                      ? null
                      : DecorationImage(
                          image: NetworkImage(imageUrl),
                          fit: BoxFit.cover,
                        ),
                ),
                child: isUpdatingPhoto
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryTeal,
                          strokeWidth: 2,
                        ),
                      )
                    : (imageUrl.isEmpty
                          ? Icon(
                              Icons.person_outline,
                              color: const Color(0xFFB0B0B0),
                              size: 36.sp,
                            )
                          : null),
              ),
              Positioned(
                top: 2.h,
                right: 2.w,
                child: GestureDetector(
                  onTap: onEditPhoto,
                  child: Container(
                    padding: EdgeInsets.all(5.w),
                    decoration: const BoxDecoration(
                      color: Color(0xFF666666),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.edit, size: 12.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 14.w,
          bottom: 14.h,
          child: Column(
            children: [
              _SmallRoundIcon(icon: Icons.edit, onTap: onEditCard),
              SizedBox(height: 8.h),
              _SmallRoundIcon(
                icon: Icons.visibility_outlined,
                onTap: onViewPublic,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SmallRoundIcon extends StatelessWidget {
  const _SmallRoundIcon({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 12.r,
        backgroundColor: Colors.black.withValues(alpha: 0.62),
        child: Icon(icon, size: 12.sp, color: Colors.white),
      ),
    );
  }
}
