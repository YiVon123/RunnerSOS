class AppUtils {
  // Extract name from email
  static String extractNameFromEmail(String email) {
    final username = email.trim().split('@').first;
    final cleaned = username.replaceAll(RegExp(r'[._0-9]'), '');
    if (cleaned.isEmpty) return 'User';
    return cleaned[0].toUpperCase() + cleaned.substring(1).toLowerCase();
  }
}
