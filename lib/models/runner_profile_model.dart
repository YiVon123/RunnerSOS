import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class RunnerProfileModel {
  final String uid;
  final String name;
  final String? phone;
  final String? gender;
  final DateTime? dob;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  RunnerProfileModel({
    required this.uid,
    required this.name,
    this.phone,
    this.gender,
    this.dob,
    this.createdAt,
    this.updatedAt,
  });

  factory RunnerProfileModel.fromMap(String uid, Map<String, dynamic> m) {
    return RunnerProfileModel(
      uid: uid,
      name: m['name'] ?? '',
      phone: m['phone'],
      gender: m['gender'],
      dob: m['dob'] != null ? (m['dob'] as Timestamp).toDate() : null,
      createdAt: m['created_at'] != null
          ? (m['created_at'] as Timestamp).toDate()
          : null,
      updatedAt: m['updated_at'] != null
          ? (m['updated_at'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'gender': gender,
      'dob': dob != null ? Timestamp.fromDate(dob!) : null,
      'created_at': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
  }

  // Copy with method for updates
  RunnerProfileModel copyWith({
    String? name,
    String? phone,
    String? gender,
    DateTime? dob,
  }) {
    return RunnerProfileModel(
      uid: uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
