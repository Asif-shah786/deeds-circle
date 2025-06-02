// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LeaderboardEntryImpl _$$LeaderboardEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaderboardEntryImpl(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userPhotoUrl: json['userPhotoUrl'] as String?,
      rank: (json['rank'] as num).toInt(),
      videosCompleted: (json['videosCompleted'] as num).toInt(),
      moneyEarned: (json['moneyEarned'] as num).toDouble(),
      streakDays: (json['streakDays'] as num).toInt(),
      isCurrentUser: json['isCurrentUser'] as bool,
    );

Map<String, dynamic> _$$LeaderboardEntryImplToJson(
        _$LeaderboardEntryImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userPhotoUrl': instance.userPhotoUrl,
      'rank': instance.rank,
      'videosCompleted': instance.videosCompleted,
      'moneyEarned': instance.moneyEarned,
      'streakDays': instance.streakDays,
      'isCurrentUser': instance.isCurrentUser,
    };

_$LeaderboardImpl _$$LeaderboardImplFromJson(Map<String, dynamic> json) =>
    _$LeaderboardImpl(
      challengeId: json['challengeId'] as String,
      entries: (json['entries'] as List<dynamic>)
          .map((e) => LeaderboardEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentUserEntry: json['currentUserEntry'] == null
          ? null
          : LeaderboardEntry.fromJson(
              json['currentUserEntry'] as Map<String, dynamic>),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
    );

Map<String, dynamic> _$$LeaderboardImplToJson(_$LeaderboardImpl instance) =>
    <String, dynamic>{
      'challengeId': instance.challengeId,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
      'currentUserEntry': instance.currentUserEntry?.toJson(),
      'lastUpdated': instance.lastUpdated.toIso8601String(),
    };
