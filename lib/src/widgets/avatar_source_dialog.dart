import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';

Future<ImageSource?> showAvatarSourceDialog({required BuildContext context}) {
  return showModalBottomSheet<ImageSource>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withValues(alpha: 0.55),
    builder: (context) => const _AvatarSourceDialog(),
  );
}

class _AvatarSourceDialog extends StatelessWidget {
  const _AvatarSourceDialog();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(48.w, 10.h, 48.w, 28.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(34.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: const Color(0xFF707070),
                borderRadius: BorderRadius.circular(99.r),
              ),
            ),
            30.h.height,
            Text(
              'Update profile photo',
              style: AppTextStyles.customText26(
                fontFamily: AppTextStyles.clashDisplay,
                height: 1,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            30.h.height,
            _SourceOption(
              label: 'Take a photo',
              onTap: () => Navigator.of(context).pop(ImageSource.camera),
            ),
            16.h.height,
            _SourceOption(
              label: 'Choose from gallery',
              onTap: () => Navigator.of(context).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
}

class _SourceOption extends StatelessWidget {
  const _SourceOption({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(13.r),
        ),
        child: Text(
          label,
          style: AppTextStyles.customText22(
            fontFamily: AppTextStyles.clashDisplay,
            color: AppColors.primaryTeal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
