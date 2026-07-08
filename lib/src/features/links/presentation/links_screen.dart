import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../dashboard/presentation/dashboard_controller.dart';
import '../../dashboard/presentation/widgets/dashboard_icons.dart';
import '../../dashboard/presentation/widgets/dashboard_page_scaffold.dart';
import 'widgets/add_link_dialog.dart';

class LinksScreen extends StatelessWidget {
  const LinksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();

    return DashboardPageScaffold(
      title: 'Smart Links',
      subtitle: 'Add, manage and remove links',
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 42.w),
          child: Column(
            children: [
              SizedBox(height: 22.h),
              GestureDetector(
                onTap: dashboardController.toggleSocialMediaExpanded,
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBAEFE3),
                    borderRadius: BorderRadius.circular(11.r),
                    border: Border.all(
                      color: const Color(0xFFD4D4D4),
                      width: 1.w,
                    ),
                  ),
                  child: Obx(
                    () => Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          'Social media',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Positioned(
                          right: 18.w,
                          child: AnimatedRotation(
                            turns: dashboardController.isSocialMediaExpanded.value
                                ? 0
                                : 0.5,
                            duration: const Duration(milliseconds: 180),
                            child: Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: AppColors.primaryTeal,
                              size: 24.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 34.h),
              Obx(
                () => AnimatedSize(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeOut,
                  child: dashboardController.isSocialMediaExpanded.value
                      ? Column(
                          children: [
                            _SocialLinkRow(
                              label: 'Whatsapp',
                              iconType: SocialIconType.whatsapp,
                              isAdded:
                                  dashboardController.socialLinks['Whatsapp'] ??
                                  false,
                              onTap: () => _handleSocialLinkTap(
                                context,
                                dashboardController,
                                label: 'Whatsapp',
                                iconType: SocialIconType.whatsapp,
                              ),
                            ),
                            _SocialLinkRow(
                              label: 'Instagram',
                              iconType: SocialIconType.instagram,
                              isAdded:
                                  dashboardController.socialLinks['Instagram'] ??
                                  false,
                              onTap: () => _handleSocialLinkTap(
                                context,
                                dashboardController,
                                label: 'Instagram',
                                iconType: SocialIconType.instagram,
                              ),
                            ),
                            _SocialLinkRow(
                              label: 'TikTok',
                              iconType: SocialIconType.tiktok,
                              isAdded:
                                  dashboardController.socialLinks['TikTok'] ??
                                  false,
                              onTap: () => _handleSocialLinkTap(
                                context,
                                dashboardController,
                                label: 'TikTok',
                                iconType: SocialIconType.tiktok,
                              ),
                            ),
                            _SocialLinkRow(
                              label: 'Facebook',
                              iconType: SocialIconType.facebook,
                              isAdded:
                                  dashboardController.socialLinks['Facebook'] ??
                                  false,
                              onTap: () => _handleSocialLinkTap(
                                context,
                                dashboardController,
                                label: 'Facebook',
                                iconType: SocialIconType.facebook,
                              ),
                            ),
                            _SocialLinkRow(
                              label: 'LinkedIn',
                              iconType: SocialIconType.linkedin,
                              isAdded:
                                  dashboardController.socialLinks['LinkedIn'] ??
                                  false,
                              onTap: () => _handleSocialLinkTap(
                                context,
                                dashboardController,
                                label: 'LinkedIn',
                                iconType: SocialIconType.linkedin,
                              ),
                            ),
                            _SocialLinkRow(
                              label: 'Snapchat',
                              iconType: SocialIconType.snapchat,
                              isAdded:
                                  dashboardController.socialLinks['Snapchat'] ??
                                  false,
                              onTap: () => _handleSocialLinkTap(
                                context,
                                dashboardController,
                                label: 'Snapchat',
                                iconType: SocialIconType.snapchat,
                              ),
                            ),
                            _SocialLinkRow(
                              label: 'Telegram',
                              iconType: SocialIconType.telegram,
                              isAdded:
                                  dashboardController.socialLinks['Telegram'] ??
                                  false,
                              onTap: () => _handleSocialLinkTap(
                                context,
                                dashboardController,
                                label: 'Telegram',
                                iconType: SocialIconType.telegram,
                              ),
                            ),
                            _SocialLinkRow(
                              label: 'X (Twitter)',
                              iconType: SocialIconType.x,
                              isAdded:
                                  dashboardController.socialLinks['X (Twitter)'] ??
                                  false,
                              onTap: () => _handleSocialLinkTap(
                                context,
                                dashboardController,
                                label: 'X (Twitter)',
                                iconType: SocialIconType.x,
                              ),
                            ),
                            _SocialLinkRow(
                              label: 'YouTube',
                              iconType: SocialIconType.youtube,
                              isAdded:
                                  dashboardController.socialLinks['YouTube'] ??
                                  false,
                              onTap: () => _handleSocialLinkTap(
                                context,
                                dashboardController,
                                label: 'YouTube',
                                iconType: SocialIconType.youtube,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSocialLinkTap(
    BuildContext context,
    DashboardController dashboardController, {
    required String label,
    required SocialIconType iconType,
  }) {
    if (dashboardController.socialLinks[label] ?? false) {
      dashboardController.removeSocialLink(label);
      return;
    }

    showAddLinkDialog(
      context: context,
      iconType: iconType,
      onAddLink: (url) => dashboardController.addSocialLink(label, url),
    );
  }
}

class _SocialLinkRow extends StatelessWidget {
  const _SocialLinkRow({
    required this.label,
    required this.iconType,
    required this.isAdded,
    required this.onTap,
  });

  final String label;
  final SocialIconType iconType;
  final bool isAdded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 52.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          SocialIcon(type: iconType, size: 28.w),
          SizedBox(width: 32.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                color: isAdded
                    ? AppColors.primaryTeal.withValues(alpha: 0.1)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFBAEFE3),
                  width: 1.5.w,
                ),
              ),
              child: Icon(
                isAdded ? Icons.check_rounded : Icons.add_rounded,
                size: 16.sp,
                color: AppColors.primaryTeal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
