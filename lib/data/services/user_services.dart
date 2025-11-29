import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create user document
  Future<void> createUserDocument(
    String uid,
    Map<String, dynamic> userData,
  ) async {
    await _db.collection('users').doc(uid).set(userData);
  }

  // Get user document
  Future<DocumentSnapshot> getUserDocument(String uid) async {
    return await _db.collection('users').doc(uid).get();
  }

  // Update user document
  Future<void> updateUserDocument(
    String uid,
    Map<String, dynamic> updates,
  ) async {
    await _db.collection('users').doc(uid).update(updates);
  }

  // update user status
  Future<void> updateUserStatus(String uid, String status) async {
    await _db.collection('users').doc(uid).update({'status': status});
  }

  // update email verified status
  Future<void> updateEmailVerifiedStatus(String uid, bool isVerified) async {
    await _db.collection('users').doc(uid).update({
      'email_verified': isVerified,
    });
  }

  // get user role
  Future<String?> getUserRole(String uid) async {
    final doc = await getUserDocument(uid);
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    return data['role'];
  }

  // check if user exists
  Future<bool> isUserExists(String uid) async {
    final doc = await getUserDocument(uid);
    return doc.exists;
  }

  // get user status
  Future<String?> getUserStatus(String uid) async {
    final doc = await getUserDocument(uid);
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    return data['status'];
  }
}
