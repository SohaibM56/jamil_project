import 'package:jamil_project/src/widgets/dashboard_icons.dart';

extension SocialLinkValidator on SocialIconType {
  List<String> get _allowedDomains {
    switch (this) {
      case SocialIconType.whatsapp:
      case SocialIconType.whatsappBusiness:
        return const ['wa.me', 'api.whatsapp.com', 'whatsapp.com'];
      case SocialIconType.instagram:
        return const ['instagram.com'];
      case SocialIconType.tiktok:
        return const ['tiktok.com'];
      case SocialIconType.facebook:
        return const ['facebook.com', 'fb.com', 'fb.watch'];
      case SocialIconType.linkedin:
        return const ['linkedin.com'];
      case SocialIconType.snapchat:
        return const ['snapchat.com'];
      case SocialIconType.telegram:
        return const ['t.me', 'telegram.me', 'telegram.org'];
      case SocialIconType.x:
        return const ['x.com', 'twitter.com'];
      case SocialIconType.youtube:
        return const ['youtube.com', 'youtu.be'];
    }
  }

  String get exampleDomain => _allowedDomains.first;

  bool isValidUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return false;

    final uri = Uri.tryParse(
      trimmed.contains('://') ? trimmed : 'https://$trimmed',
    );
    if (uri == null || uri.host.isEmpty) return false;

    final host = uri.host.toLowerCase().replaceFirst(RegExp(r'^www\.'), '');
    return _allowedDomains.any(
      (domain) => host == domain || host.endsWith('.$domain'),
    );
  }

  String normalizeUrl(String url) {
    final trimmed = url.trim();
    return trimmed.contains('://') ? trimmed : 'https://$trimmed';
  }
}
