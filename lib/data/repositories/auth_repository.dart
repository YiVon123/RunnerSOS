// lib/data/repositories/auth_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../services/profile_services.dart';
import '../services/user_services.dart';
import '../../models/runner_profile_model.dart';
import '../../models/user_model.dart';
import '../../utils/app_utils.dart';

class AuthRepository {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();
  final ProfileService _profileService = ProfileService();

  // Persistent storage keys
  static const _keyFailedAttempts = 'failed_login_attempts';
  static const _keyLockUntil = 'lock_until_timestamp';

  // Get failed attempts from SharedPreferences
  Future<int> _getFailedAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyFailedAttempts) ?? 0;
  }

  // Set failed attempts
  Future<void> _setFailedAttempts(int count) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyFailedAttempts, count);
  }

  // Get lock until timestamp
  Future<DateTime?> _getLockUntil() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_keyLockUntil);
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : null;
  }

  // Set lock until timestamp
  Future<void> _setLockUntil(DateTime? dateTime) async {
    final prefs = await SharedPreferences.getInstance();
    if (dateTime != null) {
      await prefs.setInt(_keyLockUntil, dateTime.millisecondsSinceEpoch);
    } else {
      await prefs.remove(_keyLockUntil);
    }
  }

  // Clear lock data
  Future<void> _clearLockData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyFailedAttempts);
    await prefs.remove(_keyLockUntil);
  }

  // Check if account is locked
  Future<bool> isLocked() async {
    final lockUntil = await _getLockUntil();
    if (lockUntil == null) return false;

    if (DateTime.now().isAfter(lockUntil)) {
      // Clear expired lock
      await _clearLockData();
      return false;
    }
    return true;
  }

  // Get remaining lock time in minutes
  Future<int> getRemainingLockTime() async {
    final lockUntil = await _getLockUntil();
    if (lockUntil == null) return 0;
    final remaining = lockUntil.difference(DateTime.now()).inSeconds;
    return remaining > 0 ? (remaining / 60).ceil() : 0;
  }

  // ========== LOGIN ==========
  Future<Map<String, dynamic>> login(String email, String password) async {
    // Check if locked
    if (await isLocked()) {
      final remaining = await getRemainingLockTime();
      throw Exception("locked:$remaining");
    }

    try {
      // Authenticate
      final userCredential = await _authService.login(email.trim(), password);

      // Clear failed attempts on success
      await _clearLockData();

      // Get user document
      final userDoc = await _userService.getUserDocument(
        userCredential.user!.uid,
      );
      if (!userDoc.exists) {
        throw Exception("user_not_found");
      }

      final userData = UserModel.fromMap(
        userCredential.user!.uid,
        userDoc.data() as Map<String, dynamic>,
      );

      // Get profile
      final profileDoc = await _profileService.getRunnerProfile(
        userCredential.user!.uid,
      );
      RunnerProfileModel? profileData;

      if (profileDoc.exists) {
        profileData = RunnerProfileModel.fromMap(
          userCredential.user!.uid,
          profileDoc.data() as Map<String, dynamic>,
        );
      }

      return {'user': userData, 'profile': profileData};
    } on FirebaseAuthException catch (e) {
      // Increment failed attempts
      final failedAttempts = await _getFailedAttempts();
      await _setFailedAttempts(failedAttempts + 1);

      // Lock after 5 attempts
      if (failedAttempts + 1 >= 5) {
        final lockUntil = DateTime.now().add(Duration(minutes: 5));
        await _setLockUntil(lockUntil);
        throw Exception("locked:5");
      }

      // Use generic error message (security - don't reveal if email exists)
      if (e.code == 'user-not-found' || e.code == 'unknown') {
        throw Exception("user_not_found");
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        throw Exception("invalid_credentials");
      }

      throw Exception("invalid_credentials");
    }
  }

  // ========== REGISTER ==========
  Future<Map<String, dynamic>> registerRunner({
    required String email,
    required String password,
  }) async {
    final emailTrimmed = email.trim();

    try {
      // Create auth user
      final userCredential = await _authService.register(
        emailTrimmed,
        password,
      );
      final user = userCredential.user!;

      // Extract name
      final extractedName = AppUtils.extractNameFromEmail(emailTrimmed);

      // Create user document
      final userDoc = {
        'email': emailTrimmed,
        'role': 'runner',
        'status': 'inactive',
        'email_verified': false,
        'created_at': FieldValue.serverTimestamp(),
      };
      await _userService.createUserDocument(user.uid, userDoc);

      // Create profile document
      final profileDoc = {
        'name': extractedName,
        'phone': null,
        'gender': null,
        'dob': null,
        'created_at': FieldValue.serverTimestamp(),
        'updated_at': FieldValue.serverTimestamp(),
      };
      await _profileService.createRunnerProfile(user.uid, profileDoc);

      // Send verification email
      await _authService.sendEmailVerification(user);

      return {
        'user': UserModel(
          uid: user.uid,
          email: emailTrimmed,
          role: 'runner',
          status: 'inactive',
          emailVerified: false,
        ),
        'profile': RunnerProfileModel(
          uid: user.uid,
          name: extractedName,
          createdAt: DateTime.now(),
        ),
      };
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception("email_exists");
      }
      rethrow;
    } catch (e) {
      // Rollback on Firestore failure
      try {
        await _authService.currentUser?.delete();
      } catch (_) {}
      rethrow;
    }
  }

  // ========== LOGOUT ==========
  Future<void> logout() async {
    await _authService.logout();
    await _clearLockData();
  }

  // ========== EMAIL VERIFICATION ==========
  Future<void> resendEmailVerification() async {
    final user = _authService.currentUser;
    if (user == null) throw Exception("not_logged_in");
    if (user.emailVerified) throw Exception("already_verified");

    try {
      await _authService.sendEmailVerification(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        throw Exception("too_many_requests");
      }
      rethrow;
    }
  }

  Future<bool> checkEmailVerification() async {
    final user = _authService.currentUser;
    if (user == null) return false;

    await _authService.reloadUser();
    final isVerified = _authService.isEmailVerified;

    if (isVerified) {
      // Update email_verified status in Firestore
      await _userService.updateEmailVerifiedStatus(user.uid, true);

      // Update status to 'active' when email is verified
      await _userService.updateUserStatus(user.uid, 'active');
    }

    return isVerified;
  }
}
