// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankAccountDetailsImpl _$$BankAccountDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$BankAccountDetailsImpl(
      bankName: json['bankName'] as String,
      accountHolderName: json['accountHolderName'] as String,
      accountNumber: json['accountNumber'] as String,
      isVerified: json['isVerified'] as bool,
    );

Map<String, dynamic> _$$BankAccountDetailsImplToJson(
        _$BankAccountDetailsImpl instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'accountHolderName': instance.accountHolderName,
      'accountNumber': instance.accountNumber,
      'isVerified': instance.isVerified,
    };
