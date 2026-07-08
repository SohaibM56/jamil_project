import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../dashboard/presentation/dashboard_controller.dart';
import '../../dashboard/presentation/widgets/dashboard_icons.dart';
import '../../dashboard/presentation/widgets/dashboard_page_scaffold.dart';
import '../../dashboard/presentation/widgets/responsive_switch.dart';
import 'widgets/edit_card_dialog.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();

    return DashboardPageScaffold(
      title: 'My Card',
      subtitle: 'Tap, Connect, Share.',
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        padding: EdgeInsets.fromLTRB(42.w, 0, 42.w, 28.h),
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 198.h,
                  padding: EdgeInsets.fromLTRB(30.w, 45.h, 20.w, 20.h),
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
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          dashboardController.cardTitle.value,
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          dashboardController.cardPhone.value,
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 15.sp,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          dashboardController.cardEmail.value,
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 15.sp,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                                  dashboardController.profileImageUrl.value),
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
                      SizedBox(height: 8.h),
                      const _SmallRoundIcon(icon: Icons.visibility_outlined),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 42.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _DividerLine(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Text(
                    'Your Links',
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 18.sp,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ),
                const _DividerLine(),
              ],
            ),
            SizedBox(height: 22.h),
            Obx(
              () => _ProfileLinkRow(
                label: 'Whatsapp',
                iconType: SocialIconType.whatsapp,
                isEnabled:
                    dashboardController.profileLinks['Whatsapp'] ?? false,
                onChanged: (value) =>
                    dashboardController.toggleProfileLink('Whatsapp', value),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => _ProfileLinkRow(
                label: 'Instagram',
                iconType: SocialIconType.instagram,
                isEnabled:
                    dashboardController.profileLinks['Instagram'] ?? false,
                onChanged: (value) =>
                    dashboardController.toggleProfileLink('Instagram', value),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => _ProfileLinkRow(
                label: 'TikTok',
                iconType: SocialIconType.tiktok,
                isEnabled:
                    dashboardController.profileLinks['TikTok'] ?? false,
                onChanged: (value) =>
                    dashboardController.toggleProfileLink('TikTok', value),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => _ProfileLinkRow(
                label: 'Facebook',
                iconType: SocialIconType.facebook,
                isEnabled:
                    dashboardController.profileLinks['Facebook'] ?? false,
                onChanged: (value) =>
                    dashboardController.toggleProfileLink('Facebook', value),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => _ProfileLinkRow(
                label: 'LinkedIn',
                iconType: SocialIconType.linkedin,
                isEnabled:
                    dashboardController.profileLinks['LinkedIn'] ?? false,
                onChanged: (value) =>
                    dashboardController.toggleProfileLink('LinkedIn', value),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => _ProfileLinkRow(
                label: 'Snapchat',
                iconType: SocialIconType.snapchat,
                isEnabled:
                    dashboardController.profileLinks['Snapchat'] ?? false,
                onChanged: (value) =>
                    dashboardController.toggleProfileLink('Snapchat', value),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => _ProfileLinkRow(
                label: 'Telegram',
                iconType: SocialIconType.telegram,
                isEnabled:
                    dashboardController.profileLinks['Telegram'] ?? false,
                onChanged: (value) =>
                    dashboardController.toggleProfileLink('Telegram', value),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => _ProfileLinkRow(
                label: 'X (Twitter)',
                iconType: SocialIconType.x,
                isEnabled:
                    dashboardController.profileLinks['X (Twitter)'] ?? false,
                onChanged: (value) =>
                    dashboardController.toggleProfileLink('X (Twitter)', value),
              ),
            ),
            SizedBox(height: 20.h),
            Obx(
              () => _ProfileLinkRow(
                label: 'YouTube',
                iconType: SocialIconType.youtube,
                isEnabled:
                    dashboardController.profileLinks['YouTube'] ?? false,
                onChanged: (value) =>
                    dashboardController.toggleProfileLink('YouTube', value),
              ),
            ),
          ],
        ),
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
        radius: 12,
        backgroundColor: Colors.black.withValues(alpha: 0.62),
        child: Icon(icon, size: 14.sp, color: Colors.white),
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
    return Container(
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
              size: 16.sp,
              color: const Color(0xFFB0B0B0),
            ),
          ),
          Container(
            width: 1,
            height: 24.h,
            color: const Color(0xFFE0E0E0),
          ),
          SizedBox(width: 12.w),
          SocialIcon(type: iconType, size: 28.w),
          SizedBox(width: 24.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 16.sp,
                color: const Color(0xFF666666),
              ),
            ),
          ),
          ResponsiveSwitch(
            value: isEnabled,
            onChanged: onChanged,
            width: 40.w,
            height: 22.h,
            thumbSize: 18.w,
          ),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }
}
