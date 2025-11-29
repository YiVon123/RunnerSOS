import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:runner_sos/data/services/user_services.dart';
import '../services/profile_services.dart';
import '../../models/runner_profile_model.dart';
import '../../models/user_model.dart';
import '../../utils/validators.dart';

class ProfileRepository {
  final ProfileService _profileService = ProfileService();
  final UserService _userService = UserService();

  // Get complete user data
  Future<Map<String, dynamic>> getUserData(String uid) async {
    final userDoc = await _userService.getUserDocument(uid);
    final profileDoc = await _profileService.getRunnerProfile(uid);

    if (!userDoc.exists) {
      throw Exception("user_not_found");
    }

    final userData = UserModel.fromMap(
      uid,
      userDoc.data() as Map<String, dynamic>,
    );

    RunnerProfileModel? profileData;
    if (profileDoc.exists) {
      profileData = RunnerProfileModel.fromMap(
        uid,
        profileDoc.data() as Map<String, dynamic>,
      );
    }

    return {'user': userData, 'profile': profileData};
  }

  Future<RunnerProfileModel> updateRunnerProfile({
    required String uid,
    String? name,
    String? phone,
    String? gender,
    DateTime? dob,
  }) async {
    final updates = <String, dynamic>{};

    if (name != null && Validators.isNameValid(name)) {
      updates['name'] = name.trim();
    }
    if (phone != null) {
      if (phone.trim().isEmpty) {
        updates['phone'] = null;
      } else if (Validators.isPhoneValid(phone)) {
        updates['phone'] = phone.trim();
      } else {
        throw Exception("invalid_phone");
      }
    }
    if (gender != null) {
      updates['gender'] = gender;
    }
    if (dob != null) {
      updates['dob'] = Timestamp.fromDate(dob);
    }

    if (updates.isEmpty) {
      throw Exception("no_updates");
    }

    updates['updated_at'] = FieldValue.serverTimestamp();
    await _profileService.updateRunnerProfile(uid, updates);

    // Fetch and return updated profile
    final profileDoc = await _profileService.getRunnerProfile(uid);
    return RunnerProfileModel.fromMap(
      uid,
      profileDoc.data() as Map<String, dynamic>,
    );
  }

  // Update user status (admin feature)
  Future<void> updateUserStatus(String uid, String status) async {
    if (!['active', 'inactive', 'suspended'].contains(status)) {
      throw Exception("invalid_status");
    }
    await _userService.updateUserStatus(uid, status);
  }

  // Sync email verification status
  Future<void> syncEmailVerificationStatus(String uid, bool verified) async {
    await _userService.updateEmailVerifiedStatus(uid, verified);
  }

  Future<String?> getUserRole(String uid) async {
    return await _userService.getUserRole(uid);
  }

  Future<String?> getUserStatus(String uid) async {
    return await _userService.getUserStatus(uid);
  }
}
