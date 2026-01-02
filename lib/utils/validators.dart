class Validators {
  // email validation
  static bool isEmailValid(String email) {
    final emailTrim = email.trim();
    final regex = RegExp(
      r"^[\w\.\-\+]+@(gmail\.com|yahoo\.com|hotmail\.com|[\w-]+\.com|[\w-]+\.my|[\w-]+\.com\.my)$",
    );
    return emailTrim.isNotEmpty &&
        emailTrim.length <= 100 &&
        regex.hasMatch(emailTrim);
  }

  // Login Password validation
  static bool isLoginPasswordValid(String password) {
    return password.length >= 8 && password.length <= 16;
  }

  // Reg Password validation
  static bool isRegPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~.]).{8,16}$');
    return regex.hasMatch(password);
  }

  // phone validation
  static bool isPhoneValid(String? phone) {
    if (phone == null || phone.trim().isEmpty) return true;
    final regex = RegExp(r'^\+?[\d\s-]{10,11}$');
    return regex.hasMatch(phone.trim());
  }

  // Name Validation
  static bool isNameValid(String name) {
    return name.trim().isNotEmpty && name.trim().length <= 80;
  }
}
