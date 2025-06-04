// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSettingsImpl _$$UserSettingsImplFromJson(Map<String, dynamic> json) =>
    _$UserSettingsImpl(
      userId: json['userId'] as String,
      emailNotifications: json['emailNotifications'] as bool,
      pushNotifications: json['pushNotifications'] as bool,
      dailyReminders: json['dailyReminders'] as bool,
      preferredLanguage: json['preferredLanguage'] as String,
      theme: json['theme'] as String,
      preferences: json['preferences'] as Map<String, dynamic>,
      lastUpdated: _timestampFromJson(json['lastUpdated']),
    );

Map<String, dynamic> _$$UserSettingsImplToJson(_$UserSettingsImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'emailNotifications': instance.emailNotifications,
      'pushNotifications': instance.pushNotifications,
      'dailyReminders': instance.dailyReminders,
      'preferredLanguage': instance.preferredLanguage,
      'theme': instance.theme,
      'preferences': instance.preferences,
      'lastUpdated': _timestampToJson(instance.lastUpdated),
    };
