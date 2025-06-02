import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'leaderboard.freezed.dart';
part 'leaderboard.g.dart';

@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required String userId,
    required String userName,
    required String? userPhotoUrl,
    required int rank,
    required int videosCompleted,
    required double moneyEarned,
    required int streakDays,
    required bool isCurrentUser,
  }) = _LeaderboardEntry;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) => _$LeaderboardEntryFromJson(json);

  factory LeaderboardEntry.fromFirestore(
    Map<String, dynamic> data,
    String userId,
    String currentUserId,
  ) {
    return LeaderboardEntry(
      userId: userId,
      userName: data['userName'] as String,
      userPhotoUrl: data['userPhotoUrl'] as String?,
      rank: data['rank'] as int,
      videosCompleted: data['videosCompleted'] as int,
      moneyEarned: (data['moneyEarned'] as num).toDouble(),
      streakDays: data['streakDays'] as int,
      isCurrentUser: userId == currentUserId,
    );
  }
}

@freezed
class Leaderboard with _$Leaderboard {
  const factory Leaderboard({
    required String challengeId,
    required List<LeaderboardEntry> entries,
    required LeaderboardEntry? currentUserEntry,
    required DateTime lastUpdated,
  }) = _Leaderboard;

  factory Leaderboard.fromJson(Map<String, dynamic> json) => _$LeaderboardFromJson(json);
}
