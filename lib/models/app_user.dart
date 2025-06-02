import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bank_account_details.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String displayName,
    required String email,
    String? photoUrl,
    String? bio,
    required DateTime createdAt,
    required DateTime lastLogin,
    required int totalCompletedVideos,
    required double totalEarnings,
    required double totalPaid,
    required int points,
    required bool isAdmin,
    required String preferredLanguage,
    BankAccountDetails? bankAccountDetails,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);

  factory AppUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AppUser.fromJson({
      'id': doc.id,
      ...data,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'lastLogin': (data['lastLogin'] as Timestamp).toDate().toIso8601String(),
    });
  }
}
