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
    required DateTime requestedAt,
    DateTime? processedAt,
    DateTime? completedAt,
    required BankAccountDetails bankAccountDetails,
    String? adminNotes,
    required double minimumThreshold,
    required int processingTimeDays,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  factory Payment.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Payment.fromJson({
      'id': doc.id,
      ...data,
      'requestedAt': (data['requestedAt'] as Timestamp).toDate().toIso8601String(),
      if (data['processedAt'] != null) 'processedAt': (data['processedAt'] as Timestamp).toDate().toIso8601String(),
      if (data['completedAt'] != null) 'completedAt': (data['completedAt'] as Timestamp).toDate().toIso8601String(),
    });
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
    required DateTime timestamp,
    Map<String, dynamic>? metadata,
  }) = _PaymentLog;

  factory PaymentLog.fromJson(Map<String, dynamic> json) => _$PaymentLogFromJson(json);

  factory PaymentLog.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PaymentLog.fromJson({
      'id': doc.id,
      ...data,
      'timestamp': (data['timestamp'] as Timestamp).toDate().toIso8601String(),
    });
  }
}
