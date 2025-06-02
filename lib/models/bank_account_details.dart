import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank_account_details.freezed.dart';
part 'bank_account_details.g.dart';

@freezed
class BankAccountDetails with _$BankAccountDetails {
  const factory BankAccountDetails({
    required String bankName,
    required String accountNumber,
    required String ifscCode,
    required String accountHolderName,
    required bool isVerified,
  }) = _BankAccountDetails;

  factory BankAccountDetails.fromJson(Map<String, dynamic> json) => _$BankAccountDetailsFromJson(json);
}
