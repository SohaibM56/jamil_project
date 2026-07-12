import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamil_project/src/config/padding_extensions.dart';
import 'package:jamil_project/src/widgets/auth_text.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:jamil_project/src/config/sized_box_extension.dart';

class QRView extends StatelessWidget {
  const QRView({super.key});

  static const _qrData = 'my.jamilcards.com/#/vqrD7Ij4rWbzxGOAwNdmMcyrJO83';

  @override
  Widget build(BuildContext context) {
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
              child: PrettyQrView.data(data: _qrData),
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
                        'my.jamilcards.com/#/vqrD7Ij4rWbzx\nGOAwNdmMcyrJO83',
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
                    Icon(
                      Icons.more_vert_rounded,
                      color: const Color(0xFFB0B0B0),
                      size: 28.sp,
                    ),
                  ],
                ),
              ),
            ).paddingHorizontal(20.w),
          ),
          const Spacer(),
        ],
      ).paddingHorizontal(30.w),
    );
  }
}
