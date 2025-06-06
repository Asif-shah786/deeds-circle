import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    required String userId,
    required bool emailNotifications,
    required bool pushNotifications,
    required bool dailyReminders,
    required String preferredLanguage,
    required String theme,
    required Map<String, dynamic> preferences,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required DateTime lastUpdated,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);

  factory UserSettings.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserSettings.fromJson({
      'userId': doc.id,
      ...data,
    });
  }
}

extension UserSettingsFirestore on UserSettings {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    return {
      ...json,
      'lastUpdated': Timestamp.fromDate(lastUpdated),
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
  return Timestamp.fromDate(dateTime);
}
