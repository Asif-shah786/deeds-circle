// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserChallenge _$UserChallengeFromJson(Map<String, dynamic> json) {
  return _UserChallenge.fromJson(json);
}

/// @nodoc
mixin _$UserChallenge {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get challengeId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  List<String> get completedVideoIds => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get lastUpdated => throw _privateConstructorUsedError;
  double get paidAmount => throw _privateConstructorUsedError;
  int get streakDays => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get joinedAt => throw _privateConstructorUsedError;
  double get earnedAmount => throw _privateConstructorUsedError;
  LastCompletedVideo? get lastCompletedVideo =>
      throw _privateConstructorUsedError;

  /// Serializes this UserChallenge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserChallengeCopyWith<UserChallenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserChallengeCopyWith<$Res> {
  factory $UserChallengeCopyWith(
          UserChallenge value, $Res Function(UserChallenge) then) =
      _$UserChallengeCopyWithImpl<$Res, UserChallenge>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String challengeId,
      String status,
      List<String> completedVideoIds,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime lastUpdated,
      double paidAmount,
      int streakDays,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime joinedAt,
      double earnedAmount,
      LastCompletedVideo? lastCompletedVideo});

  $LastCompletedVideoCopyWith<$Res>? get lastCompletedVideo;
}

/// @nodoc
class _$UserChallengeCopyWithImpl<$Res, $Val extends UserChallenge>
    implements $UserChallengeCopyWith<$Res> {
  _$UserChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserChallenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? challengeId = null,
    Object? status = null,
    Object? completedVideoIds = null,
    Object? lastUpdated = null,
    Object? paidAmount = null,
    Object? streakDays = null,
    Object? joinedAt = null,
    Object? earnedAmount = null,
    Object? lastCompletedVideo = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      completedVideoIds: null == completedVideoIds
          ? _value.completedVideoIds
          : completedVideoIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double,
      streakDays: null == streakDays
          ? _value.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      earnedAmount: null == earnedAmount
          ? _value.earnedAmount
          : earnedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      lastCompletedVideo: freezed == lastCompletedVideo
          ? _value.lastCompletedVideo
          : lastCompletedVideo // ignore: cast_nullable_to_non_nullable
              as LastCompletedVideo?,
    ) as $Val);
  }

  /// Create a copy of UserChallenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastCompletedVideoCopyWith<$Res>? get lastCompletedVideo {
    if (_value.lastCompletedVideo == null) {
      return null;
    }

    return $LastCompletedVideoCopyWith<$Res>(_value.lastCompletedVideo!,
        (value) {
      return _then(_value.copyWith(lastCompletedVideo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserChallengeImplCopyWith<$Res>
    implements $UserChallengeCopyWith<$Res> {
  factory _$$UserChallengeImplCopyWith(
          _$UserChallengeImpl value, $Res Function(_$UserChallengeImpl) then) =
      __$$UserChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String challengeId,
      String status,
      List<String> completedVideoIds,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime lastUpdated,
      double paidAmount,
      int streakDays,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime joinedAt,
      double earnedAmount,
      LastCompletedVideo? lastCompletedVideo});

  @override
  $LastCompletedVideoCopyWith<$Res>? get lastCompletedVideo;
}

/// @nodoc
class __$$UserChallengeImplCopyWithImpl<$Res>
    extends _$UserChallengeCopyWithImpl<$Res, _$UserChallengeImpl>
    implements _$$UserChallengeImplCopyWith<$Res> {
  __$$UserChallengeImplCopyWithImpl(
      _$UserChallengeImpl _value, $Res Function(_$UserChallengeImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserChallenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? challengeId = null,
    Object? status = null,
    Object? completedVideoIds = null,
    Object? lastUpdated = null,
    Object? paidAmount = null,
    Object? streakDays = null,
    Object? joinedAt = null,
    Object? earnedAmount = null,
    Object? lastCompletedVideo = freezed,
  }) {
    return _then(_$UserChallengeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      completedVideoIds: null == completedVideoIds
          ? _value._completedVideoIds
          : completedVideoIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastUpdated: null == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paidAmount: null == paidAmount
          ? _value.paidAmount
          : paidAmount // ignore: cast_nullable_to_non_nullable
              as double,
      streakDays: null == streakDays
          ? _value.streakDays
          : streakDays // ignore: cast_nullable_to_non_nullable
              as int,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      earnedAmount: null == earnedAmount
          ? _value.earnedAmount
          : earnedAmount // ignore: cast_nullable_to_non_nullable
              as double,
      lastCompletedVideo: freezed == lastCompletedVideo
          ? _value.lastCompletedVideo
          : lastCompletedVideo // ignore: cast_nullable_to_non_nullable
              as LastCompletedVideo?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserChallengeImpl implements _UserChallenge {
  const _$UserChallengeImpl(
      {required this.id,
      required this.userId,
      required this.challengeId,
      required this.status,
      required final List<String> completedVideoIds,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.lastUpdated,
      required this.paidAmount,
      required this.streakDays,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.joinedAt,
      required this.earnedAmount,
      this.lastCompletedVideo})
      : _completedVideoIds = completedVideoIds;

  factory _$UserChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserChallengeImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String challengeId;
  @override
  final String status;
  final List<String> _completedVideoIds;
  @override
  List<String> get completedVideoIds {
    if (_completedVideoIds is EqualUnmodifiableListView)
      return _completedVideoIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_completedVideoIds);
  }

  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime lastUpdated;
  @override
  final double paidAmount;
  @override
  final int streakDays;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime joinedAt;
  @override
  final double earnedAmount;
  @override
  final LastCompletedVideo? lastCompletedVideo;

  @override
  String toString() {
    return 'UserChallenge(id: $id, userId: $userId, challengeId: $challengeId, status: $status, completedVideoIds: $completedVideoIds, lastUpdated: $lastUpdated, paidAmount: $paidAmount, streakDays: $streakDays, joinedAt: $joinedAt, earnedAmount: $earnedAmount, lastCompletedVideo: $lastCompletedVideo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._completedVideoIds, _completedVideoIds) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.paidAmount, paidAmount) ||
                other.paidAmount == paidAmount) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.earnedAmount, earnedAmount) ||
                other.earnedAmount == earnedAmount) &&
            (identical(other.lastCompletedVideo, lastCompletedVideo) ||
                other.lastCompletedVideo == lastCompletedVideo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      challengeId,
      status,
      const DeepCollectionEquality().hash(_completedVideoIds),
      lastUpdated,
      paidAmount,
      streakDays,
      joinedAt,
      earnedAmount,
      lastCompletedVideo);

  /// Create a copy of UserChallenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserChallengeImplCopyWith<_$UserChallengeImpl> get copyWith =>
      __$$UserChallengeImplCopyWithImpl<_$UserChallengeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserChallengeImplToJson(
      this,
    );
  }
}

abstract class _UserChallenge implements UserChallenge {
  const factory _UserChallenge(
      {required final String id,
      required final String userId,
      required final String challengeId,
      required final String status,
      required final List<String> completedVideoIds,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime lastUpdated,
      required final double paidAmount,
      required final int streakDays,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime joinedAt,
      required final double earnedAmount,
      final LastCompletedVideo? lastCompletedVideo}) = _$UserChallengeImpl;

  factory _UserChallenge.fromJson(Map<String, dynamic> json) =
      _$UserChallengeImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get challengeId;
  @override
  String get status;
  @override
  List<String> get completedVideoIds;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get lastUpdated;
  @override
  double get paidAmount;
  @override
  int get streakDays;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get joinedAt;
  @override
  double get earnedAmount;
  @override
  LastCompletedVideo? get lastCompletedVideo;

  /// Create a copy of UserChallenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserChallengeImplCopyWith<_$UserChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LastCompletedVideo _$LastCompletedVideoFromJson(Map<String, dynamic> json) {
  return _LastCompletedVideo.fromJson(json);
}

/// @nodoc
mixin _$LastCompletedVideo {
  String get videoId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get completedAt => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;

  /// Serializes this LastCompletedVideo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LastCompletedVideo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LastCompletedVideoCopyWith<LastCompletedVideo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LastCompletedVideoCopyWith<$Res> {
  factory $LastCompletedVideoCopyWith(
          LastCompletedVideo value, $Res Function(LastCompletedVideo) then) =
      _$LastCompletedVideoCopyWithImpl<$Res, LastCompletedVideo>;
  @useResult
  $Res call(
      {String videoId,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime completedAt,
      String title});
}

/// @nodoc
class _$LastCompletedVideoCopyWithImpl<$Res, $Val extends LastCompletedVideo>
    implements $LastCompletedVideoCopyWith<$Res> {
  _$LastCompletedVideoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LastCompletedVideo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? completedAt = null,
    Object? title = null,
  }) {
    return _then(_value.copyWith(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LastCompletedVideoImplCopyWith<$Res>
    implements $LastCompletedVideoCopyWith<$Res> {
  factory _$$LastCompletedVideoImplCopyWith(_$LastCompletedVideoImpl value,
          $Res Function(_$LastCompletedVideoImpl) then) =
      __$$LastCompletedVideoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String videoId,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime completedAt,
      String title});
}

/// @nodoc
class __$$LastCompletedVideoImplCopyWithImpl<$Res>
    extends _$LastCompletedVideoCopyWithImpl<$Res, _$LastCompletedVideoImpl>
    implements _$$LastCompletedVideoImplCopyWith<$Res> {
  __$$LastCompletedVideoImplCopyWithImpl(_$LastCompletedVideoImpl _value,
      $Res Function(_$LastCompletedVideoImpl) _then)
      : super(_value, _then);

  /// Create a copy of LastCompletedVideo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoId = null,
    Object? completedAt = null,
    Object? title = null,
  }) {
    return _then(_$LastCompletedVideoImpl(
      videoId: null == videoId
          ? _value.videoId
          : videoId // ignore: cast_nullable_to_non_nullable
              as String,
      completedAt: null == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LastCompletedVideoImpl implements _LastCompletedVideo {
  const _$LastCompletedVideoImpl(
      {required this.videoId,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.completedAt,
      required this.title});

  factory _$LastCompletedVideoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LastCompletedVideoImplFromJson(json);

  @override
  final String videoId;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime completedAt;
  @override
  final String title;

  @override
  String toString() {
    return 'LastCompletedVideo(videoId: $videoId, completedAt: $completedAt, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LastCompletedVideoImpl &&
            (identical(other.videoId, videoId) || other.videoId == videoId) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, videoId, completedAt, title);

  /// Create a copy of LastCompletedVideo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LastCompletedVideoImplCopyWith<_$LastCompletedVideoImpl> get copyWith =>
      __$$LastCompletedVideoImplCopyWithImpl<_$LastCompletedVideoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LastCompletedVideoImplToJson(
      this,
    );
  }
}

abstract class _LastCompletedVideo implements LastCompletedVideo {
  const factory _LastCompletedVideo(
      {required final String videoId,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime completedAt,
      required final String title}) = _$LastCompletedVideoImpl;

  factory _LastCompletedVideo.fromJson(Map<String, dynamic> json) =
      _$LastCompletedVideoImpl.fromJson;

  @override
  String get videoId;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get completedAt;
  @override
  String get title;

  /// Create a copy of LastCompletedVideo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LastCompletedVideoImplCopyWith<_$LastCompletedVideoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
