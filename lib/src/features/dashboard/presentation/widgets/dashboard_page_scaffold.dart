import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardPageScaffold extends StatelessWidget {
  const DashboardPageScaffold({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.headerHeight = 170,
  });

  final String title;
  final String? subtitle;
  final double headerHeight;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: headerHeight.h,
            width: double.infinity,
            child: CustomPaint(painter: _HeaderPatternPainter()),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(42.w, 32.h, 42.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: 30,
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      letterSpacing: -1.2,
                    ).copyWith(fontSize: 26.sp),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 24,
                        height: 1,
                        color: Colors.black,
                        letterSpacing: -0.8,
                      ).copyWith(fontSize: 20.sp),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Positioned.fill(top: headerHeight.h, child: child),
        ],
      ),
    );
  }
}

class _HeaderPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFBFE6DF).withValues(alpha: 0.72)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    for (double x = -80; x < size.width + 80; x += 92) {
      final path = Path()
        ..moveTo(x, 0)
        ..lineTo(x + 36, 58)
        ..lineTo(x + 12, 100)
        ..lineTo(x + 70, 100)
        ..lineTo(x + 108, 40)
        ..moveTo(x + 42, 0)
        ..lineTo(x + 88, 74)
        ..lineTo(x + 52, 132);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
