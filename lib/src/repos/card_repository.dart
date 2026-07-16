import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jamil_project/src/models/card_model.dart';

class CardRepository {
  CardRepository(this._firestore);

  final FirebaseFirestore _firestore;

  Future<String> fetchCardId(String uid) async {
    final userDoc = await _firestore.collection('users').doc(uid).get();
    final cardId = userDoc.data()?['cardId'] as String?;
    if (cardId == null) {
      throw Exception('No card found for this account.');
    }
    return cardId;
  }

  Stream<CardModel> watchCard(String cardId) {
    return _firestore
        .collection('cards')
        .doc(cardId)
        .snapshots()
        .map((snapshot) => CardModel.fromMap(snapshot.data() ?? {}));
  }

  Future<void> updateTitle(String cardId, String title) {
    return _firestore.collection('cards').doc(cardId).update({
      'title': title,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateAccountInfo(String cardId, {required String name, required String title, required String phone,}) {
    return _firestore.collection('cards').doc(cardId).update({
      'name': name,
      'title': title,
      'phone': phone,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateProfileImage(String cardId, String url) {
    return _firestore.collection('cards').doc(cardId).update({
      'profileImageUrl': url,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> setLinkVisibility(String cardId, String platform, bool visible) {
    return _firestore.collection('cards').doc(cardId).update({
      'links.$platform.visibleOnCard': visible,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> upsertLink(String cardId, String platform, String url, {required bool isNew,}) {
    final update = <String, dynamic>{
      'links.$platform.url': url,
      'links.$platform.visibleOnCard': true,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (isNew) {
      update['links.$platform.addedAt'] = FieldValue.serverTimestamp();
    }
    return _firestore.collection('cards').doc(cardId).update(update);
  }

  Future<void> removeLink(String cardId, String platform) {
    return _firestore.collection('cards').doc(cardId).update({
      'links.$platform': FieldValue.delete(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
