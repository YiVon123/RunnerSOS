import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create runner profile
  Future<void> createRunnerProfile(
    String uid,
    Map<String, dynamic> profileData,
  ) async {
    await _db.collection('runner_profiles').doc(uid).set(profileData);
  }

  // Get runner profile
  Future<DocumentSnapshot> getRunnerProfile(String uid) async {
    return await _db.collection('runner_profiles').doc(uid).get();
  }

  // Update runner profile
  Future<void> updateRunnerProfile(
    String uid,
    Map<String, dynamic> updates,
  ) async {
    updates['updated_at'] = FieldValue.serverTimestamp();
    await _db.collection('runner_profiles').doc(uid).update(updates);
  }

  // Check if profile exists
  Future<bool> isProfileExists(String uid) async {
    final doc = await getRunnerProfile(uid);
    return doc.exists;
  }
}
