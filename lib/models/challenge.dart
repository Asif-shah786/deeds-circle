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
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required DateTime createdAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required DateTime updatedAt,
    required List<String> keywords,
    required double rewardAmount,
    required int totalVideos,
    required double totalPossibleEarning,
    required String purpose,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? startDate,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? endDate,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

  factory Challenge.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Challenge.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}

extension ChallengeFirestore on Challenge {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    return {
      ...json,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      if (startDate != null) 'startDate': Timestamp.fromDate(startDate!),
      if (endDate != null) 'endDate': Timestamp.fromDate(endDate!),
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

dynamic _timestampToJson(DateTime? dateTime) {
  if (dateTime == null) return null;
  return Timestamp.fromDate(dateTime);
}
