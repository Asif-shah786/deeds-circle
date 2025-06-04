// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank_account_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BankAccountDetails _$BankAccountDetailsFromJson(Map<String, dynamic> json) {
  return _BankAccountDetails.fromJson(json);
}

/// @nodoc
mixin _$BankAccountDetails {
  String get bankName => throw _privateConstructorUsedError;
  String get accountHolderName => throw _privateConstructorUsedError;
  String get accountNumber => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;

  /// Serializes this BankAccountDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BankAccountDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BankAccountDetailsCopyWith<BankAccountDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BankAccountDetailsCopyWith<$Res> {
  factory $BankAccountDetailsCopyWith(
          BankAccountDetails value, $Res Function(BankAccountDetails) then) =
      _$BankAccountDetailsCopyWithImpl<$Res, BankAccountDetails>;
  @useResult
  $Res call(
      {String bankName,
      String accountHolderName,
      String accountNumber,
      bool isVerified});
}

/// @nodoc
class _$BankAccountDetailsCopyWithImpl<$Res, $Val extends BankAccountDetails>
    implements $BankAccountDetailsCopyWith<$Res> {
  _$BankAccountDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BankAccountDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankName = null,
    Object? accountHolderName = null,
    Object? accountNumber = null,
    Object? isVerified = null,
  }) {
    return _then(_value.copyWith(
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      accountHolderName: null == accountHolderName
          ? _value.accountHolderName
          : accountHolderName // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BankAccountDetailsImplCopyWith<$Res>
    implements $BankAccountDetailsCopyWith<$Res> {
  factory _$$BankAccountDetailsImplCopyWith(_$BankAccountDetailsImpl value,
          $Res Function(_$BankAccountDetailsImpl) then) =
      __$$BankAccountDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String bankName,
      String accountHolderName,
      String accountNumber,
      bool isVerified});
}

/// @nodoc
class __$$BankAccountDetailsImplCopyWithImpl<$Res>
    extends _$BankAccountDetailsCopyWithImpl<$Res, _$BankAccountDetailsImpl>
    implements _$$BankAccountDetailsImplCopyWith<$Res> {
  __$$BankAccountDetailsImplCopyWithImpl(_$BankAccountDetailsImpl _value,
      $Res Function(_$BankAccountDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of BankAccountDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bankName = null,
    Object? accountHolderName = null,
    Object? accountNumber = null,
    Object? isVerified = null,
  }) {
    return _then(_$BankAccountDetailsImpl(
      bankName: null == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String,
      accountHolderName: null == accountHolderName
          ? _value.accountHolderName
          : accountHolderName // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BankAccountDetailsImpl implements _BankAccountDetails {
  const _$BankAccountDetailsImpl(
      {required this.bankName,
      required this.accountHolderName,
      required this.accountNumber,
      required this.isVerified});

  factory _$BankAccountDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$BankAccountDetailsImplFromJson(json);

  @override
  final String bankName;
  @override
  final String accountHolderName;
  @override
  final String accountNumber;
  @override
  final bool isVerified;

  @override
  String toString() {
    return 'BankAccountDetails(bankName: $bankName, accountHolderName: $accountHolderName, accountNumber: $accountNumber, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BankAccountDetailsImpl &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.accountHolderName, accountHolderName) ||
                other.accountHolderName == accountHolderName) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, bankName, accountHolderName, accountNumber, isVerified);

  /// Create a copy of BankAccountDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BankAccountDetailsImplCopyWith<_$BankAccountDetailsImpl> get copyWith =>
      __$$BankAccountDetailsImplCopyWithImpl<_$BankAccountDetailsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BankAccountDetailsImplToJson(
      this,
    );
  }
}

abstract class _BankAccountDetails implements BankAccountDetails {
  const factory _BankAccountDetails(
      {required final String bankName,
      required final String accountHolderName,
      required final String accountNumber,
      required final bool isVerified}) = _$BankAccountDetailsImpl;

  factory _BankAccountDetails.fromJson(Map<String, dynamic> json) =
      _$BankAccountDetailsImpl.fromJson;

  @override
  String get bankName;
  @override
  String get accountHolderName;
  @override
  String get accountNumber;
  @override
  bool get isVerified;

  /// Create a copy of BankAccountDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BankAccountDetailsImplCopyWith<_$BankAccountDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
