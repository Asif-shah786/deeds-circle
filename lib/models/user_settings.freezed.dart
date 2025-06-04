// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return _UserSettings.fromJson(json);
}

/// @nodoc
mixin _$UserSettings {
  String get userId => throw _privateConstructorUsedError;
  bool get emailNotifications => throw _privateConstructorUsedError;
  bool get pushNotifications => throw _privateConstructorUsedError;
  bool get dailyReminders => throw _privateConstructorUsedError;
  String get preferredLanguage => throw _privateConstructorUsedError;
  String get theme => throw _privateConstructorUsedError;
  Map<String, dynamic> get preferences => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
          UserSettings value, $Res Function(UserSettings) then) =
      _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call(
      {String userId,
      bool emailNotifications,
      bool pushNotifications,
      bool dailyReminders,
      String preferredLanguage,
      String theme,
      Map<String, dynamic> preferences,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime lastUpdated});
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? emailNotifications = null,
    Object? pushNotifications = null,
    Object? dailyReminders = null,
    Object? preferredLanguage = null,
    Object? theme = null,
    Object? preferences = null,
    Object? lastUpdated = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      emailNotifications: null == emailNotifications
          ? _value.emailNotifications
          : emailNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotifications: null == pushNotifications
          ? _value.pushNotifications
          : pushNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyReminders: null == dailyReminders
          ? _value.dailyReminders
          : dailyReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      preferredLanguage: null == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      preferences: null == preferences
          ? _value.preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
          _$UserSettingsImpl value, $Res Function(_$UserSettingsImpl) then) =
      __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      bool emailNotifications,
      bool pushNotifications,
      bool dailyReminders,
      String preferredLanguage,
      String theme,
      Map<String, dynamic> preferences,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime lastUpdated});
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
      _$UserSettingsImpl _value, $Res Function(_$UserSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? emailNotifications = null,
    Object? pushNotifications = null,
    Object? dailyReminders = null,
    Object? preferredLanguage = null,
    Object? theme = null,
    Object? preferences = null,
    Object? lastUpdated = null,
  }) {
    return _then(_$UserSettingsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      emailNotifications: null == emailNotifications
          ? _value.emailNotifications
          : emailNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotifications: null == pushNotifications
          ? _value.pushNotifications
          : pushNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyReminders: null == dailyReminders
          ? _value.dailyReminders
          : dailyReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      preferredLanguage: null == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as String,
      preferences: null == preferences
          ? _value._preferences
          : preferences // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl(
      {required this.userId,
      required this.emailNotifications,
      required this.pushNotifications,
      required this.dailyReminders,
      required this.preferredLanguage,
      required this.theme,
      required final Map<String, dynamic> preferences,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.lastUpdated})
      : _preferences = preferences;

  factory _$UserSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsImplFromJson(json);

  @override
  final String userId;
  @override
  final bool emailNotifications;
  @override
  final bool pushNotifications;
  @override
  final bool dailyReminders;
  @override
  final String preferredLanguage;
  @override
  final String theme;
  final Map<String, dynamic> _preferences;
  @override
  Map<String, dynamic> get preferences {
    if (_preferences is EqualUnmodifiableMapView) return _preferences;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_preferences);
  }

  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime lastUpdated;

  @override
  String toString() {
    return 'UserSettings(userId: $userId, emailNotifications: $emailNotifications, pushNotifications: $pushNotifications, dailyReminders: $dailyReminders, preferredLanguage: $preferredLanguage, theme: $theme, preferences: $preferences, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.emailNotifications, emailNotifications) ||
                other.emailNotifications == emailNotifications) &&
            (identical(other.pushNotifications, pushNotifications) ||
                other.pushNotifications == pushNotifications) &&
            (identical(other.dailyReminders, dailyReminders) ||
                other.dailyReminders == dailyReminders) &&
            (identical(other.preferredLanguage, preferredLanguage) ||
                other.preferredLanguage == preferredLanguage) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            const DeepCollectionEquality()
                .equals(other._preferences, _preferences) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      emailNotifications,
      pushNotifications,
      dailyReminders,
      preferredLanguage,
      theme,
      const DeepCollectionEquality().hash(_preferences),
      lastUpdated);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsImplToJson(
      this,
    );
  }
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings(
      {required final String userId,
      required final bool emailNotifications,
      required final bool pushNotifications,
      required final bool dailyReminders,
      required final String preferredLanguage,
      required final String theme,
      required final Map<String, dynamic> preferences,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime lastUpdated}) = _$UserSettingsImpl;

  factory _UserSettings.fromJson(Map<String, dynamic> json) =
      _$UserSettingsImpl.fromJson;

  @override
  String get userId;
  @override
  bool get emailNotifications;
  @override
  bool get pushNotifications;
  @override
  bool get dailyReminders;
  @override
  String get preferredLanguage;
  @override
  String get theme;
  @override
  Map<String, dynamic> get preferences;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get lastUpdated;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
