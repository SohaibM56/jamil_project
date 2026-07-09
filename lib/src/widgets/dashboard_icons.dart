import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jamil_project/src/config/app_assets.dart';

enum SocialIconType {
  whatsapp,
  instagram,
  tiktok,
  facebook,
  linkedin,
  snapchat,
  telegram,
  x,
  youtube,
  whatsappBusiness,
}

enum SettingsIconType { darkMode, privacy, terms, logout }

class SocialIcon extends StatelessWidget {
  const SocialIcon({super.key, required this.type, this.size});

  final SocialIconType type;
  final double? size;

  String get _assetPath {
    switch (type) {
      case SocialIconType.whatsapp:
        return AppAssets.whatsapp;
      case SocialIconType.instagram:
        return AppAssets.instagram;
      case SocialIconType.tiktok:
        return AppAssets.tiktok;
      case SocialIconType.facebook:
        return AppAssets.facebook;
      case SocialIconType.linkedin:
        return AppAssets.linkedin;
      case SocialIconType.snapchat:
        return AppAssets.snapchat;
      case SocialIconType.telegram:
        return AppAssets.telegram;
      case SocialIconType.x:
        return AppAssets.x;
      case SocialIconType.youtube:
        return AppAssets.youtube;
      case SocialIconType.whatsappBusiness:
        return AppAssets.whatsappBusiness;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      _assetPath,
      width: size ?? 30.w,
      height: size ?? 30.w,
      fit: BoxFit.contain,
    );
  }
}

class SettingsGlyph extends StatelessWidget {
  const SettingsGlyph({super.key, required this.type, this.size, this.color});

  final SettingsIconType type;
  final double? size;
  final Color? color;

  IconData get _iconData {
    switch (type) {
      case SettingsIconType.darkMode:
        return Icons.contrast_rounded;
      case SettingsIconType.privacy:
        return Icons.shield_outlined;
      case SettingsIconType.terms:
        return Icons.assignment_outlined;
      case SettingsIconType.logout:
        return Icons.exit_to_app_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(_iconData, size: size ?? 22.sp, color: color ?? Colors.black);
  }
}
