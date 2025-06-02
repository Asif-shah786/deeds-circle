import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'challenge.freezed.dart';
part 'challenge.g.dart';

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    required String id,
    required String title,
    required String description,
    required List<String> admins,
    required String primaryAdminId,
    required bool isPublic,
    String? thumbnailUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
    required List<String> keywords,
    required double rewardAmount,
    required int totalVideos,
    required double totalPossibleEarning,
    required String purpose,
    DateTime? startDate,
    DateTime? endDate,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

  factory Challenge.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Challenge.fromJson({
      'id': doc.id,
      ...data,
      'createdAt': (data['createdAt'] as Timestamp).toDate().toIso8601String(),
      'updatedAt': (data['updatedAt'] as Timestamp).toDate().toIso8601String(),
      if (data['startDate'] != null) 'startDate': (data['startDate'] as Timestamp).toDate().toIso8601String(),
      if (data['endDate'] != null) 'endDate': (data['endDate'] as Timestamp).toDate().toIso8601String(),
    });
  }
}
