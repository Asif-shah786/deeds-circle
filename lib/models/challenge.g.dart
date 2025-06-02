// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'challenge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      admins:
          (json['admins'] as List<dynamic>).map((e) => e as String).toList(),
      primaryAdminId: json['primaryAdminId'] as String,
      isPublic: json['isPublic'] as bool,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      rewardAmount: (json['rewardAmount'] as num).toDouble(),
      totalVideos: (json['totalVideos'] as num).toInt(),
      totalPossibleEarning: (json['totalPossibleEarning'] as num).toDouble(),
      purpose: json['purpose'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'admins': instance.admins,
      'primaryAdminId': instance.primaryAdminId,
      'isPublic': instance.isPublic,
      'thumbnailUrl': instance.thumbnailUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'keywords': instance.keywords,
      'rewardAmount': instance.rewardAmount,
      'totalVideos': instance.totalVideos,
      'totalPossibleEarning': instance.totalPossibleEarning,
      'purpose': instance.purpose,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
