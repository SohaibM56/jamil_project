import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/config/app_urls.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';
import 'package:jamil_project/src/mvvm/viewModels/dashboard_controller/dashboard_controller.dart';
import 'package:jamil_project/src/widgets/add_link_dialog.dart';
import 'package:jamil_project/src/widgets/app_snackbar.dart';
import 'package:jamil_project/src/widgets/avatar_source_dialog.dart';
import 'package:jamil_project/src/widgets/dashboard_icons.dart';
import 'package:jamil_project/src/widgets/dashboard_loading_state.dart';
import 'package:jamil_project/src/widgets/edit_card_dialog.dart';
import 'package:jamil_project/src/widgets/responsive_switch.dart';
import 'package:url_launcher/url_launcher.dart';

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
      child: Obx(() {
        if (dashboardController.card.value == null) {
          return DashboardLoadingState(
            hasError: dashboardController.hasLoadError.value,
            onRetry: dashboardController.retryLoadCard,
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              45.h.height,
              Text(
                "My Card",
                style: AppTextStyles.customText34(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  fontFamily: AppTextStyles.clashDisplay,
                ),
              ),
              2.h.height,
              Text(
                "Tap, Connect, Share",
                style: AppTextStyles.customText28(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: AppTextStyles.clashDisplay,
                ),
              ),
              30.h.height,
              Obx(() {
                final card = dashboardController.card.value;
                final imageUrl = card?.profileImageUrl ?? '';

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180.h,
                      padding: EdgeInsets.fromLTRB(30.w, 40.h, 20.w, 20.h),
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
                        children: [
                          Text(
                            card?.name ?? '',
                            style: AppTextStyles.customText30(
                              fontWeight: FontWeight.w600,
                              fontFamily: AppTextStyles.clashDisplay,
                            ),
                          ),
                          Text(
                            card?.title ?? '',
                            style: AppTextStyles.customText24(
                              fontWeight: FontWeight.w600,
                              fontFamily: AppTextStyles.clashDisplay,
                            ),
                          ),
                          2.h.height,
                          Text(
                            card?.phone ?? '',
                            style: AppTextStyles.customText20(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: AppTextStyles.clashDisplay,
                            ),
                          ),
                          Text(
                            card?.email ?? '',
                            style: AppTextStyles.customText18(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: AppTextStyles.clashDisplay,
                            ),
                          ),
                        ],
                      ),
                    ).paddingHorizontal(5.w),
                    Positioned(
                      top: -10.h,
                      right: -10.w,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 110.w,
                            height: 110.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 2.w,
                              ),
                              image: imageUrl.isEmpty
                                  ? null
                                  : DecorationImage(
                                      image: NetworkImage(imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            child: dashboardController.isUpdatingPhoto.value
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
                                          size: 40.sp,
                                        )
                                      : null),
                          ),
                          Positioned(
                            top: 2.h,
                            right: 2.w,
                            child: GestureDetector(
                              onTap: () =>
                                  _updatePhoto(context, dashboardController),
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
                              initialName: card?.name ?? '',
                              initialTitle: card?.title ?? '',
                              initialPhone: card?.phone ?? '',
                              onUpdate: dashboardController.updateAccountInfo,
                            ),
                          ),
                          8.h.height,
                          _SmallRoundIcon(
                            icon: Icons.visibility_outlined,
                            onTap: () => _openPublicCard(dashboardController),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
              42.h.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _DividerLine(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    child: Text(
                      'Your Links',
                      style: AppTextStyles.customText22(
                        color: Colors.black.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                  const _DividerLine(),
                ],
              ),
              22.h.height,
              Obx(() {
                final links = dashboardController.card.value?.links ?? {};
                final configuredLinks = _links
                    .where((link) => links.containsKey(link.iconType.name))
                    .toList();

                if (configuredLinks.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Text(
                      'No links added yet. Add one from the Links tab.',
                      style: AppTextStyles.customText18(
                        color: Colors.black.withValues(alpha: 0.5),
                        fontFamily: AppTextStyles.clashDisplay,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: configuredLinks.length,
                  itemBuilder: (context, index) {
                    final link = configuredLinks[index];
                    final currentUrl = links[link.iconType.name]!.url;
                    final isEnabled = links[link.iconType.name]!.visibleOnCard;
                    final isLoading = dashboardController.pendingLinkPlatforms
                        .contains(link.iconType.name);
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 20.h,
                        left: 20.w,
                        right: 20.w,
                      ),
                      child: _ProfileLinkRow(
                        label: link.label,
                        iconType: link.iconType,
                        isEnabled: isEnabled,
                        isLoading: isLoading,
                        onEdit: isLoading
                            ? null
                            : () => showAddLinkDialog(
                                context: context,
                                iconType: link.iconType,
                                initialUrl: currentUrl,
                                onAddLink: (url) => dashboardController
                                    .upsertLink(link.iconType.name, url),
                              ),
                        onChanged: isLoading
                            ? null
                            : (value) =>
                                  dashboardController.toggleLinkVisibility(
                                    link.iconType.name,
                                    value,
                                  ),
                      ),
                    );
                  },
                );
              }),
            ],
          ).paddingHorizontal(30.w),
        );
      }),
    );
  }

  Future<void> _openPublicCard(DashboardController dashboardController) async {
    final cardId = dashboardController.cardId;
    if (cardId == null) return;

    final launched = await launchUrl(
      Uri.parse(AppUrls.cardUrl(cardId)),
      mode: LaunchMode.externalApplication,
    );
    if (!launched) {
      AppSnackbar.error('Error', 'Could not open the card link.');
    }
  }

  Future<void> _updatePhoto(
    BuildContext context,
    DashboardController dashboardController,
  ) async {
    final source = await showAvatarSourceDialog(context: context);
    if (source == null) return;

    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 80,
    );
    if (picked == null) return;

    final cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      compressQuality: 85,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Photo',
          toolbarColor: AppColors.primaryTeal,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(title: 'Crop Photo', aspectRatioLockEnabled: true),
      ],
    );
    if (cropped == null) return;

    await dashboardController.updatePhoto(File(cropped.path));
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
    required this.isLoading,
    required this.onEdit,
    required this.onChanged,
  });

  final String label;
  final SocialIconType iconType;
  final bool isEnabled;
  final bool isLoading;
  final VoidCallback? onEdit;
  final ValueChanged<bool>? onChanged;

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
            GestureDetector(
              onTap: onEdit,
              child: Padding(
                padding: EdgeInsets.only(left: 12.w, right: 8.w),
                child: Icon(
                  Icons.edit_outlined,
                  size: 24.sp,
                  color: const Color(0xFFB0B0B0),
                ),
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
                  fontFamily: AppTextStyles.clashDisplay,
                ),
              ),
            ),
            isLoading
                ? SizedBox(
                    width: 40.w,
                    height: 22.h,
                    child: const Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryTeal,
                        ),
                      ),
                    ),
                  )
                : ResponsiveSwitch(
                    value: isEnabled,
                    onChanged: onChanged!,
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
