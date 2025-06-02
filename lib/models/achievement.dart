import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'achievement.freezed.dart';
part 'achievement.g.dart';

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String userId,
    required String type,
    required String title,
    required String description,
    required DateTime earnedAt,
    required Map<String, dynamic> metadata,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);

  factory Achievement.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Achievement.fromJson({
      'id': doc.id,
      ...data,
      'earnedAt': (data['earnedAt'] as Timestamp).toDate().toIso8601String(),
    });
  }
}
