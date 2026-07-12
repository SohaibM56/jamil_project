import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/mvvm/viewModels/dashboard_controller/dashboard_controller.dart';
import 'package:jamil_project/src/widgets/dashboard_icons.dart';
import 'package:jamil_project/src/widgets/add_link_dialog.dart';

import '../../../../config/padding_extensions.dart';
import '../../../../widgets/auth_text.dart';

class LinksView extends StatelessWidget {
  const LinksView({super.key});

  static const List<({String label, SocialIconType iconType})> _socialMediaLinks = [
    (label: 'Whatsapp', iconType: SocialIconType.whatsapp),
    (label: 'Instagram', iconType: SocialIconType.instagram),
    (label: 'TikTok', iconType: SocialIconType.tiktok),
    (label: 'Facebook', iconType: SocialIconType.facebook),
    (label: 'LinkedIn', iconType: SocialIconType.linkedin),
    (label: 'Snapchat', iconType: SocialIconType.snapchat),
    (label: 'Telegram', iconType: SocialIconType.telegram),
    (label: 'X (Twitter)', iconType: SocialIconType.x),
    (label: 'YouTube', iconType: SocialIconType.youtube),
  ];

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        60.h.height,
        Text(
          "Smart Links",
          style: AppTextStyles.customText34(
            fontWeight: FontWeight.w800,
            color: Colors.black,
            fontFamily: AppTextStyles.clashDisplay
          ),
        ),
        2.h.height,
        Text(
          "Add, manage and remove links",
          style: AppTextStyles.customText24(
            fontWeight: FontWeight.w400,
            color: Colors.black,
              fontFamily: AppTextStyles.clashDisplay
          ),
        ),
        50.h.height,
        GestureDetector(
          onTap: dashboardController.toggleSocialMediaExpanded,
          child: Material(
            elevation: 1.sp,
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              width: double.infinity,
              height: 50.h,
              decoration: BoxDecoration(
                color: Color.fromRGBO(238, 245, 244,100),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10.r,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: Obx(
                () => Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Social media',
                      style: AppTextStyles.customText20(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: AppTextStyles.clashDisplay
                      )
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
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        20.h.height,
        Obx(
          () => Expanded(
            child: AnimatedSize(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              child: dashboardController.isSocialMediaExpanded.value
                  ? ListView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: _socialMediaLinks.length,
                      itemBuilder: (context, index) {
                        final link = _socialMediaLinks[index];
                        return _SocialLinkRow(
                          label: link.label,
                          iconType: link.iconType,
                          isAdded: dashboardController.socialLinks[link.label] ?? false,
                          onTap: () => _handleSocialLinkTap(
                            context,
                            dashboardController,
                            label: link.label,
                            iconType: link.iconType,
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
            ).paddingHorizontal(30.w),
    );
  }

  void _handleSocialLinkTap(BuildContext context, DashboardController dashboardController, {required String label, required SocialIconType iconType,}) {
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
      margin: EdgeInsets.symmetric(vertical: 2.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 48.h,
      decoration: BoxDecoration(
        color: Color.fromRGBO(238, 245, 244,100),
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
          32.w.width,
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.customText18(
                fontFamily: AppTextStyles.clashDisplay,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                color:Color.fromRGBO(203, 247, 240,100),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 1.w,
                ),
              ),
              child: Icon(
                isAdded ? Icons.check_rounded : Icons.add_rounded,
                size: 14.sp,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ).paddingHorizontal(30.w);
  }
}
