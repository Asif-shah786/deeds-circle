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
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required DateTime createdAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required DateTime lastLogin,
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
    });
  }
}

extension AppUserFirestore on AppUser {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    return {
      ...json,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
    };
  }
}

// Helper functions for DateTime/Timestamp conversion
DateTime _timestampFromJson(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  } else if (timestamp is String) {
    return DateTime.parse(timestamp);
  } else if (timestamp is int) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
  throw ArgumentError('Invalid timestamp format');
}

dynamic _timestampToJson(DateTime dateTime) {
  return Timestamp.fromDate(dateTime);
}
