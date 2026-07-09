import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

import 'package:jamil_project/src/mvvm/viewModels/dashboard_controller/dashboard_controller.dart';
import 'package:jamil_project/src/widgets/dashboard_icons.dart';
import 'package:jamil_project/src/widgets/responsive_switch.dart';
import 'package:jamil_project/src/widgets/edit_card_dialog.dart';

import '../../../../config/padding_extensions.dart';
import '../../../../widgets/auth_text.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  static const List<({String label, SocialIconType iconType})> _links = [
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          50.h.height,
          Text(
            "My Card",
            style: AppTextStyles.customText34(
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          2.h.height,
          Text(
            "Tap, Connect, Share",
            style: AppTextStyles.customText28(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          30.h.height,
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 180.h,
                padding: EdgeInsets.fromLTRB(30.w, 40.h, 20.w, 20.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFBAEFE3),
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
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dashboardController.cardName.value,
                        style: AppTextStyles.customText30(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        dashboardController.cardTitle.value,
                        style: AppTextStyles.customText24(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      2.h.height,
                      Text(
                        dashboardController.cardPhone.value,
                        style: AppTextStyles.customText20(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        dashboardController.cardEmail.value,
                        style: AppTextStyles.customText18(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )
                      ),
                    ],
                  ),
                ),
              ).paddingHorizontal(5.w),
              Positioned(
                top: -10.h,
                right: -10.w,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Obx(
                      () => Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 2.w),
                          image: DecorationImage(
                            image: NetworkImage(
                              dashboardController.profileImageUrl.value,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2.h,
                      right: 2.w,
                      child: Container(
                        padding: EdgeInsets.all(5.w),
                        decoration: const BoxDecoration(
                          color: Color(0xFF666666),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 15.w,
                bottom: 15.h,
                child: Column(
                  children: [
                    _SmallRoundIcon(
                      icon: Icons.edit,
                      onTap: () => showEditCardDialog(
                        context: context,
                        onUpdate: dashboardController.updateCard,
                      ),
                    ),
                    8.h.height,
                    const _SmallRoundIcon(icon: Icons.visibility_outlined),
                  ],
                ),
              ),
            ],
          ),
          42.h.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _DividerLine(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Text(
                  'Your Links',
                  style: AppTextStyles.customText20(
                    color: Colors.black.withValues(alpha: 0.8),
                  )
                ),
              ),
              const _DividerLine(),
            ],
          ),
          22.h.height,
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _links.length,
            itemBuilder: (context, index) {
              final link = _links[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h, left: 5.w, right: 5.w),
                child: Obx(
                  () => _ProfileLinkRow(
                    label: link.label,
                    iconType: link.iconType,
                    isEnabled: dashboardController.profileLinks[link.label] ?? false,
                    onChanged: (value) => dashboardController.toggleProfileLink(link.label, value),
                  ),
                ),
              );
            },
          ),
        ],
      ).paddingHorizontal(30.w),
    ),
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
        radius: 10.r,
        backgroundColor: Colors.black.withValues(alpha: 0.62),
        child: Icon(icon, size: 10.sp, color: Colors.white),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(width: 58.w, height: 2.h, color: const Color(0xFF777777));
  }
}

class _ProfileLinkRow extends StatelessWidget {
  const _ProfileLinkRow({
    required this.label,
    required this.iconType,
    required this.isEnabled,
    required this.onChanged,
  });

  final String label;
  final SocialIconType iconType;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.sp,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F7F6),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.w, right: 8.w),
              child: Icon(
                Icons.edit_outlined,
                size: 24.sp,
                color: const Color(0xFFB0B0B0),
              ),
            ),
            Container(width: 1, height: 24.h, color: const Color(0xFFE0E0E0)),
            12.w.width,
            SocialIcon(type: iconType, size: 28.w),
            24.w.width,
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.customText20(
                  color: const Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                )
              ),
            ),
            ResponsiveSwitch(
              value: isEnabled,
              onChanged: onChanged,
              width: 40.w,
              height: 22.h,
              thumbSize: 18.w,
            ),
            12.w.width,
          ],
        ),
      ),
    );
  }
}
