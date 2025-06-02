// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_role.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminRole _$AdminRoleFromJson(Map<String, dynamic> json) {
  return _AdminRole.fromJson(json);
}

/// @nodoc
mixin _$AdminRole {
  String get id => throw _privateConstructorUsedError;
  String get challengeId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;
  DateTime get assignedAt => throw _privateConstructorUsedError;
  String get assignedBy => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get lastActive => throw _privateConstructorUsedError;

  /// Serializes this AdminRole to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminRoleCopyWith<AdminRole> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminRoleCopyWith<$Res> {
  factory $AdminRoleCopyWith(AdminRole value, $Res Function(AdminRole) then) =
      _$AdminRoleCopyWithImpl<$Res, AdminRole>;
  @useResult
  $Res call(
      {String id,
      String challengeId,
      String userId,
      String role,
      List<String> permissions,
      DateTime assignedAt,
      String assignedBy,
      bool isActive,
      DateTime? lastActive});
}

/// @nodoc
class _$AdminRoleCopyWithImpl<$Res, $Val extends AdminRole>
    implements $AdminRoleCopyWith<$Res> {
  _$AdminRoleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challengeId = null,
    Object? userId = null,
    Object? role = null,
    Object? permissions = null,
    Object? assignedAt = null,
    Object? assignedBy = null,
    Object? isActive = null,
    Object? lastActive = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value.permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      assignedAt: null == assignedAt
          ? _value.assignedAt
          : assignedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assignedBy: null == assignedBy
          ? _value.assignedBy
          : assignedBy // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminRoleImplCopyWith<$Res>
    implements $AdminRoleCopyWith<$Res> {
  factory _$$AdminRoleImplCopyWith(
          _$AdminRoleImpl value, $Res Function(_$AdminRoleImpl) then) =
      __$$AdminRoleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String challengeId,
      String userId,
      String role,
      List<String> permissions,
      DateTime assignedAt,
      String assignedBy,
      bool isActive,
      DateTime? lastActive});
}

/// @nodoc
class __$$AdminRoleImplCopyWithImpl<$Res>
    extends _$AdminRoleCopyWithImpl<$Res, _$AdminRoleImpl>
    implements _$$AdminRoleImplCopyWith<$Res> {
  __$$AdminRoleImplCopyWithImpl(
      _$AdminRoleImpl _value, $Res Function(_$AdminRoleImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminRole
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? challengeId = null,
    Object? userId = null,
    Object? role = null,
    Object? permissions = null,
    Object? assignedAt = null,
    Object? assignedBy = null,
    Object? isActive = null,
    Object? lastActive = freezed,
  }) {
    return _then(_$AdminRoleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      challengeId: null == challengeId
          ? _value.challengeId
          : challengeId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      assignedAt: null == assignedAt
          ? _value.assignedAt
          : assignedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      assignedBy: null == assignedBy
          ? _value.assignedBy
          : assignedBy // ignore: cast_nullable_to_non_nullable
              as String,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      lastActive: freezed == lastActive
          ? _value.lastActive
          : lastActive // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminRoleImpl implements _AdminRole {
  const _$AdminRoleImpl(
      {required this.id,
      required this.challengeId,
      required this.userId,
      required this.role,
      required final List<String> permissions,
      required this.assignedAt,
      required this.assignedBy,
      required this.isActive,
      this.lastActive})
      : _permissions = permissions;

  factory _$AdminRoleImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminRoleImplFromJson(json);

  @override
  final String id;
  @override
  final String challengeId;
  @override
  final String userId;
  @override
  final String role;
  final List<String> _permissions;
  @override
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  final DateTime assignedAt;
  @override
  final String assignedBy;
  @override
  final bool isActive;
  @override
  final DateTime? lastActive;

  @override
  String toString() {
    return 'AdminRole(id: $id, challengeId: $challengeId, userId: $userId, role: $role, permissions: $permissions, assignedAt: $assignedAt, assignedBy: $assignedBy, isActive: $isActive, lastActive: $lastActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminRoleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.challengeId, challengeId) ||
                other.challengeId == challengeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.assignedAt, assignedAt) ||
                other.assignedAt == assignedAt) &&
            (identical(other.assignedBy, assignedBy) ||
                other.assignedBy == assignedBy) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      challengeId,
      userId,
      role,
      const DeepCollectionEquality().hash(_permissions),
      assignedAt,
      assignedBy,
      isActive,
      lastActive);

  /// Create a copy of AdminRole
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminRoleImplCopyWith<_$AdminRoleImpl> get copyWith =>
      __$$AdminRoleImplCopyWithImpl<_$AdminRoleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminRoleImplToJson(
      this,
    );
  }
}

abstract class _AdminRole implements AdminRole {
  const factory _AdminRole(
      {required final String id,
      required final String challengeId,
      required final String userId,
      required final String role,
      required final List<String> permissions,
      required final DateTime assignedAt,
      required final String assignedBy,
      required final bool isActive,
      final DateTime? lastActive}) = _$AdminRoleImpl;

  factory _AdminRole.fromJson(Map<String, dynamic> json) =
      _$AdminRoleImpl.fromJson;

  @override
  String get id;
  @override
  String get challengeId;
  @override
  String get userId;
  @override
  String get role;
  @override
  List<String> get permissions;
  @override
  DateTime get assignedAt;
  @override
  String get assignedBy;
  @override
  bool get isActive;
  @override
  DateTime? get lastActive;

  /// Create a copy of AdminRole
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminRoleImplCopyWith<_$AdminRoleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
