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
            width: 260.w,
            height: 260.w,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2.w),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: PrettyQrView.data(data: _qrData),
          ),
          SizedBox(height: 50.h),
          Container(
            width: 320.w,
            padding: EdgeInsets.fromLTRB(20.w, 10.h, 12.w, 10.h),
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
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 13.sp,
                      height: 1.3,
                      color: const Color(0xFF777777),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.more_vert_rounded,
                  color: const Color(0xFFB0B0B0),
                  size: 20.sp,
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
