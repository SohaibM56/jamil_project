import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../dashboard/presentation/widgets/dashboard_page_scaffold.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  static const _qrData = 'my.jamilcards.com/#/vqrD7Ij4rWbzxGOAwNdmMcyrJO83';

  @override
  Widget build(BuildContext context) {
    return DashboardPageScaffold(
      title: 'Personal QR',
      subtitle: 'Share your smart business card',
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: 220.w,
            height: 220.w,
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 3.w),
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: PrettyQrView.data(data: _qrData),
          ),
          SizedBox(height: 34.h),
          Container(
            width: 312.w,
            padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              'my.jamilcards.com/#/vqrD7Ij4rWbzx\nGOAwNdmMcyrJO83',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 12.sp,
                height: 1.3,
                color: const Color(0xFF777777),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
