class TransactionEntity {
  final double amount;
  final String type;
  final String date;
  final String counterparty;

  TransactionEntity({
    required this.amount,
    required this.type,
    required this.date,
    required this.counterparty,
  });

  factory TransactionEntity.fromJson(Map<String, dynamic> json) {
    return TransactionEntity(
      amount: (json['amount'] as num).toDouble(),
      type: json['type'],
      date: json['date'],
      counterparty: json['counterparty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
      "type": type,
      "date": date,
      "counterparty": counterparty,
    };
  }
}
