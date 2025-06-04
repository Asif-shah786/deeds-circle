// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get lastLogin => throw _privateConstructorUsedError;
  int get totalCompletedVideos => throw _privateConstructorUsedError;
  double get totalEarnings => throw _privateConstructorUsedError;
  double get totalPaid => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  String get preferredLanguage => throw _privateConstructorUsedError;
  BankAccountDetails? get bankAccountDetails =>
      throw _privateConstructorUsedError;

  /// Serializes this AppUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {String id,
      String displayName,
      String email,
      String? photoUrl,
      String? bio,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime lastLogin,
      int totalCompletedVideos,
      double totalEarnings,
      double totalPaid,
      int points,
      bool isAdmin,
      String preferredLanguage,
      BankAccountDetails? bankAccountDetails});

  $BankAccountDetailsCopyWith<$Res>? get bankAccountDetails;
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? email = null,
    Object? photoUrl = freezed,
    Object? bio = freezed,
    Object? createdAt = null,
    Object? lastLogin = null,
    Object? totalCompletedVideos = null,
    Object? totalEarnings = null,
    Object? totalPaid = null,
    Object? points = null,
    Object? isAdmin = null,
    Object? preferredLanguage = null,
    Object? bankAccountDetails = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLogin: null == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalCompletedVideos: null == totalCompletedVideos
          ? _value.totalCompletedVideos
          : totalCompletedVideos // ignore: cast_nullable_to_non_nullable
              as int,
      totalEarnings: null == totalEarnings
          ? _value.totalEarnings
          : totalEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      totalPaid: null == totalPaid
          ? _value.totalPaid
          : totalPaid // ignore: cast_nullable_to_non_nullable
              as double,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      preferredLanguage: null == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      bankAccountDetails: freezed == bankAccountDetails
          ? _value.bankAccountDetails
          : bankAccountDetails // ignore: cast_nullable_to_non_nullable
              as BankAccountDetails?,
    ) as $Val);
  }

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BankAccountDetailsCopyWith<$Res>? get bankAccountDetails {
    if (_value.bankAccountDetails == null) {
      return null;
    }

    return $BankAccountDetailsCopyWith<$Res>(_value.bankAccountDetails!,
        (value) {
      return _then(_value.copyWith(bankAccountDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppUserImplCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$AppUserImplCopyWith(
          _$AppUserImpl value, $Res Function(_$AppUserImpl) then) =
      __$$AppUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String displayName,
      String email,
      String? photoUrl,
      String? bio,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime lastLogin,
      int totalCompletedVideos,
      double totalEarnings,
      double totalPaid,
      int points,
      bool isAdmin,
      String preferredLanguage,
      BankAccountDetails? bankAccountDetails});

  @override
  $BankAccountDetailsCopyWith<$Res>? get bankAccountDetails;
}

/// @nodoc
class __$$AppUserImplCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$AppUserImpl>
    implements _$$AppUserImplCopyWith<$Res> {
  __$$AppUserImplCopyWithImpl(
      _$AppUserImpl _value, $Res Function(_$AppUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? email = null,
    Object? photoUrl = freezed,
    Object? bio = freezed,
    Object? createdAt = null,
    Object? lastLogin = null,
    Object? totalCompletedVideos = null,
    Object? totalEarnings = null,
    Object? totalPaid = null,
    Object? points = null,
    Object? isAdmin = null,
    Object? preferredLanguage = null,
    Object? bankAccountDetails = freezed,
  }) {
    return _then(_$AppUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastLogin: null == lastLogin
          ? _value.lastLogin
          : lastLogin // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalCompletedVideos: null == totalCompletedVideos
          ? _value.totalCompletedVideos
          : totalCompletedVideos // ignore: cast_nullable_to_non_nullable
              as int,
      totalEarnings: null == totalEarnings
          ? _value.totalEarnings
          : totalEarnings // ignore: cast_nullable_to_non_nullable
              as double,
      totalPaid: null == totalPaid
          ? _value.totalPaid
          : totalPaid // ignore: cast_nullable_to_non_nullable
              as double,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      preferredLanguage: null == preferredLanguage
          ? _value.preferredLanguage
          : preferredLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      bankAccountDetails: freezed == bankAccountDetails
          ? _value.bankAccountDetails
          : bankAccountDetails // ignore: cast_nullable_to_non_nullable
              as BankAccountDetails?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppUserImpl implements _AppUser {
  const _$AppUserImpl(
      {required this.id,
      required this.displayName,
      required this.email,
      this.photoUrl,
      this.bio,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.lastLogin,
      required this.totalCompletedVideos,
      required this.totalEarnings,
      required this.totalPaid,
      required this.points,
      required this.isAdmin,
      required this.preferredLanguage,
      this.bankAccountDetails});

  factory _$AppUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppUserImplFromJson(json);

  @override
  final String id;
  @override
  final String displayName;
  @override
  final String email;
  @override
  final String? photoUrl;
  @override
  final String? bio;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime lastLogin;
  @override
  final int totalCompletedVideos;
  @override
  final double totalEarnings;
  @override
  final double totalPaid;
  @override
  final int points;
  @override
  final bool isAdmin;
  @override
  final String preferredLanguage;
  @override
  final BankAccountDetails? bankAccountDetails;

  @override
  String toString() {
    return 'AppUser(id: $id, displayName: $displayName, email: $email, photoUrl: $photoUrl, bio: $bio, createdAt: $createdAt, lastLogin: $lastLogin, totalCompletedVideos: $totalCompletedVideos, totalEarnings: $totalEarnings, totalPaid: $totalPaid, points: $points, isAdmin: $isAdmin, preferredLanguage: $preferredLanguage, bankAccountDetails: $bankAccountDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastLogin, lastLogin) ||
                other.lastLogin == lastLogin) &&
            (identical(other.totalCompletedVideos, totalCompletedVideos) ||
                other.totalCompletedVideos == totalCompletedVideos) &&
            (identical(other.totalEarnings, totalEarnings) ||
                other.totalEarnings == totalEarnings) &&
            (identical(other.totalPaid, totalPaid) ||
                other.totalPaid == totalPaid) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.preferredLanguage, preferredLanguage) ||
                other.preferredLanguage == preferredLanguage) &&
            (identical(other.bankAccountDetails, bankAccountDetails) ||
                other.bankAccountDetails == bankAccountDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      displayName,
      email,
      photoUrl,
      bio,
      createdAt,
      lastLogin,
      totalCompletedVideos,
      totalEarnings,
      totalPaid,
      points,
      isAdmin,
      preferredLanguage,
      bankAccountDetails);

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      __$$AppUserImplCopyWithImpl<_$AppUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppUserImplToJson(
      this,
    );
  }
}

abstract class _AppUser implements AppUser {
  const factory _AppUser(
      {required final String id,
      required final String displayName,
      required final String email,
      final String? photoUrl,
      final String? bio,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime lastLogin,
      required final int totalCompletedVideos,
      required final double totalEarnings,
      required final double totalPaid,
      required final int points,
      required final bool isAdmin,
      required final String preferredLanguage,
      final BankAccountDetails? bankAccountDetails}) = _$AppUserImpl;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$AppUserImpl.fromJson;

  @override
  String get id;
  @override
  String get displayName;
  @override
  String get email;
  @override
  String? get photoUrl;
  @override
  String? get bio;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get lastLogin;
  @override
  int get totalCompletedVideos;
  @override
  double get totalEarnings;
  @override
  double get totalPaid;
  @override
  int get points;
  @override
  bool get isAdmin;
  @override
  String get preferredLanguage;
  @override
  BankAccountDetails? get bankAccountDetails;

  /// Create a copy of AppUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppUserImplCopyWith<_$AppUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
