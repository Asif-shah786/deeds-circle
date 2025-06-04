// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'challenge.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Challenge _$ChallengeFromJson(Map<String, dynamic> json) {
  return _Challenge.fromJson(json);
}

/// @nodoc
mixin _$Challenge {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get admins => throw _privateConstructorUsedError;
  String get primaryAdminId => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get updatedAt => throw _privateConstructorUsedError;
  List<String> get keywords => throw _privateConstructorUsedError;
  double get rewardAmount => throw _privateConstructorUsedError;
  int get totalVideos => throw _privateConstructorUsedError;
  double get totalPossibleEarning => throw _privateConstructorUsedError;
  String get purpose => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get startDate => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get endDate => throw _privateConstructorUsedError;

  /// Serializes this Challenge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChallengeCopyWith<Challenge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChallengeCopyWith<$Res> {
  factory $ChallengeCopyWith(Challenge value, $Res Function(Challenge) then) =
      _$ChallengeCopyWithImpl<$Res, Challenge>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      List<String> admins,
      String primaryAdminId,
      bool isPublic,
      String? thumbnailUrl,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime updatedAt,
      List<String> keywords,
      double rewardAmount,
      int totalVideos,
      double totalPossibleEarning,
      String purpose,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? startDate,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? endDate});
}

/// @nodoc
class _$ChallengeCopyWithImpl<$Res, $Val extends Challenge>
    implements $ChallengeCopyWith<$Res> {
  _$ChallengeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? admins = null,
    Object? primaryAdminId = null,
    Object? isPublic = null,
    Object? thumbnailUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? keywords = null,
    Object? rewardAmount = null,
    Object? totalVideos = null,
    Object? totalPossibleEarning = null,
    Object? purpose = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      admins: null == admins
          ? _value.admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<String>,
      primaryAdminId: null == primaryAdminId
          ? _value.primaryAdminId
          : primaryAdminId // ignore: cast_nullable_to_non_nullable
              as String,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      keywords: null == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rewardAmount: null == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalVideos: null == totalVideos
          ? _value.totalVideos
          : totalVideos // ignore: cast_nullable_to_non_nullable
              as int,
      totalPossibleEarning: null == totalPossibleEarning
          ? _value.totalPossibleEarning
          : totalPossibleEarning // ignore: cast_nullable_to_non_nullable
              as double,
      purpose: null == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChallengeImplCopyWith<$Res>
    implements $ChallengeCopyWith<$Res> {
  factory _$$ChallengeImplCopyWith(
          _$ChallengeImpl value, $Res Function(_$ChallengeImpl) then) =
      __$$ChallengeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      List<String> admins,
      String primaryAdminId,
      bool isPublic,
      String? thumbnailUrl,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime updatedAt,
      List<String> keywords,
      double rewardAmount,
      int totalVideos,
      double totalPossibleEarning,
      String purpose,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? startDate,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      DateTime? endDate});
}

/// @nodoc
class __$$ChallengeImplCopyWithImpl<$Res>
    extends _$ChallengeCopyWithImpl<$Res, _$ChallengeImpl>
    implements _$$ChallengeImplCopyWith<$Res> {
  __$$ChallengeImplCopyWithImpl(
      _$ChallengeImpl _value, $Res Function(_$ChallengeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? admins = null,
    Object? primaryAdminId = null,
    Object? isPublic = null,
    Object? thumbnailUrl = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? keywords = null,
    Object? rewardAmount = null,
    Object? totalVideos = null,
    Object? totalPossibleEarning = null,
    Object? purpose = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(_$ChallengeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      admins: null == admins
          ? _value._admins
          : admins // ignore: cast_nullable_to_non_nullable
              as List<String>,
      primaryAdminId: null == primaryAdminId
          ? _value.primaryAdminId
          : primaryAdminId // ignore: cast_nullable_to_non_nullable
              as String,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      thumbnailUrl: freezed == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      keywords: null == keywords
          ? _value._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rewardAmount: null == rewardAmount
          ? _value.rewardAmount
          : rewardAmount // ignore: cast_nullable_to_non_nullable
              as double,
      totalVideos: null == totalVideos
          ? _value.totalVideos
          : totalVideos // ignore: cast_nullable_to_non_nullable
              as int,
      totalPossibleEarning: null == totalPossibleEarning
          ? _value.totalPossibleEarning
          : totalPossibleEarning // ignore: cast_nullable_to_non_nullable
              as double,
      purpose: null == purpose
          ? _value.purpose
          : purpose // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChallengeImpl implements _Challenge {
  const _$ChallengeImpl(
      {required this.id,
      required this.title,
      required this.description,
      required final List<String> admins,
      required this.primaryAdminId,
      required this.isPublic,
      this.thumbnailUrl,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required this.updatedAt,
      required final List<String> keywords,
      required this.rewardAmount,
      required this.totalVideos,
      required this.totalPossibleEarning,
      required this.purpose,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      this.startDate,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      this.endDate})
      : _admins = admins,
        _keywords = keywords;

  factory _$ChallengeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChallengeImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  final List<String> _admins;
  @override
  List<String> get admins {
    if (_admins is EqualUnmodifiableListView) return _admins;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_admins);
  }

  @override
  final String primaryAdminId;
  @override
  final bool isPublic;
  @override
  final String? thumbnailUrl;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime updatedAt;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  final double rewardAmount;
  @override
  final int totalVideos;
  @override
  final double totalPossibleEarning;
  @override
  final String purpose;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime? startDate;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  final DateTime? endDate;

  @override
  String toString() {
    return 'Challenge(id: $id, title: $title, description: $description, admins: $admins, primaryAdminId: $primaryAdminId, isPublic: $isPublic, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt, updatedAt: $updatedAt, keywords: $keywords, rewardAmount: $rewardAmount, totalVideos: $totalVideos, totalPossibleEarning: $totalPossibleEarning, purpose: $purpose, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChallengeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._admins, _admins) &&
            (identical(other.primaryAdminId, primaryAdminId) ||
                other.primaryAdminId == primaryAdminId) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.rewardAmount, rewardAmount) ||
                other.rewardAmount == rewardAmount) &&
            (identical(other.totalVideos, totalVideos) ||
                other.totalVideos == totalVideos) &&
            (identical(other.totalPossibleEarning, totalPossibleEarning) ||
                other.totalPossibleEarning == totalPossibleEarning) &&
            (identical(other.purpose, purpose) || other.purpose == purpose) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      const DeepCollectionEquality().hash(_admins),
      primaryAdminId,
      isPublic,
      thumbnailUrl,
      createdAt,
      updatedAt,
      const DeepCollectionEquality().hash(_keywords),
      rewardAmount,
      totalVideos,
      totalPossibleEarning,
      purpose,
      startDate,
      endDate);

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      __$$ChallengeImplCopyWithImpl<_$ChallengeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChallengeImplToJson(
      this,
    );
  }
}

abstract class _Challenge implements Challenge {
  const factory _Challenge(
      {required final String id,
      required final String title,
      required final String description,
      required final List<String> admins,
      required final String primaryAdminId,
      required final bool isPublic,
      final String? thumbnailUrl,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime createdAt,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      required final DateTime updatedAt,
      required final List<String> keywords,
      required final double rewardAmount,
      required final int totalVideos,
      required final double totalPossibleEarning,
      required final String purpose,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      final DateTime? startDate,
      @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
      final DateTime? endDate}) = _$ChallengeImpl;

  factory _Challenge.fromJson(Map<String, dynamic> json) =
      _$ChallengeImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  List<String> get admins;
  @override
  String get primaryAdminId;
  @override
  bool get isPublic;
  @override
  String? get thumbnailUrl;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get createdAt;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime get updatedAt;
  @override
  List<String> get keywords;
  @override
  double get rewardAmount;
  @override
  int get totalVideos;
  @override
  double get totalPossibleEarning;
  @override
  String get purpose;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get startDate;
  @override
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  DateTime? get endDate;

  /// Create a copy of Challenge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChallengeImplCopyWith<_$ChallengeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
