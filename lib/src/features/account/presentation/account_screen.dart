import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        padding: EdgeInsets.fromLTRB(42.w, 0, 42.w, 28.h),
        child: Column(
          children: [
            SizedBox(height: 4.h),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 198.h,
                  padding: EdgeInsets.fromLTRB(30.w, 55.h, 20.w, 20.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryTeal.withValues(alpha: 0.45),
                    border: Border.all(color: Colors.black, width: 2.3.w),
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.13),
                        blurRadius: 18.r,
                        offset: Offset(0, 13.h),
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
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          dashboardController.cardTitle.value,
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          dashboardController.cardPhone.value,
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          dashboardController.cardEmail.value,
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -30.h,
                  right: -16.w,
                  child: Container(
                    width: 85.w,
                    height: 85.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 3.w),
                    ),
                    child: Icon(
                      Icons.person_outline_rounded,
                      size: 66.sp,
                      color: const Color(0xFF8DC7BB),
                    ),
                  ),
                ),
                Positioned(
                  right: 13.w,
                  bottom: 15.h,
                  child: const _SmallRoundIcon(icon: Icons.visibility),
                ),
                Positioned(
                  right: 13.w,
                  bottom: 45.h,
                  child: _SmallRoundIcon(
                    icon: Icons.edit,
                    onTap: () => showEditCardDialog(
                      context: context,
                      onUpdate: dashboardController.updateCard,
                    ),
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
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(9.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16.r,
            offset: Offset(0, 9.h),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 36.w),
          SocialIcon(type: iconType, size: 30.w),
          SizedBox(width: 58.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 18.sp,
                color: const Color(0xFF666666),
              ),
            ),
          ),
          ResponsiveSwitch(value: isEnabled, onChanged: onChanged),
          SizedBox(width: 12.w),
        ],
      ),
    );
  }
}
