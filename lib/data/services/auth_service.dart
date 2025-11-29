import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register
  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Login
  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }

  // Reset Password
  Future<void> sendPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Send email verificaton
  Future<void> sendEmailVerification(User user) async {
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // Check if email is verified
  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  // Reload user (to check email verification status)
  Future<void> reloadUser() async {
    await _auth.currentUser?.reload();
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get current uid
  String? get currentUid => _auth.currentUser?.uid;
}




  // // Change password
  // Future<void> changePassword(String newPassword) async {
  //   final user = _auth.currentUser;
  //   if (user != null) {
  //     await user.updatePassword(newPassword);
  //   }
  // }

  // // Re-authenticate user (required before sensitive operations)
  // Future<void> reauthenticate(String email, String password) async {
  //   final user = _auth.currentUser;
  //   if (user != null) {
  //     final credential = EmailAuthProvider.credential(
  //       email: email,
  //       password: password,
  //     );
  //     await user.reauthenticateWithCredential(credential);
  //   }
  // }