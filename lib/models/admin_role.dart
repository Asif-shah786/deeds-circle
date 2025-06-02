import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'admin_role.freezed.dart';
part 'admin_role.g.dart';

@freezed
class AdminRole with _$AdminRole {
  const factory AdminRole({
    required String id,
    required String challengeId,
    required String userId,
    required String role,
    required List<String> permissions,
    required DateTime assignedAt,
    required String assignedBy,
    required bool isActive,
    DateTime? lastActive,
  }) = _AdminRole;

  factory AdminRole.fromJson(Map<String, dynamic> json) => _$AdminRoleFromJson(json);

  factory AdminRole.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AdminRole.fromJson({
      'id': doc.id,
      ...data,
      'assignedAt': (data['assignedAt'] as Timestamp).toDate().toIso8601String(),
      if (data['lastActive'] != null) 'lastActive': (data['lastActive'] as Timestamp).toDate().toIso8601String(),
    });
  }
}
