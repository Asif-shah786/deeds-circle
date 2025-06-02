// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      amount: (json['amount'] as num).toDouble(),
      status: json['status'] as String,
      requestedAt: DateTime.parse(json['requestedAt'] as String),
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      bankAccountDetails: BankAccountDetails.fromJson(
          json['bankAccountDetails'] as Map<String, dynamic>),
      adminNotes: json['adminNotes'] as String?,
      minimumThreshold: (json['minimumThreshold'] as num).toDouble(),
      processingTimeDays: (json['processingTimeDays'] as num).toInt(),
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'status': instance.status,
      'requestedAt': instance.requestedAt.toIso8601String(),
      'processedAt': instance.processedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'bankAccountDetails': instance.bankAccountDetails.toJson(),
      'adminNotes': instance.adminNotes,
      'minimumThreshold': instance.minimumThreshold,
      'processingTimeDays': instance.processingTimeDays,
    };

_$PaymentLogImpl _$$PaymentLogImplFromJson(Map<String, dynamic> json) =>
    _$PaymentLogImpl(
      id: json['id'] as String,
      paymentId: json['paymentId'] as String,
      userId: json['userId'] as String,
      action: json['action'] as String,
      previousStatus: json['previousStatus'] as String?,
      newStatus: json['newStatus'] as String?,
      amount: (json['amount'] as num).toDouble(),
      adminId: json['adminId'] as String?,
      notes: json['notes'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$PaymentLogImplToJson(_$PaymentLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentId': instance.paymentId,
      'userId': instance.userId,
      'action': instance.action,
      'previousStatus': instance.previousStatus,
      'newStatus': instance.newStatus,
      'amount': instance.amount,
      'adminId': instance.adminId,
      'notes': instance.notes,
      'timestamp': instance.timestamp.toIso8601String(),
      'metadata': instance.metadata,
    };
