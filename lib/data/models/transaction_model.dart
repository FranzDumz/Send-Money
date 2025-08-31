import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.counterparty,
    required super.amount,
    required super.date,
    required super.type,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      counterparty: json['counterparty'],
      amount: (json['amount'] as num).toDouble(),
      date: json['date'],
      type: json['type'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'counterparty': counterparty,
      'amount': amount,
      'date': date,
      'type': type,
    };
  }
}
