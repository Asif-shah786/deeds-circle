// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserChallengeImpl _$$UserChallengeImplFromJson(Map<String, dynamic> json) =>
    _$UserChallengeImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      challengeId: json['challengeId'] as String,
      status: json['status'] as String,
      completedVideoIds: (json['completedVideoIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastUpdated: _timestampFromJson(json['lastUpdated']),
      paidAmount: (json['paidAmount'] as num).toDouble(),
      streakDays: (json['streakDays'] as num).toInt(),
      joinedAt: _timestampFromJson(json['joinedAt']),
      earnedAmount: (json['earnedAmount'] as num).toDouble(),
      lastCompletedVideo: json['lastCompletedVideo'] == null
          ? null
          : LastCompletedVideo.fromJson(
              json['lastCompletedVideo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserChallengeImplToJson(_$UserChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'challengeId': instance.challengeId,
      'status': instance.status,
      'completedVideoIds': instance.completedVideoIds,
      'lastUpdated': _timestampToJson(instance.lastUpdated),
      'paidAmount': instance.paidAmount,
      'streakDays': instance.streakDays,
      'joinedAt': _timestampToJson(instance.joinedAt),
      'earnedAmount': instance.earnedAmount,
      'lastCompletedVideo': instance.lastCompletedVideo?.toJson(),
    };

_$LastCompletedVideoImpl _$$LastCompletedVideoImplFromJson(
        Map<String, dynamic> json) =>
    _$LastCompletedVideoImpl(
      videoId: json['videoId'] as String,
      completedAt: _timestampFromJson(json['completedAt']),
      title: json['title'] as String,
    );

Map<String, dynamic> _$$LastCompletedVideoImplToJson(
        _$LastCompletedVideoImpl instance) =>
    <String, dynamic>{
      'videoId': instance.videoId,
      'completedAt': _timestampToJson(instance.completedAt),
      'title': instance.title,
    };
