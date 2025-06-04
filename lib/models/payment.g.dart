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
      requestedAt: _timestampFromJson(json['requestedAt']),
      processedAt: _timestampFromJson(json['processedAt']),
      completedAt: _timestampFromJson(json['completedAt']),
      bankAccountDetails: BankAccountDetails.fromJson(
          json['bankAccountDetails'] as Map<String, dynamic>),
      adminNote: json['adminNote'] as String?,
      minimumThreshold: (json['minimumThreshold'] as num).toDouble(),
      processingTimeDays: (json['processingTimeDays'] as num).toInt(),
      processedBy: json['processedBy'] as String?,
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'amount': instance.amount,
      'status': instance.status,
      'requestedAt': _timestampToJson(instance.requestedAt),
      'processedAt': _timestampToJson(instance.processedAt),
      'completedAt': _timestampToJson(instance.completedAt),
      'bankAccountDetails': instance.bankAccountDetails.toJson(),
      'adminNote': instance.adminNote,
      'minimumThreshold': instance.minimumThreshold,
      'processingTimeDays': instance.processingTimeDays,
      'processedBy': instance.processedBy,
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
      timestamp: _timestampFromJson(json['timestamp']),
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
      'timestamp': _timestampToJson(instance.timestamp),
      'metadata': instance.metadata,
    };
