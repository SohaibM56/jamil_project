import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jamil_project/src/config/app_urls.dart';
import 'package:jamil_project/src/config/padding_extensions.dart';
import 'package:jamil_project/src/mvvm/viewModels/dashboard_controller/dashboard_controller.dart';
import 'package:jamil_project/src/utils/nfc_writer.dart';
import 'package:jamil_project/src/widgets/app_snackbar.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';
import 'package:jamil_project/src/widgets/dashboard_loading_state.dart';
import 'package:jamil_project/src/widgets/nfc_writing_sheet.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

enum _QrMenuAction { copy, share }

class QRView extends StatefulWidget {
  const QRView({super.key});

  @override
  State<QRView> createState() => _QRViewState();
}

class _QRViewState extends State<QRView> {
  bool _isWritingToNfc = false;

  Future<void> _handleMenuAction(_QrMenuAction action, String url) async {
    switch (action) {
      case _QrMenuAction.copy:
        await Clipboard.setData(ClipboardData(text: url));
        AppSnackbar.success('Copied', 'Link copied to clipboard.');
      case _QrMenuAction.share:
        final box = context.findRenderObject() as RenderBox?;
        await SharePlus.instance.share(
          ShareParams(
            text: url,
            sharePositionOrigin: box == null
                ? null
                : box.localToGlobal(Offset.zero) & box.size,
          ),
        );
    }
  }

  Future<void> _writeToNfc(String url) async {
    if (_isWritingToNfc) return;

    setState(() => _isWritingToNfc = true);

    final writeOperation = NfcWriter.writeUrl(
      url,
      onSuccess: (message) => AppSnackbar.success('Success', message),
      onError: (message) => AppSnackbar.error('Error', message),
    );

    await showNfcWritingSheet(
      context: context,
      operation: writeOperation,
      onCancel: NfcWriter.cancelSession,
    );

    if (mounted) setState(() => _isWritingToNfc = false);
  }

  @override
  void dispose() {
    if (_isWritingToNfc) NfcWriter.cancelSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.find<DashboardController>();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          60.h.height,
          Text(
            "Personal QR",
            style: AppTextStyles.customText34(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontFamily: AppTextStyles.clashDisplay,
            ),
          ),
          2.h.height,
          Text(
            "Share your smart business card",
            style: AppTextStyles.customText(
              fontWeight: FontWeight.w500,
              fontSize: 25.sp,
              color: Colors.black,
              fontFamily: AppTextStyles.clashDisplay,
            ),
          ),
          const Spacer(),
          Obx(() {
            final cardId = dashboardController.card.value != null
                ? dashboardController.cardId
                : null;

            if (cardId == null) {
              return DashboardLoadingState(
                hasError: dashboardController.hasLoadError.value,
                onRetry: dashboardController.retryLoadCard,
              );
            }

            final displayUrl = AppUrls.cardDisplayUrl(cardId);
            final scannableUrl = AppUrls.cardUrl(cardId);

            return Column(
              children: [
                Center(
                  child: Container(
                    width: 200.w,
                    height: 200.w,
                    padding: EdgeInsets.all(16.sp),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 3.w),
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    child: PrettyQrView.data(data: scannableUrl),
                  ),
                ),
                50.h.height,
                Center(
                  child: Material(
                    elevation: 1.sp,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(5.w, 7.h, 5.w, 7.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F7F6),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              displayUrl,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.customText(
                                height: 1.3,
                                fontSize: 16.sp,
                                color: const Color(0xFF777777),
                                fontWeight: FontWeight.w600,
                                fontFamily: AppTextStyles.clashDisplay,
                              ),
                            ),
                          ),
                          PopupMenuButton<_QrMenuAction>(
                            icon: Icon(
                              Icons.more_vert_rounded,
                              color: const Color(0xFFB0B0B0),
                              size: 28.sp,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            onSelected: (action) =>
                                _handleMenuAction(action, scannableUrl),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: _QrMenuAction.copy,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.copy_rounded,
                                      color: Colors.black54,
                                    ),
                                    10.w.width,
                                    Text(
                                      'Copy link to clipboard',
                                      style: AppTextStyles.customText16(
                                        color: Colors.black,
                                        fontFamily: AppTextStyles.clashDisplay,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: _QrMenuAction.share,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.share_rounded,
                                      color: Colors.black54,
                                    ),
                                    10.w.width,
                                    Text(
                                      'Share link',
                                      style: AppTextStyles.customText16(
                                        color: Colors.black,
                                        fontFamily: AppTextStyles.clashDisplay,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ).paddingHorizontal(20.w),
                ),
                20.h.height,
                Center(
                  child: GestureDetector(
                    onTap: _isWritingToNfc
                        ? null
                        : () => _writeToNfc(scannableUrl),
                    child: Opacity(
                      opacity: _isWritingToNfc ? 0.5 : 1,
                      child: Container(
                        height: 52.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.nfc_rounded,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            10.w.width,
                            Text(
                              'Write link to NFC card',
                              style: AppTextStyles.customText16(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: AppTextStyles.clashDisplay,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          const Spacer(),
        ],
      ).paddingHorizontal(30.w),
    );
  }
}
