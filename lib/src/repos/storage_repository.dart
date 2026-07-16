import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  StorageRepository(this._storage);

  final FirebaseStorage _storage;

  Future<String> uploadAvatar({required String uid, required File file}) async {
    final ref = _storage.ref('avatars/$uid');
    await ref.putFile(file, SettableMetadata(contentType: 'image/jpeg'));
    return ref.getDownloadURL();
  }
}
