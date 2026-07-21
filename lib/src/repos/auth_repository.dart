import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RequiresRecentLoginException implements Exception {
  const RequiresRecentLoginException();

  @override
  String toString() => 'Please log out and log back in, then try again.';
}

class AuthRepository {
  AuthRepository(this._auth, this._firestore);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      throw Exception(_messageFor(error));
    }
  }

  Future<void> signup({required String email, required String password, required String name, required String phone,}) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = credential.user!.uid;
      final cardRef = _firestore.collection('cards').doc();

      final batch = _firestore.batch();
      batch.set(_firestore.collection('users').doc(uid), {
        'email': email,
        'phone': phone,
        'name': name,
        'cardId': cardRef.id,
        'isBlocked': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      batch.set(cardRef, {
        'ownerUid': uid,
        'name': name,
        'title': '',
        'phone': phone,
        'email': email,
        'profileImageUrl': '',
        'isBlocked': false,
        'links': <String, dynamic>{},
        'updatedAt': FieldValue.serverTimestamp(),
      });
      await batch.commit();
    } on FirebaseAuthException catch (error) {
      throw Exception(_messageFor(error));
    }
  }

  Future<void> logout() => _auth.signOut();

  Future<void> reauthenticate(String password) async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) {
      throw Exception('No user found to re-authenticate.');
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'requires-recent-login') {
        throw const RequiresRecentLoginException();
      }
      throw Exception(_messageFor(error));
    }
  }

  Future<void> deleteAccount(String password) async {
    final user = _auth.currentUser;
    if (user == null) return;

    // 1. Re-authenticate first to ensure session is valid
    await reauthenticate(password);

    try {
      // 2. Fetch data needed for deletion
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final cardId = userDoc.data()?['cardId'] as String?;

      // 3. Perform Firestore deletions
      final batch = _firestore.batch();
      batch.delete(_firestore.collection('users').doc(user.uid));
      if (cardId != null) {
        batch.delete(_firestore.collection('cards').doc(cardId));
      }
      await batch.commit();

      // 4. Finally delete the Auth user
      await user.delete();
    } on FirebaseAuthException catch (error) {
      if (error.code == 'requires-recent-login') {
        throw const RequiresRecentLoginException();
      }
      throw Exception(_messageFor(error));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (error) {
      throw Exception(_messageFor(error));
    }
  }

  bool isLoggedIn() => _auth.currentUser != null;

  String? get currentUid => _auth.currentUser?.uid;

  Stream<bool> watchBlocked(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) => snapshot.data()?['isBlocked'] == true);
  }

  String _messageFor(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'That email address looks invalid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found for that email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'network-request-failed':
        return 'Network error — check your connection and try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'requires-recent-login':
        return 'Please log out and log back in, then try again.';
      default:
        return error.message ?? 'Something went wrong. Please try again.';
    }
  }
}
