import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bank_account_details.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    required String userId,
    required double amount,
    required String status,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required DateTime requestedAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? processedAt,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) DateTime? completedAt,
    required BankAccountDetails bankAccountDetails,
    String? adminNote,
    required double minimumThreshold,
    required int processingTimeDays,
    String? processedBy,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  factory Payment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Payment.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}

extension PaymentFirestore on Payment {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    return {
      ...json,
      'requestedAt': Timestamp.fromDate(requestedAt),
      if (processedAt != null) 'processedAt': Timestamp.fromDate(processedAt!),
      if (completedAt != null) 'completedAt': Timestamp.fromDate(completedAt!),
    };
  }
}

@freezed
class PaymentLog with _$PaymentLog {
  const factory PaymentLog({
    required String id,
    required String paymentId,
    required String userId,
    required String action,
    String? previousStatus,
    String? newStatus,
    required double amount,
    String? adminId,
    String? notes,
    @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson) required DateTime timestamp,
    Map<String, dynamic>? metadata,
  }) = _PaymentLog;

  factory PaymentLog.fromJson(Map<String, dynamic> json) => _$PaymentLogFromJson(json);

  factory PaymentLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PaymentLog.fromJson({
      'id': doc.id,
      ...data,
    });
  }
}

extension PaymentLogFirestore on PaymentLog {
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    return {
      ...json,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}

// Helper functions for DateTime/Timestamp conversion
DateTime _timestampFromJson(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  } else if (timestamp is String) {
    return DateTime.parse(timestamp);
  } else if (timestamp is int) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
  throw ArgumentError('Invalid timestamp format');
}

dynamic _timestampToJson(DateTime? dateTime) {
  if (dateTime == null) return null;
  return Timestamp.fromDate(dateTime);
}
