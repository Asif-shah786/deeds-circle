// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_account_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BankAccountDetailsImpl _$$BankAccountDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$BankAccountDetailsImpl(
      bankName: json['bankName'] as String,
      accountNumber: json['accountNumber'] as String,
      ifscCode: json['ifscCode'] as String,
      accountHolderName: json['accountHolderName'] as String,
      isVerified: json['isVerified'] as bool,
    );

Map<String, dynamic> _$$BankAccountDetailsImplToJson(
        _$BankAccountDetailsImpl instance) =>
    <String, dynamic>{
      'bankName': instance.bankName,
      'accountNumber': instance.accountNumber,
      'ifscCode': instance.ifscCode,
      'accountHolderName': instance.accountHolderName,
      'isVerified': instance.isVerified,
    };
