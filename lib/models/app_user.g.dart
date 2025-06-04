// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppUserImpl _$$AppUserImplFromJson(Map<String, dynamic> json) =>
    _$AppUserImpl(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      bio: json['bio'] as String?,
      createdAt: _timestampFromJson(json['createdAt']),
      lastLogin: _timestampFromJson(json['lastLogin']),
      totalCompletedVideos: (json['totalCompletedVideos'] as num).toInt(),
      totalEarnings: (json['totalEarnings'] as num).toDouble(),
      totalPaid: (json['totalPaid'] as num).toDouble(),
      points: (json['points'] as num).toInt(),
      isAdmin: json['isAdmin'] as bool,
      preferredLanguage: json['preferredLanguage'] as String,
      bankAccountDetails: json['bankAccountDetails'] == null
          ? null
          : BankAccountDetails.fromJson(
              json['bankAccountDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AppUserImplToJson(_$AppUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'displayName': instance.displayName,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'bio': instance.bio,
      'createdAt': _timestampToJson(instance.createdAt),
      'lastLogin': _timestampToJson(instance.lastLogin),
      'totalCompletedVideos': instance.totalCompletedVideos,
      'totalEarnings': instance.totalEarnings,
      'totalPaid': instance.totalPaid,
      'points': instance.points,
      'isAdmin': instance.isAdmin,
      'preferredLanguage': instance.preferredLanguage,
      'bankAccountDetails': instance.bankAccountDetails?.toJson(),
    };
