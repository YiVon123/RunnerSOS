import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid; // Firebase Auth uid
  final String email;
  final String role; // runner | event_staff | medic
  final String status; // active | inactive
  final bool emailVerified;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.email,
    required this.role,
    required this.status,
    this.emailVerified = false,
    this.createdAt,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> m) {
    return UserModel(
      uid: uid,
      email: m['email'] ?? '',
      role: m['role'] ?? 'runner',
      status: m['status'] ?? 'inactive',
      emailVerified: m['email_verified'] ?? false,
      createdAt: m['created_at'] != null
          ? (m['created_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
      'status': status,
      'email_verified': emailVerified,
      'created_at': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
    };
  }

  UserModel copyWith({
    String? email,
    String? role,
    String? status,
    bool? emailVerified,
  }) {
    return UserModel(
      uid: uid,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      createdAt: createdAt,
      emailVerified: emailVerified ?? this.emailVerified,
    );
  }
}
