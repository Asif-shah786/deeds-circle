// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Payment _$PaymentFromJson(Map<String, dynamic> json) {
  return _Payment.fromJson(json);
}

/// @nodoc
mixin _$Payment {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get requestedAt => throw _privateConstructorUsedError;
  DateTime? get processedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  BankAccountDetails get bankAccountDetails =>
      throw _privateConstructorUsedError;
  String? get adminNotes => throw _privateConstructorUsedError;
  double get minimumThreshold => throw _privateConstructorUsedError;
  int get processingTimeDays => throw _privateConstructorUsedError;

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentCopyWith<Payment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentCopyWith<$Res> {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) then) =
      _$PaymentCopyWithImpl<$Res, Payment>;
  @useResult
  $Res call(
      {String id,
      String userId,
      double amount,
      String status,
      DateTime requestedAt,
      DateTime? processedAt,
      DateTime? completedAt,
      BankAccountDetails bankAccountDetails,
      String? adminNotes,
      double minimumThreshold,
      int processingTimeDays});

  $BankAccountDetailsCopyWith<$Res> get bankAccountDetails;
}

/// @nodoc
class _$PaymentCopyWithImpl<$Res, $Val extends Payment>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? amount = null,
    Object? status = null,
    Object? requestedAt = null,
    Object? processedAt = freezed,
    Object? completedAt = freezed,
    Object? bankAccountDetails = null,
    Object? adminNotes = freezed,
    Object? minimumThreshold = null,
    Object? processingTimeDays = null,
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
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      requestedAt: null == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      processedAt: freezed == processedAt
          ? _value.processedAt
          : processedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bankAccountDetails: null == bankAccountDetails
          ? _value.bankAccountDetails
          : bankAccountDetails // ignore: cast_nullable_to_non_nullable
              as BankAccountDetails,
      adminNotes: freezed == adminNotes
          ? _value.adminNotes
          : adminNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      minimumThreshold: null == minimumThreshold
          ? _value.minimumThreshold
          : minimumThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      processingTimeDays: null == processingTimeDays
          ? _value.processingTimeDays
          : processingTimeDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BankAccountDetailsCopyWith<$Res> get bankAccountDetails {
    return $BankAccountDetailsCopyWith<$Res>(_value.bankAccountDetails,
        (value) {
      return _then(_value.copyWith(bankAccountDetails: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PaymentImplCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$$PaymentImplCopyWith(
          _$PaymentImpl value, $Res Function(_$PaymentImpl) then) =
      __$$PaymentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      double amount,
      String status,
      DateTime requestedAt,
      DateTime? processedAt,
      DateTime? completedAt,
      BankAccountDetails bankAccountDetails,
      String? adminNotes,
      double minimumThreshold,
      int processingTimeDays});

  @override
  $BankAccountDetailsCopyWith<$Res> get bankAccountDetails;
}

/// @nodoc
class __$$PaymentImplCopyWithImpl<$Res>
    extends _$PaymentCopyWithImpl<$Res, _$PaymentImpl>
    implements _$$PaymentImplCopyWith<$Res> {
  __$$PaymentImplCopyWithImpl(
      _$PaymentImpl _value, $Res Function(_$PaymentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? amount = null,
    Object? status = null,
    Object? requestedAt = null,
    Object? processedAt = freezed,
    Object? completedAt = freezed,
    Object? bankAccountDetails = null,
    Object? adminNotes = freezed,
    Object? minimumThreshold = null,
    Object? processingTimeDays = null,
  }) {
    return _then(_$PaymentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      requestedAt: null == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      processedAt: freezed == processedAt
          ? _value.processedAt
          : processedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bankAccountDetails: null == bankAccountDetails
          ? _value.bankAccountDetails
          : bankAccountDetails // ignore: cast_nullable_to_non_nullable
              as BankAccountDetails,
      adminNotes: freezed == adminNotes
          ? _value.adminNotes
          : adminNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      minimumThreshold: null == minimumThreshold
          ? _value.minimumThreshold
          : minimumThreshold // ignore: cast_nullable_to_non_nullable
              as double,
      processingTimeDays: null == processingTimeDays
          ? _value.processingTimeDays
          : processingTimeDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentImpl implements _Payment {
  const _$PaymentImpl(
      {required this.id,
      required this.userId,
      required this.amount,
      required this.status,
      required this.requestedAt,
      this.processedAt,
      this.completedAt,
      required this.bankAccountDetails,
      this.adminNotes,
      required this.minimumThreshold,
      required this.processingTimeDays});

  factory _$PaymentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final double amount;
  @override
  final String status;
  @override
  final DateTime requestedAt;
  @override
  final DateTime? processedAt;
  @override
  final DateTime? completedAt;
  @override
  final BankAccountDetails bankAccountDetails;
  @override
  final String? adminNotes;
  @override
  final double minimumThreshold;
  @override
  final int processingTimeDays;

  @override
  String toString() {
    return 'Payment(id: $id, userId: $userId, amount: $amount, status: $status, requestedAt: $requestedAt, processedAt: $processedAt, completedAt: $completedAt, bankAccountDetails: $bankAccountDetails, adminNotes: $adminNotes, minimumThreshold: $minimumThreshold, processingTimeDays: $processingTimeDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.bankAccountDetails, bankAccountDetails) ||
                other.bankAccountDetails == bankAccountDetails) &&
            (identical(other.adminNotes, adminNotes) ||
                other.adminNotes == adminNotes) &&
            (identical(other.minimumThreshold, minimumThreshold) ||
                other.minimumThreshold == minimumThreshold) &&
            (identical(other.processingTimeDays, processingTimeDays) ||
                other.processingTimeDays == processingTimeDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      amount,
      status,
      requestedAt,
      processedAt,
      completedAt,
      bankAccountDetails,
      adminNotes,
      minimumThreshold,
      processingTimeDays);

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      __$$PaymentImplCopyWithImpl<_$PaymentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentImplToJson(
      this,
    );
  }
}

abstract class _Payment implements Payment {
  const factory _Payment(
      {required final String id,
      required final String userId,
      required final double amount,
      required final String status,
      required final DateTime requestedAt,
      final DateTime? processedAt,
      final DateTime? completedAt,
      required final BankAccountDetails bankAccountDetails,
      final String? adminNotes,
      required final double minimumThreshold,
      required final int processingTimeDays}) = _$PaymentImpl;

  factory _Payment.fromJson(Map<String, dynamic> json) = _$PaymentImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  double get amount;
  @override
  String get status;
  @override
  DateTime get requestedAt;
  @override
  DateTime? get processedAt;
  @override
  DateTime? get completedAt;
  @override
  BankAccountDetails get bankAccountDetails;
  @override
  String? get adminNotes;
  @override
  double get minimumThreshold;
  @override
  int get processingTimeDays;

  /// Create a copy of Payment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentImplCopyWith<_$PaymentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PaymentLog _$PaymentLogFromJson(Map<String, dynamic> json) {
  return _PaymentLog.fromJson(json);
}

/// @nodoc
mixin _$PaymentLog {
  String get id => throw _privateConstructorUsedError;
  String get paymentId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  String? get previousStatus => throw _privateConstructorUsedError;
  String? get newStatus => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String? get adminId => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this PaymentLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaymentLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaymentLogCopyWith<PaymentLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentLogCopyWith<$Res> {
  factory $PaymentLogCopyWith(
          PaymentLog value, $Res Function(PaymentLog) then) =
      _$PaymentLogCopyWithImpl<$Res, PaymentLog>;
  @useResult
  $Res call(
      {String id,
      String paymentId,
      String userId,
      String action,
      String? previousStatus,
      String? newStatus,
      double amount,
      String? adminId,
      String? notes,
      DateTime timestamp,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$PaymentLogCopyWithImpl<$Res, $Val extends PaymentLog>
    implements $PaymentLogCopyWith<$Res> {
  _$PaymentLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaymentLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? paymentId = null,
    Object? userId = null,
    Object? action = null,
    Object? previousStatus = freezed,
    Object? newStatus = freezed,
    Object? amount = null,
    Object? adminId = freezed,
    Object? notes = freezed,
    Object? timestamp = null,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      previousStatus: freezed == previousStatus
          ? _value.previousStatus
          : previousStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      newStatus: freezed == newStatus
          ? _value.newStatus
          : newStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      adminId: freezed == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PaymentLogImplCopyWith<$Res>
    implements $PaymentLogCopyWith<$Res> {
  factory _$$PaymentLogImplCopyWith(
          _$PaymentLogImpl value, $Res Function(_$PaymentLogImpl) then) =
      __$$PaymentLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String paymentId,
      String userId,
      String action,
      String? previousStatus,
      String? newStatus,
      double amount,
      String? adminId,
      String? notes,
      DateTime timestamp,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$PaymentLogImplCopyWithImpl<$Res>
    extends _$PaymentLogCopyWithImpl<$Res, _$PaymentLogImpl>
    implements _$$PaymentLogImplCopyWith<$Res> {
  __$$PaymentLogImplCopyWithImpl(
      _$PaymentLogImpl _value, $Res Function(_$PaymentLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of PaymentLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? paymentId = null,
    Object? userId = null,
    Object? action = null,
    Object? previousStatus = freezed,
    Object? newStatus = freezed,
    Object? amount = null,
    Object? adminId = freezed,
    Object? notes = freezed,
    Object? timestamp = null,
    Object? metadata = freezed,
  }) {
    return _then(_$PaymentLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      paymentId: null == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      previousStatus: freezed == previousStatus
          ? _value.previousStatus
          : previousStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      newStatus: freezed == newStatus
          ? _value.newStatus
          : newStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      adminId: freezed == adminId
          ? _value.adminId
          : adminId // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PaymentLogImpl implements _PaymentLog {
  const _$PaymentLogImpl(
      {required this.id,
      required this.paymentId,
      required this.userId,
      required this.action,
      this.previousStatus,
      this.newStatus,
      required this.amount,
      this.adminId,
      this.notes,
      required this.timestamp,
      final Map<String, dynamic>? metadata})
      : _metadata = metadata;

  factory _$PaymentLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaymentLogImplFromJson(json);

  @override
  final String id;
  @override
  final String paymentId;
  @override
  final String userId;
  @override
  final String action;
  @override
  final String? previousStatus;
  @override
  final String? newStatus;
  @override
  final double amount;
  @override
  final String? adminId;
  @override
  final String? notes;
  @override
  final DateTime timestamp;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'PaymentLog(id: $id, paymentId: $paymentId, userId: $userId, action: $action, previousStatus: $previousStatus, newStatus: $newStatus, amount: $amount, adminId: $adminId, notes: $notes, timestamp: $timestamp, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaymentLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.previousStatus, previousStatus) ||
                other.previousStatus == previousStatus) &&
            (identical(other.newStatus, newStatus) ||
                other.newStatus == newStatus) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      paymentId,
      userId,
      action,
      previousStatus,
      newStatus,
      amount,
      adminId,
      notes,
      timestamp,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of PaymentLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaymentLogImplCopyWith<_$PaymentLogImpl> get copyWith =>
      __$$PaymentLogImplCopyWithImpl<_$PaymentLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaymentLogImplToJson(
      this,
    );
  }
}

abstract class _PaymentLog implements PaymentLog {
  const factory _PaymentLog(
      {required final String id,
      required final String paymentId,
      required final String userId,
      required final String action,
      final String? previousStatus,
      final String? newStatus,
      required final double amount,
      final String? adminId,
      final String? notes,
      required final DateTime timestamp,
      final Map<String, dynamic>? metadata}) = _$PaymentLogImpl;

  factory _PaymentLog.fromJson(Map<String, dynamic> json) =
      _$PaymentLogImpl.fromJson;

  @override
  String get id;
  @override
  String get paymentId;
  @override
  String get userId;
  @override
  String get action;
  @override
  String? get previousStatus;
  @override
  String? get newStatus;
  @override
  double get amount;
  @override
  String? get adminId;
  @override
  String? get notes;
  @override
  DateTime get timestamp;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of PaymentLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaymentLogImplCopyWith<_$PaymentLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
