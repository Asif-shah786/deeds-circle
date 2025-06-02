import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_challenge.freezed.dart';
part 'user_challenge.g.dart';

@freezed
class UserChallenge with _$UserChallenge {
  const factory UserChallenge({
    required String id,
    required String userId,
    required String challengeId,
    required String status,
    required List<String> completedVideoIds,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required DateTime lastUpdated,
    required double paidAmount,
    required int streakDays,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required DateTime joinedAt,
    required double earnedAmount,
    LastCompletedVideo? lastCompletedVideo,
  }) = _UserChallenge;

  factory UserChallenge.fromJson(Map<String, dynamic> json) => _$UserChallengeFromJson(json);

  factory UserChallenge.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserChallenge(
      id: doc.id,
      userId: data['userId'] as String,
      challengeId: data['challengeId'] as String,
      status: data['status'] as String,
      completedVideoIds: (data['completedVideoIds'] as List<dynamic>).map((e) => e as String).toList(),
      lastUpdated: (data['lastUpdated'] as Timestamp).toDate(),
      paidAmount: (data['paidAmount'] as num).toDouble(),
      streakDays: (data['streakDays'] as num).toInt(),
      joinedAt: (data['joinedAt'] as Timestamp).toDate(),
      earnedAmount: (data['earnedAmount'] as num).toDouble(),
      lastCompletedVideo: data['lastCompletedVideo'] != null
          ? LastCompletedVideo.fromFirestore(data['lastCompletedVideo'] as Map<String, dynamic>)
          : null,
    );
  }
}

extension UserChallengeFirestore on UserChallenge {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    return {
      ...json,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
      'joinedAt': Timestamp.fromDate(joinedAt),
      'lastCompletedVideo': lastCompletedVideo?.toFirestore(),
    };
  }
}

@freezed
class LastCompletedVideo with _$LastCompletedVideo {
  const factory LastCompletedVideo({
    required String videoId,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required DateTime completedAt,
    required String title,
  }) = _LastCompletedVideo;

  factory LastCompletedVideo.fromJson(Map<String, dynamic> json) => _$LastCompletedVideoFromJson(json);

  factory LastCompletedVideo.fromFirestore(Map<String, dynamic> data) {
    return LastCompletedVideo(
      videoId: data['videoId'] as String,
      completedAt: (data['completedAt'] as Timestamp).toDate(),
      title: data['title'] as String,
    );
  }
}

extension LastCompletedVideoFirestore on LastCompletedVideo {
  Map<String, dynamic> toFirestore() {
    return {
      'videoId': videoId,
      'completedAt': Timestamp.fromDate(completedAt),
      'title': title,
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
  return dateTime.toIso8601String();
}
