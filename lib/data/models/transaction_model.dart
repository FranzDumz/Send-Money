import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required String counterparty,
    required double amount,
    required String date,
    required String type,
  }) : super(
    counterparty: counterparty,
    amount: amount,
    date: date,
    type: type,
  );

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      counterparty: json['counterparty'],
      amount: (json['amount'] as num).toDouble(),
      date: json['date'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'counterparty': counterparty,
      'amount': amount,
      'date': date,
      'type': type,
    };
  }
}
