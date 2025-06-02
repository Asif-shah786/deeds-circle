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
    required DateTime lastUpdated,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);

  factory UserSettings.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserSettings.fromJson({
      'userId': doc.id,
      ...data,
      'lastUpdated': (data['lastUpdated'] as Timestamp).toDate().toIso8601String(),
    });
  }
}
