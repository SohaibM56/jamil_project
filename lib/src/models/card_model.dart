import 'package:cloud_firestore/cloud_firestore.dart';

class CardLink {
  const CardLink({required this.url, required this.visibleOnCard, this.addedAt});

  final String url;
  final bool visibleOnCard;
  final Timestamp? addedAt;

  factory CardLink.fromMap(Map<String, dynamic> map) {
    return CardLink(
      url: map['url'] as String? ?? '',
      visibleOnCard: map['visibleOnCard'] as bool? ?? false,
      addedAt: map['addedAt'] as Timestamp?,
    );
  }
}

class CardModel {
  const CardModel({
    required this.ownerUid,
    required this.name,
    required this.title,
    required this.phone,
    required this.email,
    required this.profileImageUrl,
    required this.links,
  });

  final String ownerUid;
  final String name;
  final String title;
  final String phone;
  final String email;
  final String profileImageUrl;
  final Map<String, CardLink> links;

  factory CardModel.fromMap(Map<String, dynamic> map) {
    final rawLinks = map['links'] as Map<String, dynamic>? ?? {};

    return CardModel(
      ownerUid: map['ownerUid'] as String? ?? '',
      name: map['name'] as String? ?? '',
      title: map['title'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      email: map['email'] as String? ?? '',
      profileImageUrl: map['profileImageUrl'] as String? ?? '',
      links: rawLinks.map(
        (platform, value) =>
            MapEntry(platform, CardLink.fromMap(value as Map<String, dynamic>)),
      ),
    );
  }
}
