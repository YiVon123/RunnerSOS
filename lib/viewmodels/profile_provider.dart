import 'package:flutter/material.dart';
import '../data/repositories/profile_repository.dart';
import '../models/runner_profile_model.dart';
import '../utils/validators.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepository _repo = ProfileRepository();

  bool isLoading = false;
  String? errorMessage;
  RunnerProfileModel? currentProfile;

  // Load profile
  Future<void> loadProfile(String uid) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final data = await _repo.getUserData(uid);
      currentProfile = data['profile'] as RunnerProfileModel?;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = "Failed to load profile.";
      notifyListeners();
    }
  }

  // Update profile
  Future<bool> updateProfile({
    required String uid,
    String? name,
    String? phone,
    String? gender,
    DateTime? dob,
  }) async {
    errorMessage = null;

    // Name validation
    if (name != null && !Validators.isNameValid(name)) {
      errorMessage = "Name must be 1-80 characters.";
      notifyListeners();
      return false;
    }

    // Phone validation
    if (phone != null &&
        phone.trim().isNotEmpty &&
        !Validators.isPhoneValid(phone)) {
      errorMessage =
          "Invalid phone number. Phone number must be in the format of 01xxxxxxxxx or 01xxxxxxxx.";
      notifyListeners();
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      currentProfile = await _repo.updateRunnerProfile(
        uid: uid,
        name: name,
        phone: phone,
        gender: gender,
        dob: dob,
      );

      isLoading = false;
      errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      final error = e.toString();

      if (error.contains("invalid_phone")) {
        errorMessage = "Invalid phone number format.";
      } else if (error.contains("invalid_name")) {
        errorMessage = "Invalid name format.";
      } else if (error.contains("no_updates")) {
        errorMessage = "No changes to save.";
      } else {
        errorMessage = "Failed to update profile.";
      }

      notifyListeners();
      return false;
    }
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }
}
