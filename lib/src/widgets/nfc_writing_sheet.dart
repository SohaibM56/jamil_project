import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamil_project/src/config/app_colors.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';

Future<void> showNfcWritingSheet({required BuildContext context, required Future<void> operation, required VoidCallback onCancel,}) async {
  var isOpen = true;
  var operationDone = false;

  unawaited(
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      builder: (_) => const _NfcWritingSheet(),
    ).whenComplete(() {
      isOpen = false;
      if (!operationDone) onCancel();
    }),
  );

  await operation;
  operationDone = true;

  if (isOpen && context.mounted) Navigator.of(context).pop();
}

class _NfcWritingSheet extends StatelessWidget {
  const _NfcWritingSheet();

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
            SizedBox(
              width: 56.w,
              height: 56.w,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.primaryTeal,
                  ),
                  Icon(Icons.nfc_rounded, size: 26.sp, color: Colors.black),
                ],
              ),
            ),
            24.h.height,
            Text(
              'Hold your device near the NFC card',
              textAlign: TextAlign.center,
              style: AppTextStyles.customText22(
                fontFamily: AppTextStyles.clashDisplay,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            10.h.height,
            Text(
              'Keep it in place until the write finishes.',
              textAlign: TextAlign.center,
              style: AppTextStyles.customText16(
                fontFamily: AppTextStyles.clashDisplay,
                color: AppColors.mutedText,
              ),
            ),
            30.h.height,
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.infinity,
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(13.r),
                ),
                child: Text(
                  'Cancel',
                  style: AppTextStyles.customText22(
                    fontFamily: AppTextStyles.clashDisplay,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
