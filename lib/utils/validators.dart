class Validators {
  // email validation
  static bool isEmailValid(String email) {
    final emailTrim = email.trim();
    final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailTrim.isNotEmpty &&
        emailTrim.length <= 100 &&
        regex.hasMatch(emailTrim);
  }

  // Password validation
  static bool isPasswordValid(String password) {
    return password.length >= 8 && password.length <= 16;
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
