// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminRoleImpl _$$AdminRoleImplFromJson(Map<String, dynamic> json) =>
    _$AdminRoleImpl(
      id: json['id'] as String,
      challengeId: json['challengeId'] as String,
      userId: json['userId'] as String,
      role: json['role'] as String,
      permissions: (json['permissions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      assignedAt: DateTime.parse(json['assignedAt'] as String),
      assignedBy: json['assignedBy'] as String,
      isActive: json['isActive'] as bool,
      lastActive: json['lastActive'] == null
          ? null
          : DateTime.parse(json['lastActive'] as String),
    );

Map<String, dynamic> _$$AdminRoleImplToJson(_$AdminRoleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'challengeId': instance.challengeId,
      'userId': instance.userId,
      'role': instance.role,
      'permissions': instance.permissions,
      'assignedAt': instance.assignedAt.toIso8601String(),
      'assignedBy': instance.assignedBy,
      'isActive': instance.isActive,
      'lastActive': instance.lastActive?.toIso8601String(),
    };
