import 'package:flutter/material.dart';
import 'package:runner_sos/models/runner_profile_model.dart';
import 'package:runner_sos/models/user_model.dart';
import 'package:runner_sos/utils/validators.dart';
import '../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repo = AuthRepository();

  bool isLoading = false;
  String? errorMessage;
  UserModel? currentUser;
  RunnerProfileModel? currentProfile;

  // Get the correct home route based on user role
  String getHomeRoute() {
    if (currentUser == null) return '/login';

    switch (currentUser!.role) {
      case 'runner':
        return '/dashboard/runner';
      case 'event_staff':
      case 'medic':
        return '/dashboard/staff';
      default:
        return '/dashboard/runner';
    }
  }

  // Check if user is logged in
  bool get isLoggedIn => currentUser != null;
  String? get userRole => currentUser?.role;
  String get userName => currentProfile?.name ?? 'User';

  // Login
  Future<bool> login(String email, String password) async {
    errorMessage = null;

    // Email validation
    if (!Validators.isEmailValid(email)) {
      errorMessage =
          "Invalid email. The standard format of email is name@domain.com. Please enter a valid email address.";
      notifyListeners();
      return Future.value(false);
    }

    // Password validation
    if (!Validators.isPasswordValid(password)) {
      errorMessage =
          "Invalid password. Password must be 8–16 characters long. Please enter a valid password.";
      notifyListeners();
      return Future.value(false);
    }

    // Loading ui
    isLoading = true;
    notifyListeners();

    // Login
    try {
      final result = await _repo.login(email, password);
      currentUser = result['user'] as UserModel;
      currentProfile = result['profile'] as RunnerProfileModel?;

      isLoading = false;
      errorMessage = null;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      // Error detected
      isLoading = false;
      String error = e.toString();

      if (error.contains("locked")) {
        final minutes = error.split(':').last;
        errorMessage =
            "Your account has been locked due to multiple failed login attempts. Please try again after $minutes minutes.";
      } else if (error.contains("not_registered")) {
        errorMessage = "Account not found. Please register first.";
      } else if (error.contains("wrong_password")) {
        errorMessage = "Invalid email or password. Please try again.";
      } else {
        errorMessage = "An error occurred. Please try again.";
      }

      notifyListeners();
      return Future.value(false);
    }
  }

  // Register
  Future<bool> registerRunner({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    errorMessage = null;
    // Email validation
    if (!Validators.isEmailValid(email)) {
      errorMessage =
          "Invalid email. The standard format of email is name@domain.com. Please enter a valid email address.";
      notifyListeners();
      return Future.value(false);
    }

    // Password validation
    if (!Validators.isPasswordValid(password)) {
      errorMessage =
          "Invalid password. Password must be 8–16 characters long. Please enter a valid password.";
      notifyListeners();
      return Future.value(false);
    }

    // Password n Confirm Password Validation
    if (password != confirmPassword) {
      errorMessage =
          "The password and confirmed password must be the same. Please try again.";
      notifyListeners();
      return Future.value(false);
    }

    // Loading ui
    isLoading = true;
    notifyListeners();

    // register
    try {
      final result = await _repo.registerRunner(
        email: email,
        password: password,
      );

      currentUser = result['user'] as UserModel;
      currentProfile = result['profile'] as RunnerProfileModel;

      isLoading = false;
      errorMessage = null;
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      isLoading = false;
      String error = e.toString();

      if (error.contains("email_exists")) {
        errorMessage =
            "This email is already registered. Please log in instead.";
      }

      notifyListeners();
      return Future.value(false);
    }
  }

  // ========== LOGOUT ==========
  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    await _repo.logout();
    currentUser = null;
    currentProfile = null;

    isLoading = false;
    notifyListeners();
  }

  // ========== FORGOT PASSWORD ==========
  Future<bool> forgotPassword(String email) async {
    errorMessage = null;

    if (!Validators.isEmailValid(email)) {
      errorMessage = "Invalid email. Please enter a valid email address.";
      notifyListeners();
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      await _repo.sendPasswordReset(email);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      final error = e.toString();

      if (error.contains("invalid_email")) {
        errorMessage = "Invalid email format.";
      } else {
        errorMessage = "An error occurred. Please try again.";
      }

      notifyListeners();
      return false;
    }
  }

  // ========== EMAIL VERIFICATION ==========
  Future<bool> resendVerificationEmail() async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      await _repo.resendEmailVerification();
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      final error = e.toString();

      if (error.contains("already_verified")) {
        errorMessage = "Email is already verified.";
      } else if (error.contains("too_many_requests")) {
        errorMessage = "Too many requests. Please wait a moment.";
      } else if (error.contains("not_logged_in")) {
        errorMessage = "You must be logged in.";
      } else {
        errorMessage = "Failed to send verification email.";
      }

      notifyListeners();
      return false;
    }
  }

  Future<bool> checkEmailVerification() async {
    try {
      final isVerified = await _repo.checkEmailVerification();
      if (isVerified && currentUser != null) {
        currentUser = currentUser!.copyWith(
          emailVerified: true,
          status: 'active',
        );
        notifyListeners();
      }
      return isVerified;
    } catch (e) {
      return false;
    }
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }
}
