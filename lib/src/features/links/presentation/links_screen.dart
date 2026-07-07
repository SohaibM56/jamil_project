import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                  color: const Color(0xFFF3F8F7),
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
                        ],
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
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
      margin: EdgeInsets.symmetric(horizontal: 35.w),
      height: 52.h,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFD3D3D3))),
      ),
      child: Row(
        children: [
          SocialIcon(type: iconType, size: 30.w),
          SizedBox(width: 68.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 17.sp,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                color: isAdded
                    ? AppColors.primaryTeal
                    : AppColors.primaryTeal.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.w),
              ),
              child: Icon(
                isAdded ? Icons.check_rounded : Icons.add,
                size: 14.sp,
                color: isAdded ? Colors.white : Colors.black,
              ),
            ),
          ),
          SizedBox(width: 11.w),
        ],
      ),
    );
  }
}
