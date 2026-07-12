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
