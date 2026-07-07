import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum SocialIconType { whatsapp, instagram, tiktok }

enum SettingsIconType { darkMode, privacy, terms, logout }

class SocialIcon extends StatelessWidget {
  const SocialIcon({super.key, required this.type, this.size});

  final SocialIconType type;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? 30.w;

    return SizedBox.square(
      dimension: iconSize,
      child: CustomPaint(painter: _SocialIconPainter(type)),
    );
  }
}

class SettingsGlyph extends StatelessWidget {
  const SettingsGlyph({super.key, required this.type, this.size});

  final SettingsIconType type;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? 24.w;

    return SizedBox.square(
      dimension: iconSize,
      child: CustomPaint(painter: _SettingsIconPainter(type)),
    );
  }
}

class _SocialIconPainter extends CustomPainter {
  const _SocialIconPainter(this.type);

  final SocialIconType type;

  @override
  void paint(Canvas canvas, Size size) {
    switch (type) {
      case SocialIconType.whatsapp:
        _paintWhatsapp(canvas, size);
      case SocialIconType.instagram:
        _paintInstagram(canvas, size);
      case SocialIconType.tiktok:
        _paintTikTok(canvas, size);
    }
  }

  void _paintWhatsapp(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = const Color(0xFF32C768)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final center = Offset(size.width * 0.5, size.height * 0.47);
    canvas.drawCircle(center, size.width * 0.38, stroke);

    final tail = Path()
      ..moveTo(size.width * 0.28, size.height * 0.76)
      ..lineTo(size.width * 0.19, size.height * 0.89)
      ..lineTo(size.width * 0.35, size.height * 0.82);
    canvas.drawPath(tail, stroke);

    final phone = Path()
      ..moveTo(size.width * 0.37, size.height * 0.36)
      ..cubicTo(
        size.width * 0.35,
        size.height * 0.48,
        size.width * 0.49,
        size.height * 0.63,
        size.width * 0.62,
        size.height * 0.64,
      )
      ..lineTo(size.width * 0.68, size.height * 0.58);
    canvas.drawPath(phone, stroke);
  }

  void _paintInstagram(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = Radius.circular(size.width * 0.25);
    final gradient = const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color(0xFFFFD600),
        Color(0xFFFF7A00),
        Color(0xFFE91E63),
        Color(0xFF9C27B0),
      ],
    );

    final bgPaint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRRect(RRect.fromRectAndRadius(rect.deflate(1), radius), bgPaint);

    final white = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09
      ..strokeCap = StrokeCap.round;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * 0.22,
          size.height * 0.22,
          size.width * 0.56,
          size.height * 0.56,
        ),
        Radius.circular(size.width * 0.16),
      ),
      white,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.13,
      white,
    );
    canvas.drawCircle(
      Offset(size.width * 0.66, size.height * 0.34),
      size.width * 0.035,
      Paint()..color = Colors.white,
    );
  }

  void _paintTikTok(Canvas canvas, Size size) {
    final black = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.08
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.42,
      black,
    );

    final note = Path()
      ..moveTo(size.width * 0.56, size.height * 0.25)
      ..lineTo(size.width * 0.56, size.height * 0.61)
      ..cubicTo(
        size.width * 0.54,
        size.height * 0.76,
        size.width * 0.31,
        size.height * 0.73,
        size.width * 0.35,
        size.height * 0.58,
      )
      ..cubicTo(
        size.width * 0.38,
        size.height * 0.48,
        size.width * 0.51,
        size.height * 0.48,
        size.width * 0.56,
        size.height * 0.55,
      )
      ..moveTo(size.width * 0.56, size.height * 0.25)
      ..cubicTo(
        size.width * 0.61,
        size.height * 0.36,
        size.width * 0.68,
        size.height * 0.41,
        size.width * 0.76,
        size.height * 0.42,
      );
    canvas.drawPath(note, black);
  }

  @override
  bool shouldRepaint(covariant _SocialIconPainter oldDelegate) {
    return oldDelegate.type != type;
  }
}

class _SettingsIconPainter extends CustomPainter {
  const _SettingsIconPainter(this.type);

  final SettingsIconType type;

  @override
  void paint(Canvas canvas, Size size) {
    switch (type) {
      case SettingsIconType.darkMode:
        _paintDarkMode(canvas, size);
      case SettingsIconType.privacy:
        _paintPrivacy(canvas, size);
      case SettingsIconType.terms:
        _paintTerms(canvas, size);
      case SettingsIconType.logout:
        _paintLogout(canvas, size);
    }
  }

  Paint _stroke([Color color = const Color(0xFF555555)]) {
    return Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.45
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
  }

  void _paintDarkMode(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final radius = size.width * 0.38;
    canvas.drawCircle(center, radius, _stroke(Colors.black)..strokeWidth = 2);

    final fill = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 1),
      -1.57,
      3.14,
      true,
      fill,
    );
  }

  void _paintPrivacy(Canvas canvas, Size size) {
    final stroke = _stroke();
    final shield = Path()
      ..moveTo(size.width * 0.5, size.height * 0.12)
      ..lineTo(size.width * 0.78, size.height * 0.24)
      ..lineTo(size.width * 0.73, size.height * 0.66)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.9,
        size.width * 0.27,
        size.height * 0.66,
      )
      ..lineTo(size.width * 0.22, size.height * 0.24)
      ..close();
    canvas.drawPath(shield, stroke);

    final lock = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.38,
        size.height * 0.48,
        size.width * 0.24,
        size.height * 0.2,
      ),
      Radius.circular(size.width * 0.03),
    );
    canvas.drawRRect(lock, stroke);
    canvas.drawArc(
      Rect.fromLTWH(
        size.width * 0.39,
        size.height * 0.35,
        size.width * 0.22,
        size.height * 0.22,
      ),
      3.14,
      3.14,
      false,
      stroke,
    );
  }

  void _paintTerms(Canvas canvas, Size size) {
    final stroke = _stroke();
    final doc = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.18,
        size.height * 0.12,
        size.width * 0.52,
        size.height * 0.68,
      ),
      Radius.circular(size.width * 0.04),
    );
    canvas.drawRRect(doc, stroke);

    for (final y in [0.3, 0.43, 0.56]) {
      canvas.drawLine(
        Offset(size.width * 0.29, size.height * y),
        Offset(size.width * 0.59, size.height * y),
        stroke,
      );
    }

    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.72),
      size.width * 0.16,
      stroke,
    );
    canvas.drawLine(
      Offset(size.width * 0.72, size.height * 0.72),
      Offset(size.width * 0.72, size.height * 0.62),
      stroke,
    );
    canvas.drawLine(
      Offset(size.width * 0.72, size.height * 0.72),
      Offset(size.width * 0.8, size.height * 0.76),
      stroke,
    );
  }

  void _paintLogout(Canvas canvas, Size size) {
    final stroke = _stroke();
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.22, size.height * 0.18)
        ..lineTo(size.width * 0.62, size.height * 0.18)
        ..lineTo(size.width * 0.62, size.height * 0.32)
        ..moveTo(size.width * 0.62, size.height * 0.68)
        ..lineTo(size.width * 0.62, size.height * 0.82)
        ..lineTo(size.width * 0.22, size.height * 0.82)
        ..lineTo(size.width * 0.22, size.height * 0.18),
      stroke,
    );
    canvas.drawLine(
      Offset(size.width * 0.42, size.height * 0.5),
      Offset(size.width * 0.82, size.height * 0.5),
      stroke,
    );
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.68, size.height * 0.34)
        ..lineTo(size.width * 0.84, size.height * 0.5)
        ..lineTo(size.width * 0.68, size.height * 0.66),
      stroke,
    );
  }

  @override
  bool shouldRepaint(covariant _SettingsIconPainter oldDelegate) {
    return oldDelegate.type != type;
  }
}
